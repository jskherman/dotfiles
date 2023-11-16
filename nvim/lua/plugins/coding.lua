return {
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      -- add your options that should be passed to the setup() function here
      position = "right",
    },
  },
  -- Commenting
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  -- Soft and Hard wrap settings for text
  -- <yow> for toggling wrap modes
  {
    "andrewferrier/wrapping.nvim",
    config = function()
      require("wrapping").setup({
        auto_set_mode_filetype_allowlist = {
          "asciidoc",
          "gitcommit",
          "latex",
          "mail",
          "markdown",
          "rst",
          "tex",
          "text",
          "typst",
        },
        softener = {
          markdown = 1.5,
          typst = true,
        },
      })
    end,
  },
}
