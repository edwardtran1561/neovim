return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "horizontal",
			size = 20,
			open_mapping = [[<c-\>]],
			shade_terminals = true,
		})

		local Terminal = require("toggleterm.terminal").Terminal

		local lazygit = Terminal:new({
			cmd = "lazygit",
			direction = "float",
			hidden = true,
		})

		vim.keymap.set("n", "<leader>gg", function()
			lazygit:toggle()
		end, { desc = "LazyGit (float)" })
	end,
}
