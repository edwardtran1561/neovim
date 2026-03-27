return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = {
        background_colour = "#0A0E12",
      },
    },
  },
  opts = {
    -- 🛠️ CẤU HÌNH LSP (Đồng bộ với blink.cmp)
    lsp = {
      diagnostic = {
        enabled = true,
        view = "split", -- Hoặc "popup" nếu bạn muốn nó hiện đè lên code
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.styled_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      -- Hiện chữ ký hàm khi đang gõ (giống VS Code)
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true,
        },
      },
    },

    -- 🖼️ GIAO DIỆN (Bo góc Rounded đồng bộ)
    views = {
      cmdline_popup = {
        position = { row = 5, col = "50%" },
        size = { width = 60, height = "auto" },
        border = { style = "rounded" },
      },
      popupmenu = {
        relative = "editor",
        position = { row = 8, col = "50%" },
        size = { width = 60, height = 10 },
        border = { style = "rounded" },
      },
    },

    -- ⚡ LỌC THÔNG BÁO (Loại bỏ rác mắt)
    routes = {
      {
        -- Ẩn thông báo "written" sau khi lưu file (Cực kỳ sạch sẽ)
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      {
        -- Đưa thông báo tìm kiếm xuống góc thay vì hiện giữa màn hình
        filter = { event = "msg_show", find = "search hit" },
        opts = { skip = true },
      },
    },

    -- 🎨 PRESETS (Các tính năng "xịn" nhất)
    presets = {
      bottom_search = true, -- Thanh tìm kiếm nằm dưới cùng
      command_palette = true, -- Đưa thanh lệnh (:) ra giữa màn hình cực đẹp
      long_message_to_split = true, -- Thông báo dài tự động mở split
      inc_rename = false, -- Tắt nếu bạn không dùng plugin inc-rename
      lsp_doc_border = true, -- Thêm viền cho bảng tài liệu LSP (Hover)
    },
  },
}
