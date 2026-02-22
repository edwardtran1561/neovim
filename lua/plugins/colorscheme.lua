return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "moon",
			transparent = false,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},

				sidebars = "dark",
				floats = "dark",
			},
			on_highlights = function(hl, colors)
				hl.LineNr = { fg = colors.yellow }
			end,
		})
		vim.cmd.colorscheme("tokyonight")
	end,
}
