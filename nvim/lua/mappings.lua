-- NOTE: if mappings is slow use `:verbose map <mapping>` to check what other things are mapped to it

-- Keymaps
vim.keymap.set("i", "jj", "<ESC>")
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<CR>", { desc = "save buffer with ctrl+s" })
vim.keymap.set("i", "<S-tab>", "<BS>", { desc = "unindent", remap = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "keep cursor in middle scrolling down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "keep cursor in middle scrolling up" })

-- Paste & Yank
vim.keymap.set("v", "<leader>_", "\"_d", { desc = "delete to void" })

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "yank to clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "yank whole line to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p", { desc = "paste clipboard after" })
vim.keymap.set({ "n", "v" }, "<leader>P", "\"+P", { desc = "paste clipboard before" })

vim.keymap.set({ "n", "v" }, "y", "\"0y")
vim.keymap.set({ "n", "v" }, "x", "\"0x")
vim.keymap.set({ "n", "v" }, "d", "\"0d")
vim.keymap.set({ "n", "v" }, "D", "\"0D")
vim.keymap.set({ "n", "v" }, "c", "\"0c")
vim.keymap.set({ "n", "v" }, "C", "\"0C")
vim.keymap.set({ "n", "v" }, "s", "\"0s")
vim.keymap.set({ "n", "v" }, "S", "\"0S")
vim.keymap.set({ "n", "v" }, "p", "\"0p")
vim.keymap.set({ "n", "v" }, "P", "\"0P")

-- Move Selection Up & Down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual selected block down 1 line" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual selected block up 1 line" })

-- Stay in middle whilst search
vim.keymap.set("n", "n", "nzzzv", { desc = "When searching keep cursor in middle" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "When searching keep cursor in middle" })

-- Buffer Commands
vim.keymap.set("n", "<leader>-", "<C-6>", { remap = true, desc = "go to previous buffer" })
vim.keymap.set('n', '<leader>x', "<cmd>bp|bd #<CR>", { desc = "close buffer without closing window" })
vim.keymap.set('n', '<leader><C-x>', "<cmd>bd!<CR>", { desc = "force close buffer without closing window" })
vim.keymap.set('n', '<leader><S-x>', '<cmd>e #<CR>', { desc = "re-open last closed buffer" })
vim.keymap.set("t", "<A-x>", "<cmd>bd!<CR>", { desc = "terminal buffer close" })

vim.keymap.set("n", "<leader>b", "<cmd>ls<CR>", { desc = "buffer close" })

-- Comment
vim.keymap.set({ "i", "n" }, "<C-_>", "gcc", { desc = "Toggle Comment", remap = true })
vim.keymap.set("v", "<C-_>", "gc", { desc = "Toggle Comment", remap = true })

-- Search
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>", { desc = "remove search highlighting" })

-- NvimTree Toggle and state tracking
local treeActive = false
local function toggleTree()
	vim.cmd("NvimTreeToggle")
	treeActive = not treeActive
end

vim.keymap.set("n", "<C-b>", toggleTree, { desc = "Toggle NvimTree" })

-- Window movement key mappings
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Switch window left", noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Switch window right", noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Switch window down", noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Switch window up", noremap = true })
vim.keymap.set("n", "<C-w>x", "<cmd>close<CR>", { desc = "Close window", noremap = true })
vim.keymap.set("n", "<C-w>c", "<Nop>", { desc = "Disable default close mapping", noremap = true })

local maximised = false
local saved_win = nil
local toggle_maximise = function()
	if maximised then
		vim.cmd("wincmd =")
		maximised = false
		if treeActive then
			-- activate toggleTree twice to restore it
			toggleTree()
			toggleTree()
			vim.cmd("wincmd =")
		end
		if saved_win and vim.api.nvim_win_is_valid(saved_win) then
			vim.api.nvim_set_current_win(saved_win)
		end
	else
		saved_win = vim.api.nvim_get_current_win() -- Save the current window.
		vim.cmd("wincmd |")                      -- Maximize width.
		vim.cmd("wincmd _")                      -- Maximize height.
		maximised = true
	end
end
vim.keymap.set("n", "<leader>km", toggle_maximise
, { desc = "Toggle window maximisation", noremap = true })

-- Tabs
vim.keymap.set("n", "<leader>tc", "<cmd>tabnew<CR>")
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>")
vim.keymap.set("n", "<A-k>", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<A-j>", "<cmd>tabprevious<CR>")


-- Terminal Movement
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])

-- Telescope
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "telescope find files" })
vim.keymap.set("n", "<leader><S-f><S-f>", "<cmd>Telescope find_files follow=true no_ignore=true hidden=false<CR>")
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
vim.keymap.set("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
vim.keymap.set("n", "<leader>th", "<cmd>Telescope colorscheme<CR>", { desc = "telescope choose colorscheme" })
vim.keymap.set("n", "<leader>f<S-w>", function()
		require('telescope.builtin').live_grep({
			additional_args = function(args)
				return vim.list_extend(args, { "--no-ignore" })
			end,
		})
	end,
	{ desc = "grep all files" }
)
vim.keymap.set("n", "<leader>ts", function()
		require("telescope.builtin").resume()
	end,
	{
		noremap = true,
		silent = true,
	}
)
vim.keymap.set("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>",
	{ desc = "telescope find in current buffer" })

vim.keymap.set("n", "<C-x>", function()
		require('telescope.actions').delete_buffer()
	end,
	{ desc = "delete buffer in buffer picker" }
)
vim.keymap.set("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" }) -- Currently not working?
vim.keymap.set(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "telescope find all files" }
)


-- DebugPy
vim.keymap.set({ "i", "n" }, "<F5>", function()
	require("dap").continue()
end)
vim.keymap.set({ "i", "n" }, "<S-F5>", function()
	require("dap").disconnect()
end)
vim.keymap.set({ "i", "n" }, "<F10>", function()
	require("dap").step_over()
end)
vim.keymap.set({ "i", "n" }, "<F11>", function()
	require("dap").step_into()
end)
vim.keymap.set({ "i", "n" }, "<F12>", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<F9>", function()
	require("dap").set_breakpoint()
end)
-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set("n", "<Leader>df", function()
	require("dap").continue()
end)

vim.keymap.set("n", "<leader>du", function()
	require("dapui").toggle({})
end
)

vim.keymap.set("n", "<F9>", "<cmd> DapToggleBreakpoint <CR>")
vim.keymap.set("n", "<leader>dlb", function()
	require("dap").list_breakpoints()
end)

-- Format file
vim.keymap.set("n", "<leader>fm", function()
	require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- Sessions
-- select a session to load
vim.keymap.set("n", "<leader>sl", function() require("persistence").select() end)

-- load the last session
vim.keymap.set("n", "<leader>ls", function() require("persistence").load() end)

-- Nvim Diff
vim.keymap.set("n", "<leader>oc", "<cmd>DiffviewOpen<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>DiffviewFileHistory<CR>")

-- Copy Current Work Directory
vim.api.nvim_create_user_command("CopyRelPath", "call setreg('+', expand('%'))", {})
vim.api.nvim_create_user_command("CopyAbsPath", function() vim.fn.setreg('+', vim.fn.expand('%:p')) end, {})
vim.api.nvim_create_user_command("CopyAbsDir", function() vim.fn.setreg('+', vim.fn.expand('%:p:h')) end, {})

vim.keymap.set("n", "<leader>cr", "<cmd>CopyRelPath<CR>")
vim.keymap.set("n", "<leader>ca", "<cmd>CopyAbsPath<CR>")
vim.keymap.set("n", "<leader>cd", "<cmd>CopyAbsDir<CR>")

-- Slime
vim.keymap.set("n", "<A-C-j>", [[/^#\s*%%<CR>]], { silent = true }) -- Next cell
vim.keymap.set("n", "<A-C-k>", [[?^#\s*%%<CR>]], { silent = true }) -- Previous cell


local rename_tab = function()
	local name = vim.fn.input("Rename Tab: ")
	vim.cmd("TabRename " .. name)
end

vim.keymap.set("n", "<leader>t$", rename_tab)


-- Remove Mappings
vim.keymap.set("n", "dk", "<nop>", { desc = "stop dk from deleting current and above line" })
vim.keymap.set("n", "dj", "<nop>", { desc = "stop dj from deleting current and below line" })
