return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				view = {
					width = 40,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false,
				},
				git = {
					ignore = false,
				},
				actions = {
					open_file = {
						quit_on_open = true,
					},
				},
			})
		end,
	},
}
