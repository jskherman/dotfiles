---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-S-\\>"] = {"<cmd> vsplit <CR>", "Split window vert" },
  },

}

-- more keybinds!
M.lazy = {
  n = {
    ["<leader>l"] = {"<cmd> Lazy <CR>", "Lazy Modal"},
  },
}

M.nvterm = {
  plugin = true,
  n = {
    ["<C-/>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  t = {
    ["<C-/>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },
}


return M
