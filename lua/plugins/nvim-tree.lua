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

        -- Mappings mặc định
        api.config.mappings.default_on_attach(bufnr)

        -- Override: Giống phím tắt chia màn hình của bạn
        vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        -- Phím tắt nhanh để ẩn/hiện file gitignore/dotfiles
        vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
        vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
      end,

      -- 🖼️ GIAO DIỆN (Đồng bộ VS Code High Contrast)
      view = {
        width = 35, -- Độ rộng vừa phải cho màn hình
        side = "left",
      },

      renderer = {
        group_empty = true, -- Gộp các thư mục rỗng (tiết kiệm diện tích)
        highlight_opened_files = "all", -- Highlight file đang mở
        root_folder_label = false, -- ❌ XÓA chữ EXPLORER và đường dẫn rác ở trên cùng

        indent_markers = {
          enable = true, -- Hiện đường kẻ thụt lề (Rất quan trọng cho Flutter/React)
          inline_arrows = true,
        },

        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true, -- Hiện trạng thái Git (Modified, Added...)
          },
          glyphs = {
            folder = {
              arrow_closed = "⏵",
              arrow_open = "⏷",
            },
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

      -- 🔍 BỘ LỌC
      filters = {
        dotfiles = false, -- Để false để bạn có thể toggle bằng phím 'H'
        git_ignored = false, -- Để false để bạn có thể toggle bằng phím 'I'
      },

      -- ⚡ HÀNH ĐỘNG
      actions = {
        open_file = {
          quit_on_open = false, -- Giữ Tree mở khi chọn file (giống VS Code)
          resize_window = true,
          window_picker = {
            enable = false, -- Tắt cái bảng chọn cửa sổ phiền phức
          },
        },
      },

      -- 🩺 CHẨN ĐOÁN LỖI (Hiện icon lỗi ngay trên file)
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
    })
  end,
}
