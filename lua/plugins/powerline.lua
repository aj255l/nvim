return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {},
          lualine_y = {'lspstatus'},
          lualine_z = {'location'}
        },
      })
    end,
  },
}
