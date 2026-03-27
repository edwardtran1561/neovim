-- return {
--   "Mofiqul/vscode.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     local c = require("vscode.colors").get_colors()
--
--     -- 🎨 ĐỊNH NGHĨA BẢNG MÀU ĐỒNG BỘ (Uniform Dark)
--     local bg_main = "#0A0E12" -- Nền chung cho cả Code và NvimTree
--     local bg_cursorline = "#1E232A" -- Dòng hiện tại
--     local vsc_green = "#4EC9B0" -- Màu xanh lá cho Component
--
--     require("vscode").setup({
--       style = "dark",
--       transparent = false,
--       italic_comments = true,
--       disable_nvimtree_bg = true, -- Bật cái này để Group Overrides bên dưới có tác dụng
--
--       color_overrides = {
--         vscBack = bg_main,
--         vscLineNumber = "#505050",
--         vscCursorLineNumber = "#FFFFFF",
--       },
--
--       group_overrides = {
--         -- ==========================================
--         -- 🎨 KHÔI PHỤC MÀU XANH LÁ (React, Angular, Flutter)
--         -- ==========================================
--         ["@tag"] = { fg = vsc_green },
--         ["@tag.delimiter"] = { fg = "#808080" },
--         ["@type"] = { fg = vsc_green, bold = true },
--         ["@type.builtin"] = { fg = vsc_green },
--         ["@variable.import"] = { fg = vsc_green },
--         ["@constructor"] = { fg = vsc_green },
--
--         -- ==========================================
--         -- 🖼️ GIAO DIỆN HỆ THỐNG & CODE
--         -- ==========================================
--         Normal = { fg = "#D4D4D4", bg = bg_main },
--         NormalNC = { fg = "#D4D4D4", bg = bg_main }, -- Cửa sổ khi không focus
--         CursorLine = { bg = bg_cursorline },
--         Visual = { bg = "#264F78" },
--         Search = { fg = "#000000", bg = "#FFCC00", bold = true },
--         ["@keyword"] = { fg = c.vscPink, bold = true },
--         ["@function"] = { fg = c.vscYellow, bold = true },
--
--         -- 🔥 BORDER RIGHT: Đường kẻ phân tách cửa sổ (NvimTree Border)
--         -- Chỉnh fg thành màu xám sáng hơn nền một chút để thấy đường kẻ
--         WinSeparator = { fg = "#30363D", bg = bg_main },
--
--         -- ==========================================
--         -- 🌲 NVIM-TREE (Đồng bộ tuyệt đối nền code)
--         -- ==========================================
--         NvimTreeNormal = { bg = bg_main },
--         NvimTreeNormalNC = { bg = bg_main },
--         NvimTreeEndOfBuffer = { fg = bg_main, bg = bg_main },
--         NvimTreeCursorLine = { bg = "#161B22", bold = true },
--         -- Màu của đường kẻ nối cha-con trong NvimTree
--         NvimTreeIndentMarker = { fg = "#202020" },
--
--         -- ==========================================
--         -- 🔖 MINI.UI SYNC (Đồng bộ Tabline & Statusline)
--         -- ==========================================
--         MiniTablineActive = { fg = "#FFFFFF", bg = bg_cursorline, bold = true },
--         MiniTablineHidden = { fg = "#707070", bg = bg_main },
--         MiniTablineVisible = { fg = "#FFFFFF", bg = bg_main },
--         MiniTablineFill = { bg = bg_main }, -- Phần trống trên NvimTree nay đã đồng bộ
--
--         -- Statusline tối giản
--         MiniStatuslineModeNormal = { fg = "#000000", bg = vsc_green, bold = true },
--       },
--     })
--
--     -- Kích hoạt theme
--     require("vscode").load()
--
--     -- Hàm ép màu nền (Đảm bảo NvimTree luôn cùng màu code)
--     local function apply_ui_fix()
--       local groups = {
--         "NvimTreeNormal",
--         "NvimTreeNormalNC",
--         "NvimTreeEndOfBuffer",
--         "MiniTablineFill",
--       }
--       for _, group in ipairs(groups) do
--         vim.api.nvim_set_hl(0, group, { bg = bg_main })
--       end
--       -- Hiện lại border cho WinSeparator nếu bị theme ghi đè
--       vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#1F2318", bg = bg_main })
--     end
--
--     -- Chạy fix mỗi khi mở NvimTree hoặc đổi FileType
--     vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "ColorScheme" }, {
--       pattern = { "NvimTree", "*" },
--       callback = function()
--         vim.schedule(apply_ui_fix)
--       end,
--     })
--   end,
-- }
-- return {
--   "Mofiqul/vscode.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     local c = require("vscode.colors").get_colors()
--
--     -- 🎨 ĐỊNH NGHĨA BẢNG MÀU ĐỒNG BỘ (Uniform Dark)
--     local bg_main = "#0A0E12" -- Nền chung cho cả Code và NvimTree
--     local bg_cursorline = "#1E232A" -- Dòng hiện tại
--     local vsc_green = "#4EC9B0" -- Màu xanh lá cho Component
--
--     require("vscode").setup({
--       style = "dark",
--       transparent = false,
--       italic_comments = true,
--       disable_nvimtree_bg = true, -- Bật cái này để Group Overrides bên dưới có tác dụng
--
--       color_overrides = {
--         vscBack = bg_main,
--         vscLineNumber = "#505050",
--         vscCursorLineNumber = "#FFFFFF",
--       },
--
--       group_overrides = {
--         -- ==========================================
--         -- 🎨 KHÔI PHỤC MÀU XANH LÁ (React, Angular, Flutter)
--         -- ==========================================
--         ["@tag"] = { fg = vsc_green },
--         ["@tag.delimiter"] = { fg = "#808080" },
--         ["@type"] = { fg = vsc_green, bold = true },
--         ["@type.builtin"] = { fg = vsc_green },
--         ["@variable.import"] = { fg = vsc_green },
--         ["@constructor"] = { fg = vsc_green },
--
--         -- ==========================================
--         -- 🖼️ GIAO DIỆN HỆ THỐNG & CODE
--         -- ==========================================
--         Normal = { fg = "#D4D4D4", bg = bg_main },
--         NormalNC = { fg = "#D4D4D4", bg = bg_main }, -- Cửa sổ khi không focus
--         CursorLine = { bg = bg_cursorline },
--         Visual = { bg = "#264F78" },
--         Search = { fg = "#000000", bg = "#FFCC00", bold = true },
--         ["@keyword"] = { fg = c.vscPink, bold = true },
--         ["@function"] = { fg = c.vscYellow, bold = true },
--
--         -- 🔥 BORDER RIGHT: Đường kẻ phân tách cửa sổ (NvimTree Border)
--         -- Chỉnh fg thành màu xám sáng hơn nền một chút để thấy đường kẻ
--         WinSeparator = { fg = "#30363D", bg = bg_main },
--
--         -- ==========================================
--         -- 🌲 NVIM-TREE (Đồng bộ tuyệt đối nền code)
--         -- ==========================================
--         NvimTreeNormal = { bg = bg_main },
--         NvimTreeNormalNC = { bg = bg_main },
--         NvimTreeEndOfBuffer = { fg = bg_main, bg = bg_main },
--         NvimTreeCursorLine = { bg = "#161B22", bold = true },
--         -- Màu của đường kẻ nối cha-con trong NvimTree
--         NvimTreeIndentMarker = { fg = "#202020" },
--
--         -- ==========================================
--         -- 🔖 MINI.UI SYNC (Đồng bộ Tabline & Statusline)
--         -- ==========================================
--         MiniTablineActive = { fg = "#FFFFFF", bg = bg_cursorline, bold = true },
--         MiniTablineHidden = { fg = "#707070", bg = bg_main },
--         MiniTablineVisible = { fg = "#FFFFFF", bg = bg_main },
--         MiniTablineFill = { bg = bg_main }, -- Phần trống trên NvimTree nay đã đồng bộ
--
--         -- Statusline tối giản
--         MiniStatuslineModeNormal = { fg = "#000000", bg = vsc_green, bold = true },
--       },
--     })
--
--     -- Kích hoạt theme
--     require("vscode").load()
--
--     -- Hàm ép màu nền (Đảm bảo NvimTree luôn cùng màu code)
--     local function apply_ui_fix()
--       local groups = {
--         "NvimTreeNormal",
--         "NvimTreeNormalNC",
--         "NvimTreeEndOfBuffer",
--         "MiniTablineFill",
--       }
--       for _, group in ipairs(groups) do
--         vim.api.nvim_set_hl(0, group, { bg = bg_main })
--       end
--       -- Hiện lại border cho WinSeparator nếu bị theme ghi đè
--       vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#1F2318", bg = bg_main })
--     end
--
--     -- Chạy fix mỗi khi mở NvimTree hoặc đổi FileType
--     vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "ColorScheme" }, {
--       pattern = { "NvimTree", "*" },
--       callback = function()
--         vim.schedule(apply_ui_fix)
--       end,
--     })
--   end,
-- }
return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local c = require("vscode.colors").get_colors()

    -- 🎨 ĐỊNH NGHĨA BẢNG MÀU
    local bg_default = "#0A0E12" -- Nền hệ thống (Mặc định)
    local bg_focus = "#05070A" -- Nền TỐI HƠN khi focus vào Code
    local bg_cursorline = "#1E232A"
    local vsc_green = "#4EC9B0"

    require("vscode").setup({
      style = "dark",
      transparent = false,
      italic_comments = true,
      disable_nvimtree_bg = true,

      color_overrides = {
        vscBack = bg_default,
        vscLineNumber = "#505050",
        vscCursorLineNumber = "#FFFFFF",
      },

      group_overrides = {
        -- Groups tùy chỉnh cho vùng Focus
        FocusedNormal = { bg = bg_focus },
        FocusedLineNr = { fg = "#505050", bg = bg_focus },
        FocusedCursorLine = { bg = bg_cursorline },
        FocusedWinBar = { bg = bg_focus, bold = true },
        FocusedSignColumn = { bg = bg_focus },

        -- Khôi phục các màu đặc trưng của bạn
        ["@tag"] = { fg = vsc_green },
        ["@type"] = { fg = vsc_green, bold = true },
        ["@keyword"] = { fg = c.vscPink, bold = true },
        ["@function"] = { fg = c.vscYellow, bold = true },

        -- Cố định các thành phần UI luôn ở màu mặc định
        NvimTreeNormal = { bg = bg_default },
        NvimTreeNormalNC = { bg = bg_default },
        WinSeparator = { fg = "#1F2318", bg = bg_default },
        MiniTablineFill = { bg = bg_default },
      },
    })

    require("vscode").load()

    -- 🛠️ LOGIC BẢO VỆ TRIỆT ĐỂ (Chỉ chạy trên Buffer Code thực tế)
    local function apply_focus_highlight()
      -- 1. LẤY THÔNG TIN WINDOW HIỆN TẠI
      local win_id = vim.api.nvim_get_current_win()
      local config = vim.api.nvim_win_get_config(win_id)
      local ft = vim.bo.filetype
      local bt = vim.bo.buftype

      -- 2. DANH SÁCH ĐEN (Blacklist filetypes)
      local blacklist = {
        "NvimTree",
        "alpha",
        "notify",
        "noice",
        "lazy",
        "mason",
        "TelescopePrompt",
        "TelescopeResults",
        "TelescopePreview",
        "notify",
        "avail",
        "checkhealth",
        "help",
        "qf",
      }

      -- 3. KIỂM TRA ĐIỀU KIỆN (Quan trọng nhất)
      local is_floating = config.relative ~= "" -- Nếu là cửa sổ nổi (Notify, Noice...)
      local is_special = bt ~= "" -- Nếu là buffer đặc biệt (Terminal, Prompt...)
      local is_blacklisted = vim.tbl_contains(blacklist, ft)

      -- Nếu vi phạm bất kỳ điều kiện nào bên trên -> Xóa highlight, giữ màu mặc định
      if is_floating or is_special or is_blacklisted then
        vim.wo.winhighlight = ""
        return
      end

      -- ✅ CHỈ ÁP DỤNG CHO BUFFER CODE THỰC TẾ
      local highlights = {
        "Normal:FocusedNormal",
        "LineNr:FocusedLineNr",
        "CursorLine:FocusedCursorLine",
        "SignColumn:FocusedSignColumn",
        "WinBar:FocusedWinBar",
        "WinBarNC:FocusedWinBar",
      }
      vim.wo.winhighlight = table.concat(highlights, ",")
    end

    -- Tạo Autocmd
    local group = vim.api.nvim_create_augroup("PerfectFocusLogic", { clear = true })

    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FileType" }, {
      group = group,
      callback = function()
        -- Sử dụng schedule để đảm bảo buffer đã load xong các thuộc tính
        vim.schedule(apply_focus_highlight)
      end,
    })

    -- Đảm bảo khi chuyển sang cửa sổ khác, cửa sổ cũ không còn highlight focus
    vim.api.nvim_create_autocmd("WinLeave", {
      group = group,
      callback = function()
        vim.wo.winhighlight = ""
      end,
    })
  end,
}
