local opt = vim.opt

opt.clipboard = 'unnamedplus'   -- use system clipboard
opt.mouse = 'a'                 -- allow the mouse to be used in Nvim
opt.swapfile = false            -- don't create swapfiles
opt.backup = false              -- don't backup
opt.smartindent = true

-- tab
opt.tabstop = 2                 -- number of visual spaces per TAB
opt.softtabstop = 2             -- number of spacesin tab when editing
opt.shiftwidth = 2              -- insert 4 spaces on a tab
opt.expandtab = true            -- tabs are spaces, mainly because of python

-- ui config
opt.number = true               -- show absolute number
opt.list = true                 -- show invisible characters
opt.relativenumber = true       -- add numbers to each line on the left side
opt.cursorline = true           -- highlight cursor line underneath the cursor horizontally
opt.splitbelow = true           -- open new vertical split bottom
opt.splitright = true           -- open new horizontal splits right
opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
opt.scrolloff = 8               -- scroll after cursor
opt.colorcolumn = "100"--80     -- cutoff line
opt.signcolumn = "yes"          -- always show the signal column, prevent jumpy
opt.updatetime = 50

-- searching
opt.incsearch = true            -- search as characters are entered
opt.hlsearch = false            -- do not highlight matches
opt.ignorecase = true           -- ignore case in searches by default
opt.smartcase = true            -- but make it case sensitive if an uppercase is entered

-- leader
vim.g.maplocalleader = ","
vim.g.mapleader = ","

-- disable some default providers
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({
	vim.fn.stdpath "data", "mason", "bin"
	}, sep) .. delim .. vim.env.PATH
