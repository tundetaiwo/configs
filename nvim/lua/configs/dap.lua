-- Force nvim to use your custom file whenever anything asks for 'dap.repl'
package.loaded['dap.repl'] = require('overwrite.dap_repl')

-- Now load dap normally
local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.after.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.after.event_exited["dapui_config"] = function()
	dapui.close()
end

dapui.setup {
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = ""
		}
	},
	element_mappings = {},
	expand_lines = true,
	floating = {
		border = "single",
		mappings = {
			close = { "q", "<Esc>" }
		}
	},
	force_buffers = true,
	icons = {
		collapsed = "",
		current_frame = "",
		expanded = ""
	},
	layouts = { {
		elements = { {
			id = "scopes",
			size = 0.25
		}, {
			id = "breakpoints",
			size = 0.25
		}, {
			id = "stacks",
			size = 0.25
		}, {
			id = "watches",
			size = 0.25
		} },
		position = "left",
		size = 40
	}, {
		elements = {
			{
				id = "repl",
				size = 1
			},
			-- {
			-- 	id = "console",
			-- 	size = 1
			-- }
		},
		position = "right",
		size = 100
	} },
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t"
	},
	render = {
		indent = 1,
		max_value_lines = 100
	}
}

local function run_dap_option_1()
	-- specific to buffer
	local ft = vim.bo.filetype
	local configs = dap.configurations[ft]

	if configs and configs[1] then
		dap.run(configs[1])
	else
		print("No debug config found at index 1 for filetype: " .. ft)
	end
end
-- Focus first window whose buffer has the filetype
local function focus_ft(ft)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == ft then
			vim.api.nvim_set_current_win(win)
			return true
		end
	end
	return false
end

local function ensure_and_focus(ft)
	if focus_ft(ft) then return true end
	local ok, dapui = pcall(require, "dapui")
	if not ok then return false end
	dapui.open()
	return focus_ft(ft)
end

vim.keymap.set("n", "<leader>df", function()
	require("dapui").float_element("scopes", { enter = true })
end, { desc = "Float Variables" })

-- Keymaps
vim.keymap.set("n", "<leader>ds", function() ensure_and_focus("dapui_scopes") end)
vim.keymap.set("n", "<leader>dk", function() ensure_and_focus("dapui_stacks") end)
vim.keymap.set("n", "<leader>dw", function() ensure_and_focus("dapui_watches") end)
vim.keymap.set("n", "<leader>db", function() ensure_and_focus("dapui_breakpoints") end)

vim.keymap.set('n', '<leader>dr', run_dap_option_1, { desc = "Run DAP Config #1" })

vim.keymap.set({ "i", "n" }, "<F5>", function()
	require("dap").continue()
end)
vim.keymap.set({ "i", "n" }, "<S-F5>", function()
	require("dap").terminate()
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

vim.keymap.set("n", "<leader>do", function()
	require("dapui").float_element("console", {
		width = math.floor(vim.o.columns * 1),
		height = math.floor(vim.o.lines * 0.90),
		enter = true,      -- focus the float
		position = "center", -- place in center of screen
	})
end)

vim.keymap.set('n', '<S-F9>', function()
	vim.ui.input({ prompt = 'Breakpoint Condition: ' }, function(condition)
		if condition then
			require('dap').set_breakpoint(condition)
		end
	end)
end, { desc = "Conditional Breakpoint" })

-- Python keymaps
vim.keymap.set("n", "<leader>dt", function() dap_python.test_method() end, { desc = "Test Python Function/Method" })
vim.keymap.set("n", "<leader>dc", function() dap_python.test_class() end, { desc = "Test Python Class" })

vim.keymap.set({ "n", "v" }, "<F3>", function() dapui.eval() end, { desc = "Inspect variable" })


