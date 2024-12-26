-- Make Background Transparent
vim.cmd([[ 
    hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
    hi SignColumn guibg=NONE ctermbg=NONE
]])

-- Make empty lines after end of file have " " instead of "~"
vim.o.fillchars = "eob: "
