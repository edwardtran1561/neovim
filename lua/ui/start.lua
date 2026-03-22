local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- =============================================================================
-- 🎨 HEADER: Pixel Style (Giữ nguyên phong cách của bạn)
-- =============================================================================
dashboard.section.header.val = {
  " ▄▄▄▄▄▄▄    ▄▄                        ▄▄   ▄▄▄▄▄▄▄▄▄                ",
  "███▀▀▀▀▀    ██                        ██   ▀▀▀███▀▀▀                ",
  "███▄▄    ▄████ ██   ██  ▀▀█▄ ████▄ ▄████      ███ ████▄  ▀▀█▄ ████▄ ",
  "███      ██ ██ ██ █ ██ ▄█▀██ ██ ▀▀ ██ ██      ███ ██ ▀▀ ▄█▀██ ██ ██ ",
  "▀███████ ▀████  ██▀██  ▀█▄██ ██    ▀████      ███ ██    ▀█▄██ ██ ██ ",
}

-- =============================================================================
-- 📊 INFO PANEL (Tối ưu hóa thời gian thực)
-- =============================================================================
-- Dùng hàm trực tiếp để thông tin luôn mới nhất mỗi khi quay lại Dashboard
dashboard.section.footer.val = {
  "",
  os.date(" %d-%m-%Y   %H:%M"),
  "⚡ Plugins: " .. require("lazy").stats().count .. " | Startup: " .. math.floor(
    require("lazy").stats().startuptime + 0.5
  ) .. "ms",
}

-- =============================================================================
-- ⌨️ BUTTONS: Tối ưu phím tắt & Icon
-- =============================================================================
dashboard.section.buttons.val = {
  dashboard.button("e", "  Explorer", "<cmd>NvimTreeToggle<CR>"),
  dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
  -- Thêm icon    vào đây để đồng bộ
  dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
  dashboard.button("c", "  Config", "<cmd>e ~/.config/nvim/init.lua<CR>"),
  dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
}

-- =============================================================================
-- 🖼️ LAYOUT & ĐỒNG BỘ THEME (High Contrast)
-- =============================================================================
-- Căn giữa header (đẩy xuống 5 dòng như cũ của bạn)
dashboard.opts.layout[1].val = 5

-- 🎨 ÉP MÀU: Để Header có màu xanh lá của Container, Button màu xám sạch
local function apply_colors()
  local vsc_green = "#4EC9B0" -- Màu xanh lá đồng bộ với Container của bạn
  local vsc_blue = "#569CD6" -- Màu xanh dương nhẹ

  vim.api.nvim_set_hl(0, "DashboardHeader", { fg = vsc_green, bold = true })
  vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#505050", italic = true })
  vim.api.nvim_set_hl(0, "DashboardShortCut", { fg = vsc_blue, italic = true })
end

apply_colors()

-- Tự động cập nhật màu khi đổi theme
vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_colors })

alpha.setup(dashboard.opts)
