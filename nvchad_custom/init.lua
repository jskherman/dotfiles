local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- LuaSnips: lua format
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/custom/lua_snippets"

-- Set default shell for terminal to powershell
vim.o.shell = "pwsh"
vim.o.shellcmdflag = "-Command"
vim.o.shellquote = "\""
vim.o.shellxquote = ""

