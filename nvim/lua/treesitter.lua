require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "c", "cpp", "clojure", "rust", "markdown", "go", "python", "vim", "bash" },
  highlight = {
    enable = true,
  },
})
