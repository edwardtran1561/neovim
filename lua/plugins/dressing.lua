return {
  "stevearc/dressing.nvim",
  opts = {
    input = {
      enabled = true,
      default_prompt = "Input:",
      -- Quan trọng: cho phép hiển thị dạng mật khẩu (****)
      override = function(conf)
        return conf
      end,
    },
    select = {
      enabled = true,
      backend = { "telescope", "fzf_lua", "builtin" },
    },
  },
}
