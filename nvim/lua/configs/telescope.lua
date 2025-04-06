local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local gs_helpers = require("configs.gitsigns_helpers")


local function switch_and_delete_buffer(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local selection = current_picker:get_selection()
  actions.close(prompt_bufnr)  -- Close the Telescope prompt

  -- Switch to the previous buffer
  vim.cmd("bp")

  -- Delete the buffer that was selected in Telescope
  vim.schedule(function()
    vim.api.nvim_buf_delete(selection.bufnr, { force = true })
  end)
end



require("telescope").setup {
	defaults = {
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = " ",
		sorting_strategy = "descending",
		layout_config = {
			horizontal = {
				prompt_position = "bottom",
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.80,
		},
		mappings = {
			n = {
				["q"] = require("telescope.actions").close,
				["<C-x>"] = switch_and_delete_buffer,
			},
		},
	},
	extensions_list = { "themes", "terms" },
	extensions = {},
	pickers = {
		buffers = {
			initial_mode = "normal"
		},
		git_status = {
			initial_mode = "normal",
			layout_strategy = "horizontal",
			layout_config = {
				preview_width = 0.7, -- You can adjust this for the git_status picker specifically
			},
		}
	},
}

require('telescope').load_extension('fzf')

-- Git Status Picker Opens Git Signs Diff View via New Tab--
local function open_diff_with_gitsigns(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	if not selection then
		return
	end
	actions.close(prompt_bufnr)
	local relative_path = selection.value
	local absolute_path = selection.path or vim.fn.fnamemodify(relative_path, ":p")
	gs_helpers.open_diff_new_tab(absolute_path, relative_path)
end

local function custom_git_status()
	require("telescope.builtin").git_status({
		attach_mappings = function(prompt_bufnr, map)
			map({ "n", "i" }, "<CR>", open_diff_with_gitsigns)
			return true
		end,
	})
end

-- Set a key mapping for the custom git_status picker.
vim.keymap.set("n", "<leader>gs", custom_git_status, {
	desc = "Custom Git Status: open diff with gitsigns",
	noremap = true,
})

-- Keymaps
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "telescope find files" })
vim.keymap.set("n", "<leader><S-f><S-f>", "<cmd>Telescope find_files follow=true no_ignore=true hidden=false<CR>")
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
vim.keymap.set("n", "<leader>sr", "<cmd>Telescope lsp_references<CR>")
vim.keymap.set("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
vim.keymap.set("n", "<leader>th", "<cmd>Telescope colorscheme<CR>", { desc = "telescope choose colorscheme" })
vim.keymap.set("n", "<leader>ga", "<cmd>Telescope git_status<CR>", { desc = "telescope choose colorscheme" })
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
