return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  opts = {
    auto_close = false,
    auto_preview = true,
    padding = false,
    indent_guides = true,
    icons = {
      indent = {
        top = "│ ",
        middle = "├─ ",
        last = "└─ ",
        fold_open = " ",
        fold_closed = " ",
        ws = "  ",
      },
    },
  },
  config = function(_, opts)
    require("trouble").setup(opts)

    -- 🔥 BẢN FIX CUỐI CÙNG: SAN PHẲNG TOÀN BỘ UI TROUBLE
    local function sync_trouble_theme()
      local bg_tree = "#121510" -- Màu rêu đồng bộ NvimTree
      local bg_active = "#1E232A" -- Màu highlight dòng chọn

      -- Danh sách tất cả các nhóm highlight "cứng đầu" nhất
      local groups = {
        "TroubleNormal",
        "TroubleNormalNC",
        "TroubleFileName",
        "TroubleFileIcon",
        "TroubleDirectory",
        "TroubleLocation",
        "TroubleCount",
        "TroubleIcon",
        "TroubleSource",
        "TroubleCode",
        "TroubleText",
        "TroubleSignColumn",
        "TroubleIndent",
        "TroublePreview",
        "TroubleFoldIcon",
        "TroubleMarker",
      }

      -- Ép tất cả về một nền rêu duy nhất
      for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = bg_tree, fg = "none", ctermbg = "none" })
      end

      -- Highlight dòng đang chọn (Phẳng và sắc nét)
      vim.api.nvim_set_hl(0, "TroubleSelected", { bg = bg_active, bold = true })

      -- Màu sắc lỗi (Giữ màu chữ, ép nền rêu)
      vim.api.nvim_set_hl(0, "TroubleError", { fg = "#F44747", bg = bg_tree, bold = true })
      vim.api.nvim_set_hl(0, "TroubleWarning", { fg = "#CCA700", bg = bg_tree, bold = true })

      -- Fix các đoạn text báo lỗi mờ (Source, Location [7,11])
      vim.api.nvim_set_hl(0, "TroubleSource", { fg = "#666666", bg = bg_tree })
      vim.api.nvim_set_hl(0, "TroubleLocation", { fg = "#555555", bg = bg_tree })
    end

    -- Chạy ngay lập tức
    sync_trouble_theme()

    -- Tạo autocmd để đảm bảo không bị theme chính ghi đè lại
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = sync_trouble_theme,
    })
  end,
}
