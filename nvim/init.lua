-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Set default shell for terminal to powershell
vim.o.shell = "pwsh"
vim.o.shellcmdflag = "-Command"
vim.o.shellquote = "\""
vim.o.shellxquote = ""