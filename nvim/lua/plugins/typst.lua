return {
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false
  },
  {
    "chomosuke/typst-preview.nvim",
    -- enabled = false,
    lazy = false, -- or ft = 'typst'
    version = "0.1.*",
    build = function()
      require("typst-preview").update()
    end,
  },
}
