local Terminal  = require('toggleterm.terminal').Terminal
-- Float Window --
  -- size=70,
local float_window = Terminal:new({
  direction = "float",
  float_opts =  {
    border = "double",
    size = 40,
  },
  close_on_exit = true,
})

function _window_toggle(window)
	window:toggle()
	-- change to insert mode when toggling
	if window:is_open() then
		window:set_mode("i")
	end
end
vim.keymap.set("n", "<A-i>", function() _window_toggle(float_window) end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-i>", function() _window_toggle(float_window) end, { noremap = true, silent = true })


-- Vertical Window --
local vertical_window = Terminal:new({
  direction = "vertical",
  close_on_exit = true,
})
vertical_window:resize(30)
vim.keymap.set("n", "<A-v>", function() _window_toggle(vertical_window) end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-v>", function() _window_toggle(vertical_window) end, { noremap = true, silent = true })

-- Horizonal Window --
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
    -- size = 10,
    title_pos = "center"
  },
})

vim.keymap.set("n", "<A-g>", function() _window_toggle(lazygit) end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-g>", function() _window_toggle(lazygit) end, { noremap = true, silent = true })


-- Interactive Window --
local interactive_window = Terminal:new({
  cmd = "ipython --autoindent",
  display_name = "Interactive Window",
  direction = "vertical",
})
interactive_window:resize(vim.o.columns * 0.5)

vim.keymap.set("n", "<leader>ip", function() _window_toggle(interactive_window) end, { noremap = true, silent = true })
vim.keymap.set("t", "<leader>ip", function() _window_toggle(interactive_window) end, { noremap = true, silent = true })
