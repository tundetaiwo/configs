local plugin_folder = "/Users/tundetaiwo/.local/share/nvim/lazy/"
plugins = {
  --  Autopairs
  {
    dir = plugin_folder .. "nvim-autopairs",
    event = "InsertEnter",
    config = true,
    lazy = false,
  },
  -- Nvim Surround
  {
    dir = plugin_folder .. "nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
  --  Telescope
  {
    dir = "/Users/tundetaiwo/.local/share/nvim/lazy/plenary.nvim"
  },
  {
    dir = plugin_folder .. "telescope.nvim",
    lazy = true,
    -- dependencies = {dir = "/Users/tundetaiwo/.local/share/nvim/lazy/plenary.nvim"},
    -- opts = function()
      -- return require("configs.telescope")
    -- end,
    opts = require("configs.telescope")
  },
  -- Nvim Tree
  {
    dir = plugin_folder .. "nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = require("configs.nvimtree"),
  },
  -- lspconfig
  {
    dir = plugin_folder .. "nvim-lspconfig",
  },
  -- treesitter
  {
    dir = plugin_folder .. "nvim-treesitter",
    -- opts = require("configs.treesitter"),
  },
  -- toggleterm
  {
    dir = plugin_folder .. "toggleterm.nvim",
    opts = require("configs.toggleterm"),
  },
}
-- ToggleTerm size=40 dir=~/ direction=float name=desktop
return plugins
