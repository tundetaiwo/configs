-- Theme Settings
require("catppuccin").setup({
	flavour = "mocha",
	-- flavour = "macchiato",
	-- flavour = "frappe",
	transparent_background = true,
	how_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	custom_highlights = function(colors)
		return {
			DiffAdd = { bg = "#106e3c" },
			DiffDelete = { bg = "#805844" },
			-- DiffChange = {bg = "grey"},
			-- DiffText = {bg = "grey"},
		}
	end,
	integrations = {
		cmp = true,
	}
})

-- Set Theme
vim.cmd.colorscheme "catppuccin"
