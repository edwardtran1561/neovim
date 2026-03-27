return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    -- 1. Setup các module tiện ích
    require("mini.pairs").setup()
    require("mini.comment").setup()
    require("mini.ai").setup()
    require("mini.surround").setup({
      mappings = {
        add = "gsa",
        delete = "gsd",
        replace = "gsr",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        update_n_lines = "gsn",
      },
    })

    -- 2. Setup Tabline (Thanh Tab phía trên)
    require("mini.tabline").setup({
      show_icons = true,
      set_vim_settings = true,
    })

    -- 3. Setup Statusline (Thanh trạng thái dưới cùng)
    require("mini.statusline").setup({
      content = {
        -- Tùy chỉnh để trông giống VS Code hơn (Gọn gàng)
        active = nil,
      },
    })

    -- 4. 🔥 ĐỒNG BỘ THEME HIGH CONTRAST (Fix màu sắc)
    local function sync_mini_ui()
      local bg_code = "#0A0E12" -- Nền code tổng
      local bg_selected = "#1E232A" -- Nền tab/phân vùng đang chọn
      local fg_selected = "#FFFFFF" -- Chữ trắng sáng
      local fg_normal = "#808080" -- Chữ xám mờ

      -- --- Tabline Highlights ---
      -- Tab đang active (Sáng, nền xám xanh, KHÔNG gạch chân)
      vim.api.nvim_set_hl(0, "MiniTablineActive", { fg = fg_selected, bg = bg_selected, bold = true })
      -- Tab ẩn (Tối, nền đen)
      vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = fg_normal, bg = bg_code })
      -- Các tab còn lại
      vim.api.nvim_set_hl(0, "MiniTablineVisible", { fg = fg_selected, bg = bg_code })
      -- Phần nền trống
      vim.api.nvim_set_hl(0, "MiniTablineFill", { bg = bg_code })

      -- --- Statusline Highlights ---
      -- Chỉnh Statusline tối giản, hòa quyện với nền
      vim.api.nvim_set_hl(0, "MiniStatuslineDevInfo", { fg = fg_normal, bg = "#161B22" })
      vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { fg = fg_normal, bg = "#161B22" })
      vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = "#000000", bg = "#7AA2F7", bold = true })
      vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { fg = fg_normal, bg = bg_code })
    end

    -- Chạy ngay và chạy lại khi đổi theme
    sync_mini_ui()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = sync_mini_ui })
  end,
}
