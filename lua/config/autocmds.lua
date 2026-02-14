local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_actions"),
  desc = "LSP actions",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = { noremap = true, silent = true, buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    bufmap("n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<cr>")
    bufmap("n", "<leader>ds", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
    bufmap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>")
    bufmap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>")
    bufmap("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float()<cr>")
    bufmap("n", "<leader>da", "<cmd>lua vim.lsp.buf.code_action()<cr>")

    vim.lsp.inlay_hint.enable()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    local ft = vim.bo.filetype
    if vim.treesitter.get_parser(0, ft) then
      vim.treesitter.start()
    end
  end,
})
