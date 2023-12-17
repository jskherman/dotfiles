-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

-- Show filetype of current buffer
map("n", "<leader>f?", '<cmd>echo "The file\'s type is: " .. &filetype<CR>', { desc = "Show filetype" })

map("n", "<A-Up>", ":m -2<CR>", { desc = "Move line up" }) -- move line up(n)
map("n", "<A-Down>", ":m +1<CR>", { desc = "Move line down" }) -- move line down(n)
map("v", "<A-Up>", ":m -2<CR>", { desc = "Move line up" }) -- move line up (v)
map("v", "<A-Down>", ":m +1<CR>", { desc = "Move line down" }) -- move line down (v)

-- Ctrl + ; to automatically fix the nearest spelling error.
map("i", "<C-;>", "<C-g>u<Esc>[s1z=`]a<C-g>u") -- <zg> to add custom words to spellfile

-- Map hjkl to arrow keys
map("n", "h", "<Left>", { noremap = true, silent = true })
map("n", "j", "<Down>", { noremap = true, silent = true })
map("n", "k", "<Up>", { noremap = true, silent = true })
map("n", "l", "<Right>", { noremap = true, silent = true })

-- ----------------------------------------------------------------------------

-- ==== Plugins ====

-- alpha.nvim Dashboard keymap
map("n", "<leader>;", "<cmd>Alpha<CR>", { desc = "Dashboard" })

-- VimTex keybindings
map("n", "<localleader>lw", "<cmd>VimtexCountWords<CR>", { desc = "Count words in doc" })
map("n", "<localleader>l;", "<Cmd>update<CR><Cmd>VimtexCompileSS<CR>", { desc = "SS Compile" })

-- LuaSnip / Ultisnips keybindings
map("n", "<leader>xs", "<cmd>lua require('luasnip').snippets={}; require('luasnip.loaders.from_lua').load({ paths = { './LuaSnip' } })<CR>", { desc = "Reload LuaSnip" })
-- map("n", "<leader>xs", "<cmd>call UltiSnips#RefreshSnippets()<CR>", { desc = "Reload Ultisnips" })

