local plugin_folder = vim.fn.stdpath("data") .. "/lazy/"
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
		dir = plugin_folder .. "telescope-fzf-native.nvim",
		build = 'make',
	},
	{
		dir = plugin_folder .. "telescope.nvim",
		-- lazy = true,
		dependencies = {
			{ dir = plugin_folder .. "telescope-fzf-native.nvim" },
			{ dir = plugin_folder .. "plenary.nvim" },
		},
		config = function()
			require("configs.telescope")
		end,
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
	-- AutoFormatting
	{
		dir = plugin_folder .. "conform.nvim",
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
		opts = function()
			return require "configs.treesitter"
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			require("configs.treesitter_parsers") -- This isn't quite working
		end,
	},
	-- Debugger
	{
		dir = plugin_folder .. "nvim-nio",
	},
	{
		dir = plugin_folder .. "nvim-dap-ui",
		dependencies = { dir = plugin_folder .. "nvim-dap" },
		config = function()
			local dap = require "dap"
			local dapui = require "dapui"
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.after.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.after.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		dir = plugin_folder .. "nvim-dap",
		config = function(_, opts) end,
	},
	{
		dir = plugin_folder .. "nvim-dap-python",
		ft = "python",
		dependencies = {
			{
				dir = plugin_folder .. "nvim-dap"
			},
			{
				dir = plugin_folder .. "nvim-dap-ui",
			},
		},
		config = function(_, opts)
			local path = "~/.local/venvs/debugpy_venv/bin/python"
			require("dap-python").setup(path)
			require("dap-python").test_runner = "pytest"
		end,
	},
	-- toggleterm
	{
		dir = plugin_folder .. "toggleterm.nvim",
		config = function()
			require("configs.toggleterm")
		end,
	},
	-- Diffview
	{
		dir = plugin_folder .. "diffview.nvim",
	},
	-- Lualine (statusline)
	{
		dir = plugin_folder .. 'lualine.nvim',
		dependencies = { dir = plugin_folder .. 'nvim-web-devicons' },
		config = function()
			require("configs/lualine")
		end
	},
	-- Auto Completion
	{
		dir = plugin_folder .. "nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				-- snippet plugin
				dir = plugin_folder .. "LuaSnip",
				dependencies = { dir = plugin_folder .. "friendly-snippets" },
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
					require("configs.luasnip")
				end,
			},
			{
				dir = plugin_folder .. "cmp_luasnip",
			},
			{
				dir = plugin_folder .. "cmp-nvim-lua"
			},
			{
				dir = plugin_folder .. "cmp-nvim-lsp"
			},
			{
				dir = plugin_folder .. "cmp-buffer"
			},
			{
				dir = plugin_folder .. "cmp-path"
			},
			{
				dir = plugin_folder .. "cmp-cmdline"
			},
		},
		opts = function()
			return require "configs.cmp"
		end,
	},
	--  Command Line Completion
	-- cmp.setup.cmdline(':', {
	-- 	mapping = cmp.mapping.preset.cmdline(),
	-- 	sources = cmp.config.sources({
	-- 		{ name = 'path' }
	-- 	}, {
	-- 		{
	-- 			name = 'cmdline',
	-- 			option = {
	-- 				ignore_cmds = { 'Man', '!' }
	-- 			}
	-- 		}
	-- 	})
	-- })
	-- Session Manager
			{
				dir = plugin_folder .. "persistence.nvim",
				event = "BufReadPre", -- this will only start session saving when an actual file was opened
				opts = {
					-- add any custom options here
				}
			},
	{
		dir = plugin_folder .. "tabout.nvim",
		lazy = false,
		config = function()
			require("configs.tabout")
		end,
		dependencies = { -- These are optional
			{ dir = plugin_folder .. "nvim-treesitter" },
			{ dir = plugin_folder .. "LuaSnip" },
			{ dir = plugin_folder .. "nvim-cmp" },
		},
		-- opt = true,  -- Set this to true if the plugin is optional
		event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
		priority = 1000,
	},
	-- Vim slime (Sends to REPL)
	{
		dir = plugin_folder .. "vim-slime",
		init = function()
			vim.g.slime_target = "neovim"
			vim.g.slime_python_ipython = 1
			vim.g.slime_cell_delimiter = "#\\s\\=%%"
			vim.slime_bracketed_paste = 1
		end,
		config = function()
			require("configs.slime")
		end
	},
	-- Themes
	{
		dir = plugin_folder .. "catppuccin-nvim",
		priority = 1000,
	},
	-- Custom Startup
	{
		"goolord/alpha-nvim",
		dependencies = { dir = plugin_folder .. "nvim-web-devicons" },
		config = function()
			local startify = require("alpha.themes.startify")
			-- available: devicons, mini, default is mini
			-- if provider not loaded and enabled is true, it will try to use another provider
			startify.file_icons.provider = "devicons"
			require("alpha").setup(
				startify.config
			)
			require("configs.alpha")
		end,
	},

}
return plugins
