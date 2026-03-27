return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = { "Function", "Label", "@variable" },

        include = {
          node_type = {
            -- Cấu hình cho JavaScript thuần (.js)
            javascript = {
              "import_statement",
              "export_statement",
              "object",
              "array",
              "statement_block", -- Cho các khối { } trong if, for, function
              "arrow_function", -- Cho các hàm () => { ... }
              "function_declaration", -- Cho hàm function name() { ... }
              "class_body", -- Cho các class
              "switch_statement",
              "try_statement", -- Cho các khối try/catch
            },
            -- Cấu hình cho React JavaScript (.jsx)
            javascriptreact = {
              "import_statement",
              "export_statement",
              "object",
              "array",
              "statement_block",
              "jsx_element", -- Cho các tag <div>...</div>
              "jsx_self_closing_element", -- Cho các tag <img />
              "jsx_expression", -- Cho các khối { } lồng trong HTML
              "jsx_fragment", -- Cho các tag <>...</>
              "arrow_function",
              "parenthesized_expression", -- Quan trọng khi bao ngoặc ( ) quanh JSX
            },
            -- Đừng quên tsx và typescript bạn đã làm ở trên
            tsx = {
              "import_statement",
              "type_alias_declaration",
              "interface_declaration",
              "object",
              "array",
              "jsx_element",
              "jsx_expression",
              "statement_block",
            },
            typescript = {
              "import_statement",
              "type_alias_declaration",
              "interface_declaration",
              "object",
              "array",
              "statement_block",
            }, -- Giữ nguyên Lua và các ngôn ngữ khác
            lua = { "table_constructor", "function_definition", "if_statement" },
          },
        },
      },
    },
  },
  -- {
  --   "HiPhish/rainbow-delimiters.nvim",
  --   config = function()
  --     local rainbow = require("rainbow-delimiters")
  --     require("rainbow-delimiters.setup").setup({
  --       strategy = {
  --         [""] = rainbow.strategy["global"],
  --         html = rainbow.strategy["local"], -- ✅ hỗ trợ HTML tag
  --       },
  --       query = {
  --         [""] = "rainbow-delimiters",
  --         html = "rainbow-tags", -- ✅ highlight cả thẻ HTML
  --       },
  --     })
  --   end,
  -- },
}
