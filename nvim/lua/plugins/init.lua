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
		config = function()
			require("configs.nvimtree")
		end,
		dependencies = { dir = plugin_folder .. "nvim-web-devicons" },
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
	{
		dir = plugin_folder .. "nvim-treesitter-context",
		config =
				function()
					require("configs.treesitter-context")
				end
	},
	-- Debugger
	{
		dir = plugin_folder .. "nvim-nio",
	},
	{
		dir = plugin_folder .. "nvim-dap-ui",
		dependencies = { dir = plugin_folder .. "nvim-dap" },
		config = function()
			require("configs.dap")
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
	{
		dir = plugin_folder .. "nvim-dap-virtual-text",
		config = function() require("configs.dap-virtual-text") end
	},
	-- toggleterm
	{
		dir = plugin_folder .. "toggleterm.nvim",
		config = function()
			require("configs.toggleterm")
		end,
	},
	-- Gitsigns
	{
		dir = plugin_folder .. "gitsigns.nvim",
		config = function()
			require("configs.gitsigns")
		end
	},
	-- Diffview
	{
		dir = plugin_folder .. "diffview.nvim",
		config = function()
			require("configs.diffview")
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
	{
		dir = plugin_folder .. "nvim-web-devicons",
	},
	{
		dir = plugin_folder .. "tabby.nvim",
		-- dependencies = 'nvim-tree/nvim-web-devicons',
		dependencies = { dir = plugin_folder .. "nvim-web-devicons" },
		config = function()
			require("configs.tabby")
		end,
	},
	{
		dir = plugin_folder .. "lualine.nvim",
		config = function()
			require("configs.lualine")
		end
	},
	{
		"rmagatti/auto-session",
		dir = plugin_folder .. "auto-session",
		lazy = false,

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			bypass_save_filetypes = { "alpha" }, -- or whatever dashboard you use
		},
		config = function()
			require("configs.auto-session")
		end,
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
	-- Harpoon
	{
		dir = plugin_folder .. "harpoon",
		config = function()
			require("configs.harpoon")
		end
	},
	{
		dir = plugin_folder .. "csvview.nvim",
		config = function()
			require("configs.csvview")
		end
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
	{
		dir = plugin_folder .. "gruvbox.nvim",
		priority = 1000,
	},
	-- {
	-- 	dir = plugin_folder .. "codecompanion.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	config = function()
	-- 		require("configs.code-companion")
	-- 	end,
	-- },
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
	-- {
	-- 	dir = plugin_folder .. "image.nvim",
	-- 	opts = {
	-- 		backend = "kitty", -- Change to "ueberzug" if on Linux/X11 without Kitty/WezTerm
	-- 		integrations = {
	-- 			markdown = {
	-- 				enabled = true,
	-- 				clear_in_insert_mode = false,
	-- 				download_remote_matplotlib-backend-sixelimages = true,
	-- 				only_render_image_at_cursor = false,
	-- 				filetypes = { "markdown", "vimwiki" },
	-- 			},
	-- 			neorg = { enabled = true },
	-- 		},
	-- 		max_width = 100,
	-- 		max_height = 12,
	-- 		max_height_window_percentage = math.huge,
	-- 		max_width_window_percentage = math.huge,
	-- 		window_overlap_clear_enabled = true,
	-- 	},
	-- }

	-- -- 2. Molten (Jupyter Client)
	-- {
	-- 	"benlubas/molten-nvim",
	-- 	version = "^1.0.0", -- Pin version for stability
	-- 	dependencies = { "3rd/image.nvim" },
	-- 	build = ":UpdateRemotePlugins",
	-- 	init = function()
	-- 		-- These variables must be set BEFORE the plugin loads
	-- 		vim.g.molten_image_provider = "image.nvim"
	-- 		vim.g.molten_output_win_max_height = 20
	-- 		vim.g.molten_auto_open_output = false -- Set to true if you want auto-popups
	-- 		vim.g.molten_wrap_output = true
	-- 		vim.g.molten_virt_text_output = true
	-- 		vim.g.molten_virt_lines_off_by_1 = true
	-- 	end,
	-- 	keys = {
	-- 		{ "<leader>mi", ":MoltenInit<cr>",             desc = "[M]olten [I]nit" },
	-- 		{ "<leader>me", ":MoltenEvaluateOperator<cr>", desc = "Run Operator Selection" },
	-- 		{ "<leader>rl", ":MoltenEvaluateLine<cr>",     desc = "Run Line" },
	-- 		{ "<leader>rr", ":MoltenReevaluateCell<cr>",   desc = "Re-run Cell" },
	-- 		{ "<leader>rd", ":MoltenDelete<cr>",           desc = "Delete Cell Output" },
	-- 	},
	-- },
}
return plugins
