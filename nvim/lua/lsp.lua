local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
  filetypes = {"c", "cpp"},
  capabilities = capabilities,
})

require("lspconfig").lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

