return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.config").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
			ensure_installed = {
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"json",
				"lua",
			},
			highlight = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "javascriptreact",
			callback = function(args)
				vim.treesitter.start(args.buf, "javascript")
			end,
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "typescriptreact",
			callback = function(args)
				vim.treesitter.start(args.buf, "tsx")
			end,
		})
	end,
}
