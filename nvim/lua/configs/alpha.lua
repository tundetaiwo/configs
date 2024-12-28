local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.val = {

	[[  '########:'##::::'##:'##::: ##:'####:'##::::'##:'####:'##::::'##:  ]],
	[[  ... ##..:: ##:::: ##: ###:: ##:. ##:: ##:::: ##:. ##:: ###::'###:  ]],
	[[  ::: ##:::: ##:::: ##: ####: ##:: ##:: ##:::: ##:: ##:: ####'####:  ]],
	[[  ::: ##:::: ##:::: ##: ## ## ##:: ##:: ##:::: ##:: ##:: ## ### ##:  ]],
	[[  ::: ##:::: ##:::: ##: ##. ####:: ##::. ##:: ##::: ##:: ##. #: ##:  ]],
	[[  ::: ##:::: ##:::: ##: ##:. ###:: ##:::. ## ##:::: ##:: ##:.:: ##:  ]],
	[[  ::: ##::::. #######:: ##::. ##:'####:::. ###::::'####: ##:::: ##:  ]],
	[[  :::..::::::.......:::..::::..::....:::::...:::::....::..:::::..:  ]],
}


-- Position Header
dashboard.config.layout = {
	{ type = "padding", val = 15 }, -- Adjust padding to push it down
	dashboard.section.header,
	{ type = "padding", val = 2 },  -- Additional padding after the header
	dashboard.section.buttons,
}


local new_file_but = dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>")
local close_nvim_but = dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>")
local file_file_but = dashboard.button("Ctrl + p", "  Find File", ":Telescope find_files ")
local open_sess_butt = dashboard.button("SPC s l", "󱈅  Open Session", function() require("persistence").select() end)
local last_sess_butt = dashboard.button("SPC l s", "  Open Last Session",
	function() require("persistence").load({ last = true }) end)


dashboard.section.buttons.val = {
	new_file_but,
	close_nvim_but,
	file_file_but,
	open_sess_butt,
	last_sess_butt,
}

-- Set Colours
vim.api.nvim_set_hl(0, "DashboardColours", { fg = "#a3a6c2" })

dashboard.section.header.opts.hl = "DashboardColours"

new_file_but.opts.hl = "DashboardColours"
new_file_but.opts.hl_shortcut = "DashboardColours"
close_nvim_but.opts.hl = "DashboardColours"
close_nvim_but.opts.hl_shortcut = "DashboardColours"
file_file_but.opts.hl = "DashboardColours"
file_file_but.opts.hl_shortcut = "DashboardColours"
last_sess_butt.opts.hl = "DashboardColours"
last_sess_butt.opts.hl_shortcut = "DashboardColours"
open_sess_butt.opts.hl = "DashboardColours"
open_sess_butt.opts.hl_shortcut = "DashboardColours"

local handle = io.popen('fortune')
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = fortune

dashboard.config.opts.noautocmd = true

vim.cmd [[autocmd User AlphaReady echo 'ready']]

alpha.setup(dashboard.config)
