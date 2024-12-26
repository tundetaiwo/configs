return {
  --  Telescope
  {
    -- dir = vim.fn.stdpath("data") .. "/lazy/telescope-nvim"
    dir = "/Users/tundetaiwo/.local/share/nvim/lazy/telescope.nvim"

  },
  -- Nvim Tree
  {
    dir = "/Users/tundetaiwo/.local/share/nvim/lazy/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
    end,
  },
}


