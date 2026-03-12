return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				on_attach = function(bufnr)
					local api = require("nvim-tree.api")

					local function opts(desc)
						return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true }
					end

					-- default mappings
					api.config.mappings.default_on_attach(bufnr)

					-- override
					vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
					vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
				end,
				view = {
					width = 40,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
					git_ignored = true,
				},
				actions = {
					open_file = {
						quit_on_open = true,
						resize_window = false,
						window_picker = {
							enable = false,
						},
					},
				},
			})
		end,
	},
}
