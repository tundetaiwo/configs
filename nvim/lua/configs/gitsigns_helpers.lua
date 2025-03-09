local M = {}
M.open_diff_new_tab = function(absolute_path, relative_path)
	absolute_path = absolute_path
	relative_path = relative_path

	if absolute_path == '' then
		print("No file loaded")
		return
	end
	-- Open the current file in a new tab
	vim.cmd("tabnew " .. vim.fn.fnameescape(absolute_path))
	vim.cmd("TabRename " .. "Diff - " .. relative_path)

	-- -- Call gitsigns diffthis on the new tab
	require("gitsigns").diffthis()
end


return M
