-- Cell Navigation
local delimiter = "^#\\s*%%" -- Adjust this if your delimiter differs

local function move_to_prev_cell()
	local current_line = vim.fn.line('.')
	local prev_cell_line = vim.fn.search(delimiter, 'bn')

	if current_line > prev_cell_line then
		vim.api.nvim_win_set_cursor(0, { prev_cell_line, 0 })
	end
end

local function move_to_next_cell()
	local current_line = vim.fn.line('.')
	local next_cell_line = vim.fn.search(delimiter, 'n')

	if current_line < next_cell_line then
		vim.api.nvim_win_set_cursor(0, { next_cell_line, 0 })
	end
end

vim.keymap.set("n", "<A-C-k>", move_to_prev_cell, { silent = true }) -- Next cell
vim.keymap.set("n", "<A-C-j>", move_to_next_cell, { silent = true }) -- Next cell

local function send_cell_and_advance()
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes('<Plug>SlimeSendCell', true, true, true),
		'n',
		true
	)
	move_to_next_cell()
end

vim.keymap.set("n", "<A-r>", send_cell_and_advance, { silent = true })
vim.keymap.set("n", "<S-A-r>", "<Plug>SlimeSendCell", { remap = true, silent = false })

-- Change Active Terminal For Sending Code
vim.keymap.set("n", "<leader>ct", "<Cmd>SlimeConfig<CR>")
