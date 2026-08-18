local filename = {
	{
		"filename",
		path = 3,
		shorting_target = 0,
	}
}

-- explicit (non-transparent) theme so the statusline stays visible as a
-- window divider even with catppuccin's transparent_background enabled
local palette = require("catppuccin.palettes").get_palette("mocha")
local border_theme = {
	normal = {
		a = { fg = palette.base, bg = palette.blue, gui = "bold" },
		b = { fg = palette.text, bg = palette.surface2 },
		c = { fg = palette.text, bg = palette.surface2 },
	},
	inactive = {
		a = { fg = palette.overlay1, bg = palette.surface1 },
		b = { fg = palette.overlay1, bg = palette.surface1 },
		c = { fg = palette.overlay0, bg = palette.surface1 },
	},
}

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = border_theme,
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = { "NvimTree", "toggleterm" },
			winbar = { "NvimTree" },
			"dapui_watches", "dapui_breakpoints",
			"dapui_scopes", "dapui_console",
			"dapui_stacks", "dap-repl"
		},
		ignore_focus = { "NvimT" },
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		}
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = filename,
		lualine_x = { 'progress' },
		lualine_y = { 'location' },
		lualine_z = { 'encoding', 'fileformat', 'lsp_status' },
	},
	inactive_sections = {
		-- lualine_a = { 'mode' },
		-- lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = filename,
		lualine_x = { 'progress' },
		-- lualine_y = {'location'},
		-- lualine_z = {'encoding', 'fileformat', 'filetype'},
	},

}
