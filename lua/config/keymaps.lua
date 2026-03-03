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
	desc = "Close tab",
})

-- Diagnostic
map.set("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostic (float)" })
map.set("n", "<leader>xx", function()
	require("trouble").toggle({
		mode = "diagnostics",
	})
end, { desc = "Toggle diagnostics (workspace)" })

map.set("n", "<leader>xr", function()
	require("trouble").toggle({
		mode = "lsp_references",
	})
end, { desc = "Show LSP References" })

map.set("n", "<leader>xq", function()
	require("trouble").toggle({
		mode = "quickfix",
	})
end, { desc = "Toggle Quick Fix List" })

map.set("n", "<leader>xl", function()
	require("trouble").toggle({
		mode = "loclist",
	})
end, { desc = "Toggle Location List" })

-- Nvim tree
map.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Focus tree
map.set("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file tree" })

-- Reveal current file
map.set("n", "<leader>er", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal current file" })

-- LSP Saga
map.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover docs" })
map.set("n", "pd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })
map.set("n", "pr", "<cmd>Lspsaga peek_references<CR>", { desc = "Peek References" })
map.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Go To Definition" })
map.set("n", "gr", "<cmd>Lspsaga finder ref<CR>", { desc = "Find References" })
map.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
map.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })

-- Telescope
map.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find Grep" })

-- ===== Conflict keymaps =====
map.set("n", "<leader>co", "<Plug>(git-conflict-ours)", {
	desc = "Conflict: Accept ours",
})

map.set("n", "<leader>ct", "<Plug>(git-conflict-theirs)", {
	desc = "Conflict: Accept theirs",
})

map.set("n", "<leader>cb", "<Plug>(git-conflict-both)", {
	desc = "Conflict: Accept both",
})

map.set("n", "<leader>c0", "<Plug>(git-conflict-none)", {
	desc = "Conflict: Delete conflict",
})

map.set("n", "]x", "<Plug>(git-conflict-next-conflict)", {
	desc = "Conflict: Next",
})

map.set("n", "[x", "<Plug>(git-conflict-prev-conflict)", {
	desc = "Conflict: Previous",
})
