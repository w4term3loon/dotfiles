local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

return {
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    }
  },

  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
      n = {},
    },

    vimgrep_arguments = {
      "rg",
      "--vimgrep",
      "--hidden",
      "--smart-case",
      "--trim"
    },

    prompt_prefix = "  ",
    selection_caret = "> ",
    entry_prefix = "  ",
    set_env = { ["COLORTERM"] = "truecolor" },
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",

    layout_config = {
      width = function(_, cols, _)
        if cols > 200 then
          return 170
        else
          return math.floor(cols * 0.87)
        end
      end,
      preview_cutoff = 120,
      prompt_position = "top",
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      }
    },

    file_sorter = sorters.get_fuzzy_file,
    file_ignore_patterns = { "gtk/**/*", "node_modules", ".git", "pdf_viewer" },
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    path_display = {},

    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,

    extensions = {}
  }
}
