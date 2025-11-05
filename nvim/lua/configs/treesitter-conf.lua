-- Group for custom filetype associations
local ft_group = vim.api.nvim_create_augroup('CustomFiletypeRules', { clear = true })

-- Associate *.rules and *.config with 'make' filetype
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = ft_group,
  pattern = { '*.rules', '*.config' },
  callback = function()
    vim.bo.filetype = 'make'
  end,
  desc = 'Set filetype to make for makefile rule/config files',
})

return {
  ensure_installed = {
    "lua",
    "c",
    "cpp",
    "clojure",
    "rust",
    "markdown",
    "go",
    "python",
    "vim",
    "bash",
    "luadoc",
    "printf",
    "vimdoc",
    "make",
    "cmake"
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}
