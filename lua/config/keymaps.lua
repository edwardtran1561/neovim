local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Thiết lập Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- =============================================================================
-- 🖥️ HỆ THỐNG & TIỆN ÍCH CHUNG (GENERAL)
-- =============================================================================
-- Chọn toàn bộ văn bản (ggVG)
map("n", "<C-a>", "ggVG", opts)

-- Lưu file nhanh (giống VS Code)
vim.keymap.set("n", "<C-s>", function()
  -- 1. Gọi Conform format đồng bộ (async = false)
  -- Việc gọi trực tiếp ở đây đảm bảo format xong rồi mới chạy lệnh lưu
  require("conform").format({
    lsp_format = "fallback",
    async = false,
    timeout_ms = 1000, -- Tăng lên 1s cho chắc chắn với file lớn
  })

  -- 2. Lưu file
  vim.cmd("write")

  -- 3. Hiển thị thông báo (Sử dụng nvim-notify qua noice)
  -- Màu sắc sẽ tự động đồng bộ với theme vscode của bạn
  vim.notify("File saved & format! ✨", vim.log.levels.INFO, {
    title = "System: ",
    timeout = 1000, -- Hiện trong 1 giây rồi biến mất
    render = "compact", -- Giao diện gọn gàng
  })
end, { desc = "Lưu và Format file" })

-- Thoát highlight tìm kiếm bằng Esc
map("n", "<Esc>", "<cmd>noh<CR>", opts)

-- Đóng buffer hiện tại (tương tự Close Tab)
local function close_buffer_to_alpha()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })

  -- Nếu chỉ còn 1 buffer đang mở
  if #bufs <= 1 then
    -- Mở Alpha trước để "lấp đầy" khoảng trống
    vim.cmd("Alpha")
    -- Xóa buffer cũ ở background (dùng pcall để tránh lỗi nếu buffer đã đóng)
    pcall(function()
      local old_buf = bufs[1].bufnr
      if vim.api.nvim_buf_is_valid(old_buf) then
        vim.cmd("bd " .. old_buf)
      end
    end)
  else
    -- Nếu còn nhiều buffer, chỉ xóa buffer hiện tại như bình thường
    vim.cmd("bd")
  end
end
map("n", "<C-w>", close_buffer_to_alpha, { desc = "Close current buffer" })

-- Thoát nhanh bằng <Leader> + q (Khoảng trắng -> q)
-- Phím này sẽ hỏi xác nhận nếu bạn chưa lưu file (do đã bật vim.opt.confirm = true)
map("n", "<leader>q", "<cmd>confirm qa<CR>", { desc = "Quit all windows (with confirm)" })

-- Thoát cưỡng bức (Không lưu) bằng <Leader> + Q (Khoảng trắng -> Q viết hoa)
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all windows (without saving)" })

-- =============================================================================
-- 🪟 ĐIỀU HƯỚNG & QUẢN LÝ CỬA SỔ (WINDOW MANAGEMENT)
-- =============================================================================
-- Di chuyển giữa các cửa sổ split (C-h,j,k,l)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

-- Thay đổi kích thước cửa sổ (Alt + h,j,k,l)
map("n", "<A-h>", "<cmd>vertical resize -3<CR>", opts)
map("n", "<A-l>", "<cmd>vertical resize +3<CR>", opts)
map("n", "<A-k>", "<cmd>resize -3<CR>", opts)
map("n", "<A-j>", "<cmd>resize +3<CR>", opts)

-- [Mới] Di chuyển dòng code lên/xuống (Visual Mode - Giống VS Code)
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- =============================================================================
-- 📁 QUẢN LÝ FILE (NVIM-TREE)
-- =============================================================================
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
map("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", { desc = "Focus Explorer" })
map("n", "<leader>er", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in Tree" })

-- Toggle file ẩn/gitignore nhanh
map("n", "th", function()
  local api = require("nvim-tree.api")
  api.tree.toggle_gitignore_filter()
  api.tree.toggle_hidden_filter()
end, { desc = "Toggle hidden files" })

-- =============================================================================
-- 🚀 LSP & CHẨN ĐOÁN (LSP SAGA & DIAGNOSTICS)
-- =============================================================================
-- Sử dụng Lspsaga cho trải nghiệm UI hiện đại
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "LSP: Hover Docs" })
map("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "LSP: Go to Definition" })
map("n", "pd", "<cmd>Lspsaga peek_definition<CR>", { desc = "LSP: Peek Definition" })
map("n", "gr", "<cmd>Lspsaga finder ref<CR>", { desc = "LSP: Finder (Ref/Def)" })
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "LSP: Code Action" })
map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "LSP: Rename" })

-- Diagnostic (Lỗi hệ thống)
map("n", "gl", vim.diagnostic.open_float, { desc = "LSP: Show line diagnostic" })

-- =============================================================================
-- 🔍 TÌM KIẾM & DANH SÁCH (TELESCOPE & TROUBLE)
-- =============================================================================
-- Telescope: Tìm file và tìm chữ
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep (Search text)" })

-- Trouble: Quản lý danh sách lỗi tập trung
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble: Workspace Diagnostics" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble: Quickfix List" })

-- =============================================================================
-- ⚔️ GIT CONFLICTS
-- =============================================================================
map("n", "<leader>co", "<Plug>(git-conflict-ours)", { desc = "Git: Keep Ours" })
map("n", "<leader>ct", "<Plug>(git-conflict-theirs)", { desc = "Git: Keep Theirs" })
map("n", "<leader>cb", "<Plug>(git-conflict-both)", { desc = "Git: Keep Both" })
map("n", "]x", "<Plug>(git-conflict-next-conflict)", { desc = "Git: Next Conflict" })
map("n", "[x", "<Plug>(git-conflict-prev-conflict)", { desc = "Git: Prev Conflict" })

-- =============================================================================
-- ⌨️ CÔNG CỤ KHÁC (TERMINAL, SCREENKEY)
-- =============================================================================
map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
map("n", "<leader>kt", function()
  require("screenkey").toggle()
end, { desc = "Toggle Screenkey" })
