require("csvview").setup()
vim.keymap.set("n", "<leader>csv", "<cmd>CsvViewToggle display_mode=border<CR>")
vim.keymap.set("n", "<leader>csi", "<cmd>CsvViewInfo<CR>")
