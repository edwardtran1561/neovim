return {
    'nvim-telescope/telescope.nvim', version = '*',
    config = function ()
      require("telescope").setup({
        pickers = {
          find_files = {
            theme = "dropdown"
          }
        }
      }) 
    end,
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
}
