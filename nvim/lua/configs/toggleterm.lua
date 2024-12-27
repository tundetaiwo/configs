local Terminal  = require('toggleterm.terminal').Terminal
-- Float Window --
local float_window = Terminal:new({
  direction = "float",
  -- size=70,
  float_opts =  {
    border = "double",
    size = 40,
  },
  close_on_exit = true,
})
function _float_toggle()
  float_window:toggle()
end

vim.api.nvim_set_keymap("n", "<A-i>", "<cmd>lua _float_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("t", "<A-i>", "<cmd>lua _float_toggle()<CR>", {noremap = true, silent = true})

-- Vertical Window --
local vertical_window = Terminal:new({
  direction = "vertical",
  close_on_exit = true,
})
vertical_window:resize(30)
function _vertical_toggle()
  vertical_window:toggle()
end
vim.api.nvim_set_keymap("n", "<A-v>", "<cmd>lua _vertical_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("t", "<A-v>", "<cmd>lua _vertical_toggle()<CR>", {noremap = true, silent = true})

-- Horizonal Window --
local horizonal_window = Terminal:new({
  direction = "horizontal",
  close_on_exit = true,
})

function _horizonal_toggle()
  horizonal_window:toggle()
end
vim.api.nvim_set_keymap("n", "<A-h>", "<cmd>lua _horizonal_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("t", "<A-h>", "<cmd>lua _horizonal_toggle()<CR>", {noremap = true, silent = true})


-- Lazy Git --
local lazygit = Terminal:new({
  display_name = "Lazy Git",
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
    size = 10,
  },
  shading_factor = 0,
  persist_size = false,
  persist_mode = false,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<A-g>", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("t", "<A-g>", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})


-- Interactive Window --
local interactive_window = Terminal:new({
  cmd = "ipython --autoindent",
  display_name = "Interactive Window",
  direction = "vertical",
})
interactive_window:resize(vim.o.columns * 0.5)
function _interactive_window_toggle()
  interactive_window:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>ip", "<cmd>lua _interactive_window_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("t", "<leader>ip", "<cmd>lua _interactive_window_toggle()<CR>", {noremap = true, silent = true})
