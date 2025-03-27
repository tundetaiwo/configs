local cmp = require "cmp"

local options = {
	completion = { completeopt = "menu,menuone" },
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "cmdline" },
	},
}

-- Apply the main setup first
cmp.setup(options)

-- Command-line (search "/" and "?") completion setup
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline({
		["<Tab>"]   = { c = function() end },  -- Disable Tab in cmdline mode
		["<S-Tab>"] = { c = function() end },  -- Disable Shift-Tab in cmdline mode
		["<C-j>"]   = {
			c = function(fallback)               -- Ctrl+j: next item
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end
		},
		["<C-k>"]   = {
			c = function(fallback)               -- Ctrl+k: previous item
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end
		},
	}),
	sources = {
		{ name = "buffer" }
	}
})

-- Command-line (":") completion setup
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline({
		["<Tab>"]   = { c = function() end }, -- Disable Tab in cmdline mode
		["<S-Tab>"] = { c = function() end }, -- Disable Shift-Tab in cmdline mode
		["<C-j>"]   = {
			c = function(fallback)            -- Ctrl+j: next item
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end
		},
		["<C-k>"]   = {
			c = function(fallback) -- Ctrl+k: previous item
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end
		},
	}),
	sources = cmp.config.sources({
		{ name = "path" }
	}, {
		{ name = "cmdline" }
	})
})
