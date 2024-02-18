return {
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

  -- Neo-tree options
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          window = {
            mappings = {
              ["o"] = "system_open",
            },
          },
          commands = {
            system_open = function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              path = vim.fn.shellescape(path, 1)
              if vim.tbl_contains({ "jpg", "jpeg", "jfif", "png", "gif", "pdf" }, node.ext) then
                -- Windows: open in default system application
                if vim.fn.has("win64") ~= 0 then
                  vim.cmd("!start " .. path)
                -- Linux: open file in default application
                elseif vim.fn.has("linux") ~= 0 then
                  vim.cmd("!xdg-open " .. path)
                -- macOS: open file in default application in the background.
                elseif vim.fn.has("mac") ~= 0 then
                  vim.cmd("!open " .. path)
                end
              else
                vim.cmd.edit(path)
              end
            end,
          },
        },
      })
    end,
  },
}
