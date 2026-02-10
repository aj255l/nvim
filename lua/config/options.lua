-- Save undo history
vim.opt.undofile = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Show line numbers and relative numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Set tab to 4 spaces
vim.opt["tabstop"] = 4
vim.opt["shiftwidth"] = 4
vim.opt.expandtab = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Use ripgrep for :grep
vim.opt.grepprg = "rg"

-- highlight cursor
-- vim.wo.cursorline = true
-- vim.wo.cursorcolumn = true

-- colors
-- vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20"

-- keep cursor centered
-- vim.opt.scrolloff = 999

-- true color support
-- vim.g.termguicolors = true
