return {
	"akinsho/git-conflict.nvim",
	version = "*",
	event = "BufReadPre",
	config = function()
		require("git-conflict").setup({
			default_mappings = false, -- tự set keymap cho sạch
			default_commands = true,
			disable_diagnostics = false,
			list_opener = "copen",
		})
	end,
}
