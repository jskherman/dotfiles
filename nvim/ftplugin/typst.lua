-- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  --  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  vim.keymap.set(mode, lhs, rhs, options)
end

-- map("n", "<F5>", "<cmd>TypstWatch<CR>") -- Run TypstWatch

-- chomosuke/typst-preview.nvim
map("n", "<F5>", "<cmd>TypstPreview<CR>") -- Run TypstWatch
map("n", "<c-F5>", "<cmd>TypstPreviewStop<CR>") -- Run TypstWatch
