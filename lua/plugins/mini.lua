return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.pairs").setup()
		require("mini.comment").setup()
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
		require("mini.ai").setup()
		require("mini.statusline").setup()
		require("mini.tabline").setup({
			show_icons = true,
		})
	end,
}
