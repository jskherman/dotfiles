local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- typst LSP setup
lspconfig.typst_lsp.setup {
  settings = {
    -- serverPath = "", -- Normally, there is no need to uncomment it.
		export_pdf = "onSave" -- Choose onType, onSave or never.
	}
}

-- 
-- lspconfig.pyright.setup { blabla}
