return {
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
  },
  {
    "chomosuke/typst-preview.nvim",
    -- enabled = false,
    ft = "typst", -- lazy = false,
    -- version = "0.1.*",
    build = function()
      require("typst-preview").update()
    end,
    config = function()
      require("typst-preview").setup({
        open_cmd = "chrome %s -P typst-preview",
      })
    end,
  },
}
