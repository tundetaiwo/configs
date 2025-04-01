vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = ""

vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.incsearch = true

-- Indenting
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.opt.scrolloff = 7

vim.opt.updatetime = 500


-- Snippets Path
vim.g.vscode_snippets_path = vim.fn.stdpath("config") .. "/lua/snippets/"

if jit.os == "OSX" then
	vim.opt.shell = "/bin/zsh"
else
	vim.opt.shell = "/usr/bin/zsh"
end
