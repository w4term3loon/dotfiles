-- fetch lazypath
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  "ellisonleao/gruvbox.nvim",

  { -- load luasnips + cmp related in insert mode only
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("configs.luasnip-conf")
        end,
      },

      { -- autopairing of (){}[] etc
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      { -- cmp sources plugins
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require("configs.cmp-conf")
    end,
  },

  { -- file managing , picker etc
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require("configs.nvimtree-conf")
    end,
  },

  { -- git signs
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return require("configs.gitsigns-conf")
    end,
  },

  { -- git blame
   "FabijanZulj/blame.nvim",
    opts = function()
      return {
        date_format = "%Y.%b.%d",
        focus_blame = false,
        views = {
            default = require("blame.views.virtual_view"),
        },
      }
    end,
  },

  { -- lsp
    "williamboman/mason-lspconfig.nvim",
    dependencies = {

      {
        "williamboman/mason.nvim",
        opts = function()
          return require("configs.mason-conf")
        end,
      },

      {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
          return require("configs.lsp-conf").configs
        end,
      }
    },

    opts = function()
      return {
        ensure_installed = require("configs.lsp-conf").servers,
        automatic_enable = true,
        automatic_enabled = {
          exclude = {}
        },
      }
    end,
  },

  { -- fuzzy finder
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require("configs.telescope-conf")
    end,
  },

  { -- treesitter
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require("configs.treesitter-conf")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

})
