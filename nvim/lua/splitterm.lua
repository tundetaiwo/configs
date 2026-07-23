-- Split terminals with per-tab windows: one split terminal visible per tab,
-- terminal buffers shared across tabs (closing a window never kills the job).
-- Floating terminals and lazygit remain in configs/toggleterm.lua.

local M = {}

local terms = {
	vertical = {
		direction = "vertical",
		size = 30,
	},
	horizontal = {
		direction = "horizontal",
		size = 12,
	},
	ipython1 = {
		cmd = "ipython --autoindent",
		direction = "vertical",
		size = function()
			return math.floor(vim.o.columns * 0.5)
		end,
		needs_ipython = true,
	},
	ipython2 = {
		cmd = "ipython --autoindent",
		direction = "vertical",
		size = function()
			return math.floor(vim.o.columns * 0.5)
		end,
		needs_ipython = true,
	},
}

M.autofocus = true

function M.autofocus_enabled()
	return M.autofocus
end

local function ipython_available()
	return vim.fn.executable("ipython") == 1
end

local function show_error_message()
	vim.api.nvim_err_writeln("Error: IPython is not available in your environment.\n" ..
		"Please install IPython or activate your virtual environment.")
end

local function job_alive(term)
	return term.job_id ~= nil and vim.fn.jobwait({ term.job_id }, 0)[1] == -1
end

local function ensure_term(key, term)
	if term.bufnr and vim.api.nvim_buf_is_valid(term.bufnr) and job_alive(term) then
		return
	end

	local buf = vim.api.nvim_create_buf(false, false)
	vim.api.nvim_buf_call(buf, function()
		term.job_id = vim.fn.jobstart(term.cmd or vim.o.shell, {
			term = true,
			on_exit = function()
				vim.schedule(function()
					if term.bufnr and vim.api.nvim_buf_is_valid(term.bufnr) then
						vim.api.nvim_buf_delete(term.bufnr, { force = true })
					end
					term.bufnr = nil
					term.job_id = nil
				end)
			end,
		})
	end)
	vim.b[buf].splitterm_key = key
	vim.bo[buf].bufhidden = "hide"
	term.bufnr = buf
end

-- Find the split-terminal window in the current tab, if any
local function find_term_win_in_tab()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local buf = vim.api.nvim_win_get_buf(win)
		local key = vim.b[buf].splitterm_key
		if key then
			return win, key
		end
	end
	return nil, nil
end

-- Remember a terminal window's current size so toggling restores it (a manual
-- resize should survive a close/reopen instead of snapping back to the default).
local function capture_size(win, term)
	if term.direction == "vertical" then
		term.saved_size = vim.api.nvim_win_get_width(win)
	else
		term.saved_size = vim.api.nvim_win_get_height(win)
	end
end

local function open_win(term)
	local size = term.saved_size or term.size
	if type(size) == "function" then
		size = size()
	end

	local win_opts = { win = -1 }
	if term.direction == "vertical" then
		win_opts.split = "right"
		win_opts.width = size
	else
		win_opts.split = "below"
		win_opts.height = size
	end
	local win = vim.api.nvim_open_win(term.bufnr, true, win_opts)

	vim.wo[win].winfixwidth = true
	vim.wo[win].winfixheight = true
	vim.wo[win].number = false
	vim.wo[win].relativenumber = false
	vim.wo[win].signcolumn = "no"
	if term.needs_ipython then
		vim.wo[win].statusline = "Terminal: " .. term.job_id
	end

	if M.autofocus then
		vim.cmd.startinsert()
	end
end

local function close_win(win)
	local ok = pcall(vim.api.nvim_win_close, win, true)
	if not ok then
		-- sole window of the sole tab: swap in an empty buffer instead
		vim.api.nvim_win_set_buf(win, vim.api.nvim_create_buf(true, false))
	end
end

function M.toggle(key)
	local term = terms[key]
	if term.needs_ipython and not ipython_available() then
		show_error_message()
		return
	end

	local win, open_key = find_term_win_in_tab()
	if win then
		capture_size(win, terms[open_key])
		close_win(win)
		if open_key == key then
			return
		end
	end

	ensure_term(key, term)
	open_win(term)
end

-- Close every split-terminal window across all tabs (jobs keep running).
-- Used by auto-session before saving so sessions restore terminal-free.
function M.close_all_windows()
	for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
			local buf = vim.api.nvim_win_get_buf(win)
			local key = vim.b[buf].splitterm_key
			if key then
				capture_size(win, terms[key])
				close_win(win)
			end
		end
	end
end


vim.keymap.set({ "n", "t" }, "<A-v>", function() M.toggle("vertical") end, { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<A-h>", function() M.toggle("horizontal") end, { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<A-p>", function() M.toggle("ipython1") end, { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<A-o>", function() M.toggle("ipython2") end, { noremap = true, silent = true })

vim.keymap.set({ "n", "t" }, "<A-m>", function()
	M.autofocus = not M.autofocus
	print("Terminal Auto-Focus: " .. tostring(M.autofocus))
end)

vim.keymap.set("t", "<A-,>", function() print(vim.b.terminal_job_id) end)

return M
