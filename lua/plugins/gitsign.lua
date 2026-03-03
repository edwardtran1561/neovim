return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()

			local gs = require("gitsigns")

			vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Git: Next Hunk" })
			vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Git: Previous Hunk" })
			vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Git: Stage Hunk" })
			vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Git: Reset Hunk" })
			vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Git: Preview Hunk" })
			vim.keymap.set("n", "<leader>hb", gs.blame_line, { desc = "Git: Blame line" })
		end,
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
	},
}
