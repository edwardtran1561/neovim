local map = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Thoat search highlight
map.set("n", "<Esc>", ":noh<CR>", {
	silent = true,
	noremap = true,
})

-- Tabs
map.set("n", "<C-w>", ":bd<CR>", {
	silent = true,
	noremap = true,
})

-- Diagnostic
map.set("n", "gl", vim.diagnostic.open_float)
map.set("n", "<leader>xx", function()
	require("trouble").toggle({
		mode = "diagnostics",
	})
end)

map.set("n", "<leader>xr", function()
	require("trouble").toggle({
		mode = "lsp_references",
	})
end)

map.set("n", "<leader>xq", function()
	require("trouble").toggle({
		mode = "quickfix",
	})
end)

map.set("n", "<leader>xl", function()
	require("trouble").toggle({
		mode = "loclist",
	})
end)

-- Nvim tree
map.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Focus tree
map.set("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file tree" })

-- Reveal current file
map.set("n", "<leader>r", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal current file" })

-- LSP Saga
map.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
map.set("n", "pd", "<cmd>Lspsaga peek_definition<CR>")
map.set("n", "pr", "<cmd>Lspsaga peek_references<CR>")
map.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
map.set("n", "gr", "<cmd>Lspsaga finder ref<CR>")
map.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
map.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")

-- Telescope
map.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
