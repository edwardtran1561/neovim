local map = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Thoat search highlight
map.set("n", "<Esc>", ":noh<CR>", {
	silent = true,
	noremap = true,
})

-- Thoat neovim va luu file
map.set("n", "<leader>q", ":wq<CR>", {
	silent = true,
	noremap = true,
})

-- Tabs
map.set("n", "<C-w>", ":bd<CR>", {
	silent = true,
	noremap = true,
})

-- Mo/Dong netwr
map.set("n", "<leader>e", function()
	if vim.bo.filetype == "netrw" then
		vim.cmd("bd")
	else
		vim.cmd("Ex")
	end
end, { desc = "Toggle netrw" })

-- LSP Saga
map.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
map.set("n", "pd", "<cmd>Lspsaga peek_definition<CR>")
map.set("n", "pr", "<cmd>Lspsaga peek_references<CR>")
map.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
map.set("n", "gr", "<cmd>Lspsaga finder ref<CR>")
map.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
map.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
