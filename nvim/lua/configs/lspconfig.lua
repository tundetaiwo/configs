local lspconfig = require("lspconfig")

local custom_on_attach = function(_, bufnr)

  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end
  -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  -- vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  -- vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  -- vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  -- vim.keymap.set("n", "<leader>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, opts "List workspace folders")
  --
  -- vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  -- vim.keymap.set("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts "Show references")
end

-- disable semanticTokens
local custom_on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
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

lspconfig.lua_ls.setup {
  on_attach = custom_on_attach,
  on_init = custom_on_init,
  capabilities = custom_capabilities,
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

lspconfig.ruff.setup {
  on_attach = custom_on_attach,
  on_init = custom_on_init,
  capabilities = custom_capabilities,
  init_options = {
    settings = {
      configurationPreference = "filesystemFirst",
      organizeImports = true,
      showSyntaxErrors = true,
      lint = {
        enable = true,
        ignore = {},
      }
    }
  }
}
