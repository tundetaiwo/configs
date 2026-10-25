-- Close every file buffer and land on the alpha dashboard.
-- Terminals (splitterm/toggleterm: claude, lazygit, ipython, ...), nvim-tree and
-- other special buffers are left alone, as are buffers with unsaved changes and
-- buffers still shown in another tab.

local M = {}

-- A "file" window/buffer is a plain buffer (buftype == "") that isn't floating.
local function is_file_buf(buf)
	return vim.bo[buf].buftype == ""
end

local function is_file_win(win)
	return vim.api.nvim_win_get_config(win).relative == ""
		and (is_file_buf(vim.api.nvim_win_get_buf(win)) or vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "alpha")
end

function M.close_all()
	local tab = vim.api.nvim_get_current_tabpage()
	local tab_wins = vim.api.nvim_tabpage_list_wins(tab)

	-- Pick the window alpha will live in: the current one if it holds a file,
	-- otherwise the first file window in this tab, otherwise a new split.
	local target = vim.api.nvim_get_current_win()
	if not is_file_win(target) then
		target = nil
		for _, win in ipairs(tab_wins) do
			if is_file_win(win) then
				target = win
				break
			end
		end
	end
	if not target then
		vim.cmd("vnew")
		target = vim.api.nvim_get_current_win()
	end

	-- Collapse the other file windows in this tab (terminals and nvim-tree stay).
	for _, win in ipairs(tab_wins) do
		if win ~= target and vim.api.nvim_win_is_valid(win) and is_file_win(win) then
			pcall(vim.api.nvim_win_close, win, false)
		end
	end

	vim.api.nvim_set_current_win(target)
	if vim.bo.filetype ~= "alpha" then
		require("alpha").start(false)
	end

	-- Buffers visible in other tabs are kept so those layouts aren't touched.
	local visible_elsewhere = {}
	for _, t in ipairs(vim.api.nvim_list_tabpages()) do
		if t ~= tab then
			for _, win in ipairs(vim.api.nvim_tabpage_list_wins(t)) do
				visible_elsewhere[vim.api.nvim_win_get_buf(win)] = true
			end
		end
	end

	local skipped = {}
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buflisted and is_file_buf(buf) and not visible_elsewhere[buf] then
			if vim.bo[buf].modified then
				table.insert(skipped, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":~:."))
			else
				pcall(vim.api.nvim_buf_delete, buf, {})
			end
		end
	end

	if #skipped > 0 then
		vim.notify("Kept buffers with unsaved changes:\n  " .. table.concat(skipped, "\n  "), vim.log.levels.WARN)
	end
end

vim.api.nvim_create_user_command("BufCloseAll", M.close_all,
	{ desc = "close all file buffers (keeps terminals) and open alpha" })

return M
