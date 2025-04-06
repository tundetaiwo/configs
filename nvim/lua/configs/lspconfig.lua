local lspconfig = require("lspconfig")

local custom_on_attach = function(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts "Rename variable")

	vim.keymap.set("n", "<leader>cc", vim.lsp.buf.code_action, opts "Code action")
end

-- disable semanticTokens
local custom_on_init = function(client, _)
	if client.supports_method "textDocument/semanticTokens" then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

-- local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
local custom_capabilities = require("cmp_nvim_lsp").default_capabilities()
custom_capabilities.textDocument.completion.completionItem = {
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
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

-- LUA --

lspconfig.lua_ls.setup {
	on_attach = custom_on_attach,
	on_init = custom_on_init,
	capabilities = custom_capabilities,
	cmd = { vim.fn.stdpath("data") .. "/../lua-language-server/bin/lua-language-server" },
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.fn.expand "$VIMRUNTIME/lua",
					vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
					vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
					"${3rd}/luv/library",
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
}

-- PYTHON --

-- BasedPyright
lspconfig.basedpyright.setup {
	on_attach = custom_on_attach,
	on_init = custom_on_init,
	capabilities = custom_capabilities,
	settings = {
		pyright = {
			disableOrganizeImports = true
		},
		basedpyright = {
			analysis = {
				autoImportCompletions = true,
				typeCheckingMode = "standard",
			},
		}
	}
}

-- Disable pyright type checking
-- lspconfig.pyright.setup {
-- 	on_attach = custom_on_attach,
-- 	on_init = custom_on_init,
-- 	capabilities = custom_capabilities,
-- 	settings = {
-- 		python = {
-- 			analysis = {
-- 				typeCheckingMode = "off",
-- 			},
-- 		},
-- 	},
-- }

-- Use ruff exclusively as a formatter
lspconfig.ruff.setup {
	on_attach = custom_on_attach,
	on_init = custom_on_init,
	capabilities = custom_capabilities,
	init_options = {
		settings = {
			showSyntaxErrors = false,
			lint = {
				enable = false,
			},
		},
	},
}
