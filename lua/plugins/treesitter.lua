return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "master",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      modules = {},
      -- 🚀 Bổ sung thêm Dart (Flutter) và Angular vào danh sách của bạn
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "lua",
        "json",
        "html",
        "css",
        "dart", -- Quan trọng cho Flutter
        "angular", -- Quan trọng cho Angular
        "scss",
      },

      sync_install = false,
      auto_install = true,
      ignore_install = {},

      highlight = {
        enable = true,
        -- Giữ nguyên logic xử lý file lớn của bạn
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        -- Ép false để Treesitter nắm quyền highlight (giúp hiện màu xanh lá)
        additional_vim_regex_highlighting = false,
      },

      -- Thêm thụt lề thông minh cho JSX/TSX và Flutter
      indent = { enable = true },
    })

    -- 🔥 DÒNG QUAN TRỌNG NHẤT: Ép Neovim nhận diện đúng Parser cho React
    -- Điều này giúp chữ 'Container' lấy lại màu xanh lá từ bộ giải mã TSX
    vim.treesitter.language.register("tsx", "typescriptreact")
    vim.treesitter.language.register("tsx", "javascriptreact")
  end,
}
