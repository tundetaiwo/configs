local plugin_folder = "/Users/tundetaiwo/.local/share/nvim/lazy/"
local plugins = {
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
    dir = plugin_folder .. "plenary.nvim"
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
    dependencies = {
      dir = plugin_folder .. "nvim-web-devicons",
    },
  },
  -- lspconfig
  {
    dir = plugin_folder .. "nvim-lspconfig",
    config = function()
      require("configs.lspconfig")
    end,
  },
  -- treesitter
  {
    dir = plugin_folder .. "nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opt = function()
      return require "configs.treesitter"
    end,
    config = function()
      require("configs.treesitter_parsers")
    end,
  },
  -- toggleterm
  {
    dir = plugin_folder .. "toggleterm.nvim",
    -- opts = require("configs.toggleterm"),
    opts = function()
      return require("configs.toggleterm")
    end,
  },
  -- Bufferline
  {
    dir = plugin_folder .. "bufferline.nvim",
    dependencies = {
      dir = plugin_folder .. "nvim-web-devicons",
    },
    config = function()
      require "configs.bufferline"
    end,
  },
  -- Auto Completion
 {
    dir = plugin_folder .."nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        dir = plugin_folder .. "LuaSnip",
        dependencies = {dir = plugin_folder .. "friendly-snippets"},
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("configs.luasnip")
        end,
      },
      { dir = plugin_folder .. "cmp_luasnip" },
      { dir = plugin_folder .. "cmp-nvim-lua" },
      { dir = plugin_folder .. "cmp-nvim-lsp" },
      { dir = plugin_folder .. "cmp-buffer" },
      { dir = plugin_folder .. "cmp-path" },
    },
    opts = function()
      return require "configs.cmp"
    end,
  }
}
return plugins
