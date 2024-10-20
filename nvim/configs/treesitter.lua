pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  ensure_installed = {
    "vim",
    "vimdoc",
    "lua",
    "rust",
    "html",
    "css",
    "python",
    "cpp",
    "latex",
    "markdown",
    "comment"
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}
