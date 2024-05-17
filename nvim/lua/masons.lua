require("mason").setup({
  ui = {
    icons = {
      package_installed = "i",
      package_pending = "p",
      package_uninstalled = "u"
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" },
  automatic_installation = true
})

