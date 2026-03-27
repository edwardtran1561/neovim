return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- KIỂM TRA: Nếu có tham số file từ terminal, thoát luôn không chạy Alpha
    if vim.fn.argc() > 0 then
      return
    end

    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    -- ... các cấu hình dashboard của bạn ...
    alpha.setup(dashboard.opts)
  end,
}
