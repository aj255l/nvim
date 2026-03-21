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
  group = augroup("lsp"),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Enable omni completion
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gY", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>ci", vim.lsp.buf.incoming_calls, opts)
    vim.keymap.set("n", "<space>co", vim.lsp.buf.outgoing_calls, opts)
    vim.keymap.set("n", "<space>h", vim.lsp.buf.hover, opts)
    -- * highlights the current symbol under the cursor, <leader>* renames it
    vim.keymap.set("n", "<space>*", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>j", vim.lsp.buf.code_action, opts)
    -- Diagnostics
    vim.keymap.set("n", "<space>e", function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    -- My old mapping for formatting with clang-format was <space>c, so I use it for LSP as well :-)
    if client.name ~= "clangd" then
      -- <space>c is already mapped to the more reliable :ClangFormat for clangd
      vim.keymap.set("n", "<space>c", vim.lsp.buf.format, opts)
    end

    -- Inlay hints for rust-analyzer
    if client.name == "rust-analyzer" then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- which-key configs
    local wk = require("which-key")

    wk.add({
      { "<leader>g", group = "LSP Go-To", buffer = bufnr },
      { "<leader>gd", desc = "Go to definition", buffer = bufnr },
      { "<leader>gD", desc = "Go to declaration", buffer = bufnr },
      { "<leader>gi", desc = "Go to implementation", buffer = bufnr },
      { "<leader>gY", desc = "Go to type definition", buffer = bufnr },
      { "<leader>gr", desc = "Go to references", buffer = bufnr },

      { "<leader>c", group = "LSP Calls", buffer = bufnr },
      { "<leader>ci", desc = "Incoming Calls", buffer = bufnr },
      { "<leader>co", desc = "Outgoing Calls", buffer = bufnr },

      { "<leader>h", desc = "Hover", buffer = bufnr },
      { "<leader>*", desc = "Rename Symbol", buffer = bufnr },
      { "<leader>j", desc = "Code Action", buffer = bufnr },

      { "<leader>e", desc = "Line Diagnostics", buffer = bufnr },
    }, { buffer = bufnr })
  end,
})
