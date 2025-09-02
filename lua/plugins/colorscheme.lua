local M = {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dayfox")
    end
  },
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
  },
}

return M
