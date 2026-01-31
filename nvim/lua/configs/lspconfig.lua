local util = require("lspconfig.util")

local function make_on_attach()
	return function(client, bufnr)
		local function opts(desc)
			return { buffer = bufnr, desc = "LSP " .. desc }
		end

		-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts "Rename variable")
		vim.keymap.set("n", "<leader>cc", vim.lsp.buf.code_action, opts "Code action")
	end
end

-- Disable semantic tokens
local function make_on_init()
	return function(client)
		if client.supports_method "textDocument/semanticTokens" then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end
end

-- Capabilities via cmp_nvim_lsp
local capabilities =
		require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation", "detail", "additionalTextEdits",
		},
	},
}

-- Helper to define + enable a server
local function define_server(name, config)
	vim.lsp.config(name, config)
	vim.lsp.enable(name)
end

local lua_config = {
	on_attach    = make_on_attach(),
	on_init      = make_on_init(),
	capabilities = capabilities,
	cmd          = {
		vim.fn.expand("~/.local/share/lua-language-server/bin/lua-language-server")
	},
	filetypes    = { "lua" },
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	settings     = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
					vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
}

-- based_pyright_config =
local basedpyright_config = {
	on_attach    = make_on_attach(),
	on_init      = make_on_init(),
	capabilities = capabilities,
	cmd          = { "basedpyright-langserver", "--stdio" },
	filetypes    = { "python" },
	root_markers = { { "pyproject.toml", "setup.py", "seutp.cfg" }, ".git" },
	settings     = {
		pyright = { disableOrganizeImports = true },
		basedpyright = {
			analysis = {
				autoImportCompletions = true,
				typeCheckingMode = "standard",
			},
		},
	},
}


local ruff_config = {
	on_attach    = make_on_attach(),
	on_init      = make_on_init(),
	capabilities = capabilities,
	root_markers = { { "pyproject.toml", "setup.py", "setup.cfg" }, ".git" },
	filetypes    = { "python" },
	-- Default starter command (required to initialize, though immediately overwritten)
	cmd          = { "ruff", "server" }
}

local ty_config = {
	on_attach    = make_on_attach(),
	on_init      = make_on_init(),
	capabilities = capabilities,
	root_markers = { { "pyproject.toml", "setup.py", "setup.cfg" }, ".git" },
	filetypes    = { "python" },
	-- Default starter command (required to initialize, though immediately overwritten)
	cmd          = { "ruff", "server" },
	init_options = {
		settings = {
			showSyntaxErrors = false,
			lint = {
				enable = false,
			},
		}
	}
}

-- Required: Enable the language server
define_server("lua_ls", lua_config)
-- define_server("basedpyright", basedpyright_config)
define_server("ruff", ruff_config)
-- Currently issue with ty and toggleterm
define_server("ty", ty_config)

vim.diagnostic.config({
	virtual_text = true, -- show the message after the line
	signs = true,       -- keep the gutter sign
	underline = true,
})

