return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim", -- Đã sửa URL mới
      "williamboman/mason-lspconfig.nvim", -- Đã sửa URL mới
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- 1. Lấy capabilities CHUẨN từ blink.cmp (Engine Rust siêu nhanh)
      local capabilities = {}
      local has_blink, blink = pcall(require, "blink.cmp")
      if has_blink then
        capabilities = blink.get_lsp_capabilities()
      end

      -- 2. Danh sách LSP Servers cho Fullstack
      local servers = {
        html = {},
        cssls = {},
        jsonls = {},
        ts_ls = {
          flags = { debounce_text_changes = 150 },
        },
        angularls = {}, -- Hỗ trợ dự án Angular của bạn
        tailwindcss = {
          filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } }, -- Fix lỗi gạch chân vàng
              workspace = { checkThirdParty = false },
            },
          },
        },
      }

      -- 3. Mason Setup (Bo góc rounded đồng bộ theme VS Code)
      require("mason").setup({
        ui = { border = "rounded" },
      })

      -- 4. Tự động cài đặt & Setup LSP (Đã fix lỗi Deprecated/Warning)
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
        handlers = {
          function(server_name)
            -- Bỏ qua dartls vì đã có flutter-tools quản lý riêng
            if server_name == "dartls" then
              return
            end

            local opts = servers[server_name] or {}
            opts.capabilities = capabilities
            -- Sử dụng setup chuẩn để tránh thông báo "lsp.config is deprecated"
            require("lspconfig")[server_name].setup(opts)
          end,
        },
      })

      -- 5. TỰ ĐỘNG CÀI FORMATTERS (Khắc phục việc thiếu prettierd, stylua)
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettierd", -- Format web cực nhanh
          "prettier",
          "stylua", -- Format code Lua của bạn
          "eslint_d", -- Kiểm lỗi JS/TS nhanh
        },
      })

      -- Bật Inlay Hints (Hiện kiểu dữ liệu của biến ngay trong code)
      vim.lsp.inlay_hint.enable(true)
    end,
  },
}
