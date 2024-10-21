-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "texlab" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
local custom_on_attach = function(client, buffer)
  nvlsp.on_attach(client, buffer)
  vim.api.nvim_buf_set_option(buffer, "tabstop", 4)
  vim.api.nvim_buf_set_option(buffer, "shiftwidth", 4)
  -- vim.api.nvim_buf_set_option(buffer, "expandtab", true)

  -- vim.keymap.set("n", "gd", function()
  --   require("harpoon.mark").add_file()
  --   vim.lsp.buf.definition()
  -- end)

  vim.keymap.set({ "n", "i" }, "<F2>", function()
    vim.lsp.buf.rename()
  end)
  vim.keymap.set({ "n", "i" }, "<M-#>", function()
    vim.lsp.buf.hover()
  end)
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = custom_on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
-- Set right version of C++
lspconfig.clangd.setup {
  -- on_attach = function(client, buffnr)
  --   nvlsp.on_attach(client, buffnr)
  --   vim.
  -- end,
  on_attach = custom_on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "clangd", "--fallback-style=webkit" },
  init_options = {
    fallbackFlags = { "--std=c++23" },
  },
}

-- Disable pyright type checking
lspconfig.pyright.setup {
  on_attach = custom_on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
}
-- Use ruff exclusively as a formatter
lspconfig.ruff.setup {
  on_attach = custom_on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    settings = {
      showSyntaxErrors = false,
      lint = {
        enable = false,
      },
    },
  },
}
