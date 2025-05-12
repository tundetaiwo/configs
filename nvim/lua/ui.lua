-- Theme Settings
require("catppuccin").setup({
	flavour = "mocha",
	-- flavour = "macchiato",
	-- flavour = "frappe",
	transparent_background = true,
	how_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	custom_highlights = function(colors)
		return {
			-- DiffAdd = { bg = "#106e3c" },
			-- DiffDelete = { bg = "#822322" },
			-- DiffText = { bg = "#803280" },
			-- DiffChange = { bg = "" },
		}
	end,
	integrations = {
		cmp = true,
	}
})

require("gruvbox").setup({
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})

-- Set Theme
vim.o.background = "dark"
vim.cmd.colorscheme "gruvbox"
-- vim.cmd.colorscheme "catppuccin"
