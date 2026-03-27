-- Ép Neovim nhận diện thư mục chứa bộ giải mã Treesitter trên Mac
local parser_path = vim.fn.expand("~/.local/share/nvim/site")
vim.opt.runtimepath:prepend(parser_path)

-- =============================================================================
-- 🎨 UI & GIAO DIỆN TỔNG THỂ
-- =============================================================================
vim.g.have_nerd_font = true -- Xác nhận có dùng Nerd Font
vim.opt.termguicolors = true -- Bật màu 24-bit (Bắt buộc cho theme)
vim.opt.laststatus = 3 -- Global statusline (Duy nhất 1 thanh ở dưới)
vim.opt.signcolumn = "yes" -- Luôn hiển thị cột icon bên trái (tránh nhảy UI)
vim.opt.cursorline = true -- Highlight dòng hiện tại
vim.opt.wrap = false -- Không tự động xuống dòng khi code dài
vim.opt.confirm = true -- Hỏi trước khi thoát nếu chưa lưu file
vim.opt.mouse = "a" -- Cho phép dùng chuột

-- Ký tự phân cách UI (Làm sạch giao diện)
vim.opt.fillchars = {
  eob = " ", -- Ẩn dấu ~ ở cuối file
  vert = "│", -- Đường kẻ dọc sắc nét
  horiz = "─", -- 🔥 ĐƯỜNG KẺ NGANG (Sử dụng ký tự: ─)
  horizup = "┴", -- Các ký tự góc nối (tùy chọn để đẹp hơn)
  horizdown = "┬",
  vertleft = "┤",
  vertright = "├",
  verthoriz = "┼",
  msgsep = "‾",
}

-- Làm nổi bật thư mục trong các menu hệ thống
vim.api.nvim_set_hl(0, "Directory", { fg = "#7AA2F7", bold = true })

-- =============================================================================
-- 🔢 DÒNG CODE (LINE NUMBERS)
-- =============================================================================
vim.opt.number = true -- Hiện số dòng
vim.opt.relativenumber = true -- Hiện số dòng tương đối (dễ nhảy dòng)
vim.opt.breakindent = true -- Thụt đầu dòng cho các dòng bị wrap

-- =============================================================================
-- ⌨️ SOẠN THẢO & THỤT ĐẦU DÒNG (TAB/INDENT)
-- =============================================================================
vim.opt.tabstop = 2 -- 1 Tab = 2 khoảng trắng
vim.opt.shiftwidth = 2 -- Độ rộng khi dùng lệnh > hoặc <
vim.opt.softtabstop = 2
vim.opt.expandtab = true -- Chuyển Tab thành Space
vim.opt.smartindent = true -- Tự động thụt dòng thông minh
vim.opt.autoindent = true -- Tự động thụt dòng theo dòng trước

-- =============================================================================
-- 🔍 TÌM KIẾM (SEARCH)
-- =============================================================================
vim.opt.ignorecase = true -- Không phân biệt hoa thường khi tìm
vim.opt.smartcase = true -- Chỉ phân biệt hoa thường nếu có chữ hoa
vim.opt.hlsearch = true -- Highlight tất cả kết quả tìm thấy
vim.opt.incsearch = true -- Tìm ngay khi đang gõ
vim.opt.wrapscan = true -- Tìm vòng lại khi hết file

-- =============================================================================
-- 💾 LƯU TRỮ & BACKUP (BACKUP/UNDO)
-- =============================================================================
vim.opt.swapfile = false -- Không tạo file .swp
vim.opt.backup = false -- Không tạo file backup
vim.opt.writebackup = false
vim.opt.undofile = true -- Lưu lại lịch sử Undo ngay cả khi tắt máy
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.autoread = true -- Tự động tải lại file nếu bị sửa bên ngoài

-- =============================================================================
-- ⚡ HIỆU SUẤT & THỜI GIAN PHẢN HỒI (PERFORMANCE)
-- =============================================================================
vim.opt.updatetime = 200 -- Thời gian phản hồi (ms) cho các sự kiện
vim.opt.timeoutlen = 400 -- Thời gian chờ phím tắt (combo key)
vim.opt.ttimeoutlen = 10 -- Thời gian chờ phím đặc biệt (ESC...)
vim.opt.redrawtime = 1500 -- Giới hạn thời gian vẽ lại UI (tránh lag)
vim.opt.lazyredraw = false -- Để false cho mượt mà hơn trên máy đời mới

-- =============================================================================
-- 🛠️ HỆ THỐNG & CỬA SỔ (SYSTEM/SPLIT)
-- =============================================================================
vim.opt.splitbelow = true -- Mở split ngang ở dưới
vim.opt.splitright = true -- Mở split dọc bên phải
vim.opt.equalalways = false -- Không tự động cân bằng kích thước cửa sổ

-- Sao chép vào clipboard hệ thống (Dùng schedule để không làm chậm startup)
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- =============================================================================
-- 📁 DISABLE NETRW (DÙNG CHO NVIM-TREE)
-- =============================================================================
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- =============================================================================
-- 🩺 CHẨN ĐOÁN LỖI (DIAGNOSTICS)
-- =============================================================================
vim.diagnostic.config({
  virtual_text = false, -- Tắt chữ báo lỗi rác mắt ở cuối dòng
  signs = true, -- Hiện icon lỗi ở cột lề trái
  underline = true, -- Gạch chân code lỗi
  severity_sort = true, -- Sắp xếp lỗi theo độ nghiêm trọng
  update_in_insert = false, -- Không báo lỗi khi đang gõ (tránh xao nhãng)
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
      border = "rounded", -- Bo góc đồng bộ UI
      source = "always", -- Hiện lỗi này từ đâu (LSP, Linter...)
      prefix = " ",
      scope = "cursor",
    })
  end,
})
