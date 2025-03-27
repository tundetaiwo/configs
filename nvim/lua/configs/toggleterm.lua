local Terminal = require('toggleterm.terminal').Terminal


require('toggleterm').setup({
	on_enter = function()
		vim.cmd('startinsert!')
	end,
})


-- Helper function to check if ipython is available
local function check_ipython()
	local handle = io.popen("which ipython 2>/dev/null")
	if handle then
		local result = handle:read("*a")
		handle:close()
		return result ~= ""
	end
	return false
end

-- Helper function to show error message
local function show_error_message()
	vim.api.nvim_err_writeln("Error: IPython is not available in your environment.\n" ..
		"Please install IPython or activate your virtual environment.")
end


local on_enter_toggle = true

vim.keymap.set({ "n", "t" }, "<A-m>", function()
	on_enter_toggle = not on_enter_toggle
	print("Terminal Auto-Focus: " .. tostring(on_enter_toggle))
end)

function _window_toggle(window)
	-- Special handling for interactive window
	if window == interactive_window and not check_ipython() then
		show_error_message()
		return
	end

	window:toggle()
	-- change to insert mode when toggling
	if window:is_open() then
		if on_enter_toggle then
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

vim.keymap.set({ "n", "t" }, "<A-i>", function() _window_toggle(float_window_1) end, { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<A-q>", function() _window_toggle(float_window_2) end, { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<A-w>", function() _window_toggle(float_window_3) end, { noremap = true, silent = true })

-- Vertical Window --
local vertical_window = Terminal:new({
	direction = "vertical",
	close_on_exit = true,
})
vertical_window:resize(30)
vim.keymap.set("n", "<A-v>", function() _window_toggle(vertical_window) end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-v>", function() _window_toggle(vertical_window) end, { noremap = true, silent = true })

-- Horizontal Window --
local horizontal_window = Terminal:new({
	direction = "horizontal",
	close_on_exit = true,
})

vim.keymap.set("n", "<A-h>", function() _window_toggle(horizontal_window) end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-h>", function() _window_toggle(horizontal_window) end, { noremap = true, silent = true })

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

-- Interactive Window --
local interactive_window
if check_ipython() then
	interactive_window = Terminal:new({
		cmd = "ipython --autoindent",
		display_name = "Interactive Window",
		direction = "vertical",
		size = function()
			return vim.o.columns * 0.5
		end,
		on_open = function(term)
			term:resize(vim.o.columns * 0.5)
		end
	})
end
vim.keymap.set("t", "<A-,>",function() print(interactive_window.job_id) end)

vim.keymap.set("n", "<A-p>", function()
	_window_toggle(interactive_window)
	vim.wo.statusline = 'Terminal: ' .. interactive_window.job_id
end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-p>", function() _window_toggle(interactive_window) end, { noremap = true, silent = true })


vim.keymap.set("t", "<C-u", "<C-\\><C-n><C-u>",
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


-- Close and Save all Open Buffers
vim.api.nvim_create_user_command("Wqa", function()
  local term_mod = require("toggleterm.terminal")
  for _, term in ipairs(term_mod.get_all(true)) do

    term:shutdown()
  end
  -- Now write all and quit
  vim.cmd("wqa")
end, {})

