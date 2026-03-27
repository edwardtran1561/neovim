return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local c = require("vscode.colors").get_colors()

    local bg_main = "#0A0E12"
    local bg_active = "#333333"
    local bg_cursorline = "#1E232A"
    local vsc_green = "#4EC9B0"

    require("vscode").setup({
      style = "dark",
      transparent = false,
      italic_comments = true,
      disable_nvimtree_bg = true,

      color_overrides = {
        vscBack = bg_main,
        vscLineNumber = "#505050",
        vscCursorLineNumber = "#FFFFFF",
      },

      group_overrides = {
        -- ==========================================
        -- 🎨 KHÔI PHỤC MÀU XANH LÁ (React, Angular, Flutter)
        -- ==========================================
        ["@tag"] = { fg = vsc_green },
        ["@tag.delimiter"] = { fg = "#808080" },
        ["@type"] = { fg = vsc_green, bold = true },
        ["@type.builtin"] = { fg = vsc_green },
        ["@variable.import"] = { fg = vsc_green },
        ["@constructor"] = { fg = vsc_green },

        -- ==========================================
        -- 🖼️ GIAO DIỆN HỆ THỐNG & CODE
        -- ==========================================
        Normal = { fg = "#D4D4D4", bg = bg_main },
        NormalNC = { fg = "#D4D4D4", bg = bg_main },
        CursorLine = { bg = bg_cursorline },
        Visual = { bg = "#264F78" },
        Search = { fg = "#000000", bg = "#FFCC00", bold = true },
        ["@keyword"] = { fg = c.vscPink, bold = true },
        ["@function"] = { fg = c.vscYellow, bold = true },

        WinSeparator = { fg = "#30363D", bg = bg_main },
        WinBar = { fg = "#D4D4D4", bg = bg_main },
        WinBarNC = { fg = "#707070", bg = bg_main },

        -- ==========================================
        -- 🌲 NVIM-TREE
        -- ==========================================
        NvimTreeNormal = { bg = bg_main },
        NvimTreeNormalNC = { bg = bg_main },
        NvimTreeEndOfBuffer = { fg = bg_main, bg = bg_main },
        NvimTreeCursorLine = { bg = "#161B22", bold = true },
        NvimTreeIndentMarker = { fg = "#202020" },

        -- ==========================================
        -- 🔖 MINI.UI SYNC
        -- ==========================================
        MiniTablineActive = { fg = "#FFFFFF", bg = bg_cursorline, bold = true },
        MiniTablineHidden = { fg = "#707070", bg = bg_main },
        MiniTablineVisible = { fg = "#FFFFFF", bg = bg_main },
        MiniTablineFill = { bg = bg_main },
        MiniStatuslineModeNormal = { fg = "#000000", bg = vsc_green, bold = true },

        -- ==========================================
        -- 🌈 RAINBOW DELIMITERS
        -- ==========================================
        RainbowDelimiterRed = { fg = "#E06C75" },
        RainbowDelimiterYellow = { fg = "#E5C07B" },
        RainbowDelimiterBlue = { fg = "#61AFEF" },
        RainbowDelimiterOrange = { fg = "#D19A66" },
        RainbowDelimiterGreen = { fg = "#98C379" },
        RainbowDelimiterViolet = { fg = "#C678DD" },
        RainbowDelimiterCyan = { fg = "#56B6C2" },
      },
    })

    require("vscode").load()

    -- ==========================================
    -- 🔦 HIGHLIGHT ACTIVE WINDOW (chỉ trừ NvimTree)
    -- ==========================================
    vim.api.nvim_set_hl(0, "NormalActive", { fg = "#D4D4D4", bg = bg_active })

    vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave" }, {
      callback = function()
        local ft = vim.bo.filetype
        if ft == "NvimTree" then
          return
        end

        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_option(
          win,
          "winhighlight",
          vim.api.nvim_get_current_win() == win and "Normal:NormalActive" or "Normal:Normal"
        )
      end,
    })

    -- ==========================================
    -- 🛠️ UI FIX
    -- ==========================================
    local function apply_ui_fix()
      local groups = {
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "NvimTreeEndOfBuffer",
        "MiniTablineFill",
      }
      for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = bg_main })
      end
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#1F2318", bg = bg_main })
      vim.api.nvim_set_hl(0, "NormalActive", { fg = "#D4D4D4", bg = bg_active })
    end

    vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "ColorScheme" }, {
      pattern = { "NvimTree", "*" },
      callback = function()
        vim.schedule(apply_ui_fix)
      end,
    })
  end,
}
