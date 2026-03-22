return {
	"Mofiqul/vscode.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local c = require("vscode.colors").get_colors()

		-- Định nghĩa bảng màu chuẩn High Contrast
		local bg_code = "#0A0E12" -- Nền code tối sâu
		local bg_tree = "#121510" -- Nền NvimTree sáng hơn một chút
		local bg_cursorline = "#1E232A" -- Dòng hiện tại
		local vsc_green = "#4EC9B0" -- Màu xanh lá huyền thoại cho Component

		require("vscode").setup({
			style = "dark",
			transparent = false,
			italic_comments = true,
			disable_nvimtree_bg = true, -- Để mình tự quản lý màu nvim-tree

			color_overrides = {
				vscBack = bg_code,
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
				["@variable.import"] = { fg = vsc_green }, -- Fix lỗi Container trắng
				["@constructor"] = { fg = vsc_green }, -- Cho Flutter Widgets

				-- ==========================================
				-- 🖼️ GIAO DIỆN HỆ THỐNG & CODE
				-- ==========================================
				Normal = { fg = "#D4D4D4", bg = bg_code },
				CursorLine = { bg = bg_cursorline },
				Visual = { bg = "#264F78" },
				Search = { fg = "#000000", bg = "#FFCC00", bold = true },
				["@keyword"] = { fg = c.vscPink, bold = true },
				["@function"] = { fg = c.vscYellow, bold = true },

				-- ==========================================
				-- 🌲 NVIM-TREE (Sáng hơn nền code)
				-- ==========================================
				NvimTreeNormal = { bg = bg_tree },
				NvimTreeNormalNC = { bg = bg_tree },
				NvimTreeEndOfBuffer = { fg = bg_tree, bg = bg_tree },
				NvimTreeCursorLine = { bg = "#1D2318", bold = true },
				WinSeparator = { fg = "#252B20", bold = true },

				-- ==========================================
				-- 🔖 BUFFERLINE SYNC (Padded Slant - No Underline)
				-- ==========================================
				BufferLineFill = { bg = bg_code },
				BufferLineBackground = { fg = "#707070", bg = bg_code },
				BufferLineBufferSelected = { fg = "#FFFFFF", bg = bg_cursorline, bold = true, underline = false },
				BufferLineSeparator = { fg = bg_code, bg = bg_code },
				BufferLineSeparatorSelected = { fg = bg_code, bg = bg_cursorline },
				BufferLineIndicatorSelected = { fg = "#007AFF", bg = bg_cursorline, bold = true },
				modified_selected = { bg = bg_cursorline, fg = "#EBCB8B" },
			},
		})

		-- Kích hoạt theme
		require("vscode").load()

		-- Hàm ép màu nền cho NvimTree (Đảm bảo đồng bộ)
		local function apply_ui_fix()
			vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = bg_tree })
			vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = bg_tree })
			vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { fg = bg_tree, bg = bg_tree })
		end

		vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
			pattern = "NvimTree",
			callback = function()
				vim.schedule(apply_ui_fix)
			end,
		})
	end,
}
