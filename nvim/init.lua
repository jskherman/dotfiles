-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Set default shell for terminal to powershell
vim.o.shell = "pwsh"
vim.o.shellcmdflag = "-Command"
vim.o.shellquote = "\""
vim.o.shellxquote = ""

-- Set path to python3 executable for neovim
vim.g.python3_host_prog = "C:\\Users\\Je Sian Keith Herman\\.pyenv\\pyenv-win\\versions\\3.10.11\\python.exe"