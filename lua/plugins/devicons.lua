return {
  "prichrd/netrw.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- để có icon
  },
  config = function()
    require("netrw").setup({
      icons = {
        enabled = true,
        folder = "",
        folder_open = "",
      },
    })
  end,
}

