-- Keymaps
vim.keymap.set("i", "jj", "<ESC>")
vim.keymap.set("i", "<C-s>", "<cmd>w<CR>")

-- Buffer Commands
vim.keymap.set({"n", "i"}, "<A-k>", "<cmd>bnext<CR>", { desc = "go to next buffer"})
vim.keymap.set({"n", "i"}, "<A-j>", "<cmd>bprevious<CR>", { desc = "go to previous buffer"})
vim.keymap.set({"n", "i"}, "<A-1>", "<cmd>bfirst<CR>", { desc = "go to first buffer"})
vim.keymap.set({"n", "i"}, "<A-2>", "<cmd>bsecond<CR>", { desc = "go to second buffer"})
vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "buffer close" })
-- vim.keymap.set("n", "<leader>X", "<cmd>LastBuf<CR>", { desc = "re-open last closed buffer" }) -- TODO
-- vim.keymap.set("n", "<leader>x", "<cmd>w|bd<CR>", { desc = "buffer close" }) -- Need to get this to prompt for modified buffer
    
vim.keymap.set("n", "<leader>b", "<cmd>ls<CR>",{ desc = "buffer close" })

-- Comment
vim.keymap.set({"i", "n", "v" }, "<C-_>", "gcc", { desc = "Toggle Comment", remap = true })

-- Search
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>", { desc = "remove search highlighting"})

--  Window Movement
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

vim.keymap.set("i", "<C-h>", "<Left>", { desc = "move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "move up" })

-- Terminal Movement
-- local opts = {buffer = 0}
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])

-- Telescope
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "telescope find files" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "telescope find files" })
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
vim.keymap.set("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
vim.keymap.set("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
vim.keymap.set("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" }) -- Currently not working?
vim.keymap.set(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- Nvim Tree
vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })


vim.keymap.set("n", "<leader>it", "<cmd>ToggleTerm size=40 direction=float<CR>", { desc = "create interactive terminal" })
-- lspconfig
-- local function opts(desc)
--   return { buffer = bufnr, desc = "LSP " .. desc }
-- end
-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
-- vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")

-- Toggle Term
-- mappings are in configs/toggleterm.lua
-- vim.keymap.set({"n", "t"}, "<A-h>", "<cmd>ToggleTerm size=25 direction=horizontal<CR>")
-- vim.keymap.set({"n", "t"}, "<A-v>", "<cmd>ToggleTerm size=50 direction=vertical<CR>")
-- vim.keymap.set({"n", "t"}, "<A-i>", "<cmd>ToggleTerm size=40 direction=float<CR>")
