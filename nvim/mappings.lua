require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("i", "jj", "<ESC>")

-- Comment
map({ "i", "n" }, "<C-_>", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<C-_>", "gc", { desc = "Toggle comment", remap = true })

-- Telescope
-- map({"i", "n"},"<C-p>",  "<cmd> Telescope find_files follow=true hidden=false <CR>", {desc="Find all" })

-- Less Useful Keybindings (Telescope)
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)
-- Git
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })

-- Nvim Tree
map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map({ "i", "n" }, "<C-S-e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- File Management
map({ "n", "i" }, "<C-n>", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<A-k>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })
map("n", "<C-w>w", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer goto next" })

map("n", "<A-j>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

-- Tabs
map("i", "<S-tab>", "<BS>", { desc = "unindent", remap = true })

-- DebugPy --
map("n", "<F5>", function()
  require("dap").continue()
end)
map("n", "<S-F5>", function()
  require("dap").disconnect()
end)
map("n", "<F10>", function()
  require("dap").step_over()
end)
map("n", "<F11>", function()
  require("dap").step_into()
end)
map("n", "<F12>", function()
  require("dap").step_out()
end)
map("n", "<Leader>b", function()
  require("dap").toggle_breakpoint()
end)
map("n", "<F9>", function()
  require("dap").set_breakpoint()
end)
-- map('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
map("n", "<Leader>df", function()
  require("dap").continue()
end)
map("n", "<Leader>dr", function()
  require("dap").repl.open()
end)

map("n", "<F9>", "<cmd> DapToggleBreakpoint <CR>")
map("n", "<leader>dlb", function()
  require("dap").list_breakpoints()
end)
