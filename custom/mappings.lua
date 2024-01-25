local M = {}

M.general = {
  i = {
    ["<C-n>"] = { "<cmd> enew <CR>", "New buffer" },
  },
  n = {
    ["<C-n>"] = { "<cmd> enew <CR>", "New buffer" },
  }
}

M.mappings = {
  i = {
    ["jj"] = {"<ESC>", "escape insert mode", opts = {nowait = true}},
  }
}

M.comment = {
  plugin = true,
  -- toggle comment in both modes
  n = {
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },
  i = {
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },
  v = {
    ["<C-_>"] = {
      "<ESk><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    -- ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  },
}
-- Set tab shortcuts
M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<A-k>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<A-j>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<C-w>"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
  },
}


M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-b>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"}
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}
return M
