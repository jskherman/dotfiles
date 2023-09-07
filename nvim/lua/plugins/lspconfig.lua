return {
  {
    "williamboman/mason.nvim",
  },
  
  {
    "williamboman/mason-lspconfig.nvim",
    
    opts = {
      servers = {
        typst_lsp = {},
      },
      setup = {
        cmd = { "typst-lsp" },
        filetypes = { "typst" },
        settings = {
          exportPdf = "onType", -- Choose onType, onSave or never.
            -- serverPath = "" -- Normally, there is no need to uncomment it.
        },
      },
    },
  },

}