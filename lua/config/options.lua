-- Font & UI
vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes" 
vim.cmd([[
  hi Directory guifg=#7aa2f7 gui=bold
]])

-- Netwr
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_sort_by = "name"
vim.g.netrw_sort_direction = "normal"
vim.opt.fillchars:append({ vert = " " })

-- Line
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Tab
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wrapscan = true

-- Backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true 
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.autoread = true

-- Performance
vim.opt.updatetime = 200
vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 10
vim.opt.lazyredraw = false
vim.opt.redrawtime = 1500

-- Window | Split
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.equalalways = false

-- Mouse
vim.opt.mouse = 'a'

-- Clipboard
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.confirm = true
