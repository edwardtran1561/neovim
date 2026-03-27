return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      -- ⌨️ TỐI ƯU PHÍM TẮT
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
        vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
      end,

      -- 🖼️ GIAO DIỆN (Tối ưu Padding & Indent Lines)
      view = {
        width = 30,
        side = "left",
      },

      -- 🎯 TỰ ĐỘNG ĐỔI THƯ MỤC GỐC (ROOT) THEO FILE ĐANG MỞ
      sync_root_with_cwd = true,
      respect_buf_cwd = true,

      update_focused_file = {
        enable = true, -- Bật tính năng tự động trỏ vào file
        update_root = true, -- 🔥 QUAN TRỌNG: Tự động đổi Root sang thư mục chứa file config
        ignore_list = {},
      },

      renderer = {
        indent_width = 2, -- Độ rộng thụt lề chuẩn
        group_empty = true,
        highlight_opened_files = "all",
        root_folder_label = false,

        -- 📏 CẤU HÌNH ĐƯỜNG KẺ GIỮA PARENT & CHILDREN
        indent_markers = {
          enable = true, -- Bật đường kẻ
          inline_arrows = true,
          icons = {
            corner = "└", -- Góc nối cuối cùng
            edge = "│", -- Đường kẻ dọc thân
            item = "├", -- Điểm nối giữa các item
            bottom = "─",
            none = " ",
          },
        },

        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            folder = { arrow_closed = "⏵", arrow_open = "⏷" },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },

      -- 🔍 LỌC & HÀNH ĐỘNG
      filters = {
        dotfiles = true,
        git_ignored = true,
      },
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = { enable = false },
        },
      },

      -- 🩺 CHẨN ĐOÁN LỖI
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = { hint = "", info = "", warning = "", error = "" },
      },
    })

    -- 🎨 ĐỒNG BỘ MÀU SẮC (Ép màu mờ cho đường kẻ để không gây xao nhãng)
    local function sync_nvimtree_theme()
      local bg_tree = "#0A0E12"

      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = bg_tree })
      vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = bg_tree })
      vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { fg = bg_tree, bg = bg_tree })

      -- Tinh chỉnh màu đường kẻ nối: Màu xám mờ để trông tinh tế (như VS Code)
      vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#2A2D2E", bg = bg_tree })

      -- Đường kẻ dọc phân tách Explorer và Code
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#1F2318", bg = bg_tree })
    end

    sync_nvimtree_theme()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = sync_nvimtree_theme })
  end,
}
