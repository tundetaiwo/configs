local Terminal = require('toggleterm.terminal').Terminal


require('toggleterm').setup({})


-- Split terminals (<A-v>/<A-h>/<A-p>/<A-o>) live in lua/splitterm.lua;
-- toggleterm only handles the floating terminals and lazygit.
local function _window_toggle(window)
	window:toggle()
	-- change to insert mode when toggling
	if window:is_open() then
		if require("splitterm").autofocus_enabled() then
			window:set_mode("i")
		end
	end
end


-- Float Window --
local float_window_1 = Terminal:new({
	display_name = "Terminal 1",
	direction = "float",
	float_opts = {
		border = "double",
		size = 40,
	},
	close_on_exit = true,
})
local float_window_2 = Terminal:new({
	display_name = "Terminal 2",
	direction = "float",
	float_opts = {
		border = "double",
		size = 40,
	},
	close_on_exit = true,
})
local float_window_3 = Terminal:new({
	display_name = "Terminal 3",
	direction = "float",
	float_opts = {
		border = "double",
		size = 40,
	},
	close_on_exit = true,
})
local float_window_4 = Terminal:new({
	display_name = "Terminal 4",
	direction = "float",
	float_opts = {
		border = "double",
		size = 40,
	},
	close_on_exit = true,
})
local float_window_5 = Terminal:new({
	display_name = "Terminal 5",
	direction = "float",
	float_opts = {
		border = "double",
		size = 40,
	},
	close_on_exit = true,
})

vim.keymap.set({ "n", "t" }, "<A-i>", function() _window_toggle(float_window_1) end, { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<A-1>", function() _window_toggle(float_window_1) end, { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<A-2>", function() _window_toggle(float_window_2) end, { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<A-3>", function() _window_toggle(float_window_3) end, { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<A-4>", function() _window_toggle(float_window_4) end, { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<A-5>", function() _window_toggle(float_window_5) end, { noremap = true, silent = true })

-- Lazy Git --
local lazygit = Terminal:new({
	display_name = "Lazy Git",
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "double",
		title_pos = "center"
	},
})

vim.keymap.set("n", "<A-g>", function() _window_toggle(lazygit) end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-g>", function() _window_toggle(lazygit) end, { noremap = true, silent = true })


-- Claude --
-- Three persistent Claude sessions sharing one floating slot. <A-c> toggles the
-- current session; <A-n>/<A-p> (buffer-local, so they only act inside a Claude
-- float) cycle to the next/previous session, swapping the visible float.
local NUM_CLAUDE = 3
local claude_current = 1
local claude_sessions = {}
-- per-session border colours so each Claude float is distinguishable at a glance
local claude_border_colors = { "#f38ba8", "#a6e3a1", "#89b4fa" }

local function claude_cycle(delta)
	local from = claude_sessions[claude_current]
	claude_current = ((claude_current - 1 + delta) % NUM_CLAUDE) + 1
	local to = claude_sessions[claude_current]
	if from and from ~= to and from:is_open() then
		from:close()
	end
	to:open()
	if require("splitterm").autofocus_enabled() then
		to:set_mode("i")
	end
end

for i = 1, NUM_CLAUDE do
	claude_sessions[i] = Terminal:new({
		display_name = "Claude " .. i,
		cmd = "claude",
		dir = "git_dir",
		direction = "float",
		close_on_exit = true,
		float_opts = {
			border = "double",
			title_pos = "left",
		},
		highlights = {
			FloatBorder = { guifg = claude_border_colors[i] },
		},
		on_open = function(term)
			vim.keymap.set({ "n", "t" }, "<A-n>", function() claude_cycle(1) end,
				{ noremap = true, silent = true, buffer = term.bufnr })
			vim.keymap.set({ "n", "t" }, "<A-p>", function() claude_cycle(-1) end,
				{ noremap = true, silent = true, buffer = term.bufnr })
		end,
	})
end

vim.keymap.set({ "n", "t" }, "<A-c>", function() _window_toggle(claude_sessions[claude_current]) end,
	{ noremap = true, silent = true })


vim.keymap.set("t", "<C-u>", "<C-\\><C-n><C-u>",
	{ noremap = true, silent = true, desc = "scroll up in terminal" })

vim.keymap.set("t", "<A-d>", "<C-\\><C-n>", { noremap = true, desc = "escape terminal mode" })

-- Function to echo the current terminal ID
function _G.echo_terminal_id()
	local term_id = vim.b.toggle_number
	if term_id then
		print("Terminal ID: " .. term_id)
	else
		print("Not in a ToggleTerm buffer.")
	end
end
