-- ============================================================================
-- Utility Plugins Config
-- ============================================================================

return {
  {
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "tpope/vim-unimpaired", -- Naviage compilation errors with ]q and [q
  },
  {
    "tpope/vim-dispatch", -- Make compilation async
  },
  {
    "shrynx/line-numbers.nvim", -- Relative and absolute line numbers
    opts = {},
  },
}
