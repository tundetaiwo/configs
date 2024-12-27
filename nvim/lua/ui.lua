-- Chose Theme
vim.cmd.colorscheme "catppuccin"

-- Make empty lines after end of file have " " instead of "~"
-- vim.o.fillchars = "eob: "

-- Make Background Transparent
vim.cmd([[ 
    hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
    hi SignColumn guibg=NONE ctermbg=NONE
    hi NvimTreeNormal guibg=NONE ctermbg=NONE
    "hi ToggleTermVeritcal guibg=NONE ctermbg=NONE
]])
