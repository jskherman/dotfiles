return {
  {
    "folke/tokyonight.nvim",
    opts = {
      -- transparent = true,
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
    },
  },

  -- {
  --   'projekt0n/caret.nvim',
  --   lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('caret').setup({
  --       -- ...
  --     })

  --     vim.cmd('colorscheme caret')
  --   end,
  -- },

  -- {
  --   "rebelot/kanagawa.nvim",
  --   enabled = false,
  --   lazy = true,
  --   name = "kanagawa",
  --   opts = {
  --     compile = false,  -- enable compiling the colorscheme
  --     undercurl = true, -- enable undercurls
  --     commentStyle = { italic = true },
  --     functionStyle = {},
  --     keywordStyle = { italic = true },
  --     statementStyle = { bold = true },
  --     typeStyle = {},
  --     transparent = false,   -- do not set background color
  --     dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
  --     terminalColors = true, -- define vim.g.terminal_color_{0,17}
  --     colors = {             -- add/modify theme and palette colors
  --       palette = {},
  --       theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  --     },
  --     overrides = function(colors) -- add/modify highlights
  --       return {}
  --     end,
  --     theme = "wave",  -- Load "wave" theme when 'background' option is not set
  --     background = {   -- map the value of 'background' option to a theme
  --       dark = "wave", -- try "dragon" !
  --       light = "lotus"
  --     },
  --   }
  -- },

  -- {
  --   "catppuccin/nvim",
  --   lazy = true,
  --   name = "catppuccin",
  --   enabled = false,
  --   opts = {
  --     integrations = {
  --       alpha = true,
  --       cmp = true,
  --       flash = true,
  --       gitsigns = true,
  --       illuminate = true,
  --       indent_blankline = { enabled = true },
  --       lsp_trouble = true,
  --       mason = true,
  --       mini = true,
  --       native_lsp = {
  --         enabled = true,
  --         underlines = {
  --           errors = { "undercurl" },
  --           hints = { "undercurl" },
  --           warnings = { "undercurl" },
  --           information = { "undercurl" },
  --         },
  --       },
  --       navic = { enabled = true, custom_bg = "lualine" },
  --       neotest = true,
  --       noice = true,
  --       notify = true,
  --       neotree = true,
  --       semantic_tokens = true,
  --       telescope = true,
  --       treesitter = true,
  --       which_key = true,
  --     },
  --   },
  -- },

  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "kanagawa",
  --   },
  -- },
}
