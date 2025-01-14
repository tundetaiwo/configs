require("telescope").setup {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "descending",
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = {
				["q"] = require("telescope.actions").close,
				["x"] = require("telescope.actions").delete_buffer,
			},
    },
  },
  extensions_list = { "themes", "terms" },
  extensions = {},
	pickers = {
		buffers = {
			initial_mode = "normal"
		}
	},
}

require('telescope').load_extension('fzf')
