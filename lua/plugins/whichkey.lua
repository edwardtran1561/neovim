return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		wk.add({
			{ "<leader>f", group = "Find handler" },
			{ "<leader>h", group = "Git blame & hunk handler" },
			{ "<leader>x", group = "Diagnostics Handler" },
			{ "<leader>c", group = "Git Conflict Handler" },
		})
	end,
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
		{
			"<leader>h",
			desc = "Git",
		},
	},
}
