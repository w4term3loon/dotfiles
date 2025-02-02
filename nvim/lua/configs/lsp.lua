-- callback for lsp attach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local buf_name = vim.api.nvim_buf_get_name(args.buf)
    vim.notify("LSP attached to buffer: " .. (buf_name ~= "" and buf_name or "[No Name]"))
  end,
})

local M = {}
local map = vim.keymap.set

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    -- header = "",
    -- prefix = "",
  },
})

local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a) return a.isPreferred end,
    apply = true
  })
end

M.on_attach = function(client, bufnr)
  local function buf_map(mode, lhs, rhs, map_opts)
    map(mode, lhs, rhs, vim.tbl_extend("force", { buffer = bufnr }, map_opts or {}))
  end

  -- enable formatting if the client supports it
  if client.server_capabilities.documentFormattingProvider then
    buf_map("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format buffer" })
  end

  -- lsp specific keybindings
  -- goto somewehere
  buf_map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
  buf_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  buf_map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
  buf_map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })

  -- hover functionality
  buf_map("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation" })

  -- other
  buf_map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Show signature help" })
  buf_map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
  buf_map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
  buf_map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "List workspace folders" })

  -- diagnostic keybindings
  buf_map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics in floating window" })
  buf_map("n", "ge", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
  buf_map("n", "gE", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
  buf_map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })

  -- quickfix (cheat)
  buf_map("n", "<leader>qf", quickfix, { desc = "Run quickfix" })
end

M.on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

-- documentation formatting capabilities
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  require("lspconfig").lua_ls.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,
    root_dir = require("lspconfig").util.root_pattern(".git"),
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
            vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })

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

    on_init = M.on_init,
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    filetypes = { "c", "cpp", "cc" },
    root_dir = require("lspconfig").util.root_pattern("src"),
  })

  require("lspconfig").rust_analyzer.setup({
    on_init = M.on_init,
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    filetypes = { "rust" },
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
      }
    }
  })

  local servers = {
    "gopls",
    "cmake",
    "pyright",
    "bashls",
    "clojure_lsp",
  }

  -- deafult configurations
  for _, server in ipairs(servers) do
    require("lspconfig")[server].setup({
      on_init = M.on_init,
      on_attach = M.on_attach,
      capabilities = M.capabilities,
    })
  end
end

return M
