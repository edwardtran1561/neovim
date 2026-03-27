return {
  "nvim-telescope/telescope.nvim",
  version = false, -- Sử dụng bản cập nhật mới nhất
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        -- 🎨 Giao diện Bo góc chuẩn VS Code hiện đại
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },

        -- Phím tắt trong cửa sổ Telescope
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<esc>"] = actions.close, -- Nhấn Esc một lần để đóng ngay
          },
        },
      },

      pickers = {
        -- 🔍 Tìm file theo kiểu dropdown (đã bo góc) giống yêu cầu cũ của bạn
        find_files = {
          theme = "dropdown",
          previewer = false,
          hidden = true, -- Hiện cả file ẩn (.env, .gitignore)
        },
        live_grep = {
          theme = "ivy", -- Ivy hiện ở dưới cùng trông rất chuyên nghiệp khi tìm chữ
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
        },
      },

      extensions = {
        -- Tối ưu tốc độ tìm kiếm bằng thuật toán FZF (viết bằng C)
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Kích hoạt extension FZF
    pcall(telescope.load_extension, "fzf")

    -- 🔥 ĐỒNG BỘ MÀU SẮC (ÉP MÀU CHO ĐỒNG BỘ THEME)
    local function sync_telescope_theme()
      local bg_code = "#0A0E12" -- Nền code tối sâu
      local bg_tree = "#050505" -- Nền xanh rêu sáng (đồng bộ NvimTree)

      -- Viền và tiêu đề
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#2A2D2E", bg = bg_code })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#3B4252", bg = bg_code })
      vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#000000", bg = "#7AA2F7", bold = true })

      -- Kết quả tìm kiếm
      vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#1E232A", bold = true })
      vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#4EC9B0", bold = true }) -- Màu xanh lá cho đoạn text khớp
    end

    sync_telescope_theme()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = sync_telescope_theme })
  end,
}
