return {
  defaults = {
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      i = { ["<Esc>"] = require("telescope.actions").close }, -- Close with Ctrl+q in insert mode
      n = { ["q"] = require("telescope.actions").close }      -- Close with 'q' in normal mode
    }
  },

  extensions_list = { "themes", "terms" },
  extensions = {},
}
