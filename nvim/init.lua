-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- mason.nvim config
require("mason").setup()
require("mason-lspconfig").setup()

-- nvim-lspconfig
require("lspconfig").typst_lsp.setup{
    cmd = { "typst-lsp" },
    filetypes = { "typst" },
    settings = {
		exportPdf = "onType", -- Choose onType, onSave or never.
        -- serverPath = "" -- Normally, there is no need to uncomment it.
	}
}

