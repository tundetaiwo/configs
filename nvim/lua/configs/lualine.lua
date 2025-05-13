local filename = {
	{
		"filename",
		path = 3,
	}
}

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {"NvimTree", "toggleterm"},
			winbar = {"NvimTree"},
		},
		ignore_focus = {"NvimT"},
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
		lualine_a = { 'mode' },
		-- lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = filename,
    lualine_x = {'progress'},
    lualine_y = {'location'},
		lualine_z = {'encoding', 'fileformat', 'filetype'},
	},
	inactive_sections = {
		-- lualine_a = { 'mode' },
		-- lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = filename,
    -- lualine_x = {'progress'},
    -- lualine_y = {'location'},
		lualine_z = {'encoding', 'fileformat', 'filetype'},
	},

}
