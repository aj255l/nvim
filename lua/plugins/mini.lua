return {
  "nvim-mini/mini.nvim",
  version = false,
  config = function()
    -- Text editing
    require("mini.pairs").setup()
    require("mini.bracketed").setup()
    -- Appearance
    require("mini.icons").setup()
  end,
}
