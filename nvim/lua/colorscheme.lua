require("tokyonight").setup({
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
})

local eval, _ = pcall(vim.cmd, "colorscheme tokyonight-night" )
if not eval then
    vim.notify("colorscheme tokyonight not found!")
    return
end
