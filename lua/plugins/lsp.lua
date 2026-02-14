return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    },
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "nvim-lspconfig" },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "basedpyright",
        "clangd",
        "gopls",
        "lua_ls",
        "stylua",
        "ruff",
        "rust_analyzer",
      },
      automatic_enable = true
    },
    config = function()
      vim.lsp.enable("basedpyright")
      vim.lsp.enable("clangd")
      vim.lsp.enable("gopls")

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            hint = {
              arrayIndex = "Disable",
            }
          }
        }
      })
      vim.lsp.enable("lua_ls")

      vim.lsp.enable("stylua")
      vim.lsp.enable("ruff")
      vim.lsp.enable("rust_analyzer")
    end
  },
}
