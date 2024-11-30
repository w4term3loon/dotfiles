local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a) return a.isPreferred end,
    apply = true
  })
end

-- mappings
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', ',e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', ',q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gE', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- quickfix
vim.keymap.set('n', ',qf', quickfix, opts)

-- format
vim.api.nvim_set_keymap('n', ',f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

local on_attach = function(client, bufnr)
  _ = client
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

end

require("lspconfig").clangd.setup({
  cmd = {
    "clangd",
    "-j=4",
    "--pretty",
    "--inlay-hints",
    "--background-index",
    "--pch-storage=memory",
    "--all-scopes-completion",
    "--header-insertion=never",
    "--function-arg-placeholders",
    "--completion-style=detailed",
    "--header-insertion-decorators",
  },
  on_attach = on_attach,
  filetypes = { "c", "cpp", "cc" },
  root_dir = require("lspconfig").util.root_pattern("src"),
  capabilities = capabilities,
})

require("lspconfig").lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = require("lspconfig").util.root_pattern(".git"),
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

require("lspconfig").gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require("lspconfig").cmake.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require("lspconfig").pylsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  plugins = {
    mypy = {
      enabled = true,
    },
  }
})

require("lspconfig").rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    }
  }
})
