local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = function()
			require("mason-lspconfig").setup({
				opts = {
					ensure_installed = {
						"html",
						"cssls",
						"lua_ls",
						"jsonls",
						"ts_ls",
					},
				},
				automatic_enable = true,
			})
			vim.lsp.inlay_hint.enable(true)
			-- Setup
			-- TS_LS
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"typescript",
					"typescriptreact",
					"typescriptreact",
				},
			})
			-- HTML
			vim.lsp.config("html", {
				capabilities = capabilities,
			})
			-- Lua
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },
}
