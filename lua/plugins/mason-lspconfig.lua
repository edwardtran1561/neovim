local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = function()
			require("mason-lspconfig").setup({
				automatic_enable = {
					"lua_ls",
					"ts_ls",
					"jsonls",
					"html",
					"cssls",
				},
			})
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
				root_dir = function(bufnr)
					return vim.fs.root(bufnr, {
						"tsconfig.json",
						"package.json",
						".git",
					})
				end,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayVariableTypeHints = false,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
						},
					},
				},
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client.name == "ts_ls" then
						client.server_capabilities.documentFormattingProvider = false
					end
				end,
			})
			vim.lsp.inlay_hint.enable(true)
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
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
