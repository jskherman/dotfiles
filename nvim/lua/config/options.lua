-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en_us", "cjk" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Enable/disable line wrap, default: false/disabled

-- Set local leader to comma, default is \ backslash
vim.g.maplocalleader = ","

------------------------------------------------------------------------------
-- Set default shell for terminal to powershell
------------------------------------------------------------------------------

vim.o.shell = "pwsh"
vim.o.shellcmdflag = "-Command"
vim.o.shellquote = ""
vim.o.shellxquote = ""

------------------------------------------------------------------------------
-- Language specific options
------------------------------------------------------------------------------

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Set path to python3 executable for neovim
-- vim.g.python3_host_prog = "C:\\Users\\Je Sian Keith Herman\\.pyenv\\pyenv-win\\versions\\3.10.11\\python.exe"

------------------------------------------------------------------------------
-- UltiSnips config
------------------------------------------------------------------------------

-- vim.g.UltiSnipsExpandTrigger = "<Tab>"
-- -- shortcut to go to next position
-- vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
-- -- shortcut to go to previous position
-- vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"
-- vim.g.UltiSnipsSnippetDirectories = { "C:\\Users\\Je Sian Keith Herman\\AppData\\Local\\nvim\\UltiSnips" }

------------------------------------------------------------------------------
-- VimTex config options
------------------------------------------------------------------------------

-- latexmk compiler options
-- vim.g.vimtex_compiler_latexmk = 'pdflatex' -- or 'pdflatex', 'luatex', 'context (luatex)'

vim.g.vimtex_quickfix_ignore_filters = {
  "Underfull \\hbox",
  "Overfull \\hbox",
  "LaTeX Warning: .+ float specifier changed to",
  "LaTeX hooks Warning",
  'Package siunitx Warning: Detected the "physics" package:',
  "Package hyperref Warning: Token not allowed in a PDF string",
} -- Ignore these warnings, or you can uncomment the setting below to open QuickFix for errors only
-- vim.g.vimtex_quickfix_open_on_warning = 0 -- Don't open QuickFix for warning messages if no errors are present

-- Set PDF viewer to SumatraPDF
vim.g.vimtex_view_general_viewer = "SumatraPDF"
vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"

-- Conceal syntax options, see :h g:vimtex_syntax_conceal
vim.g.vimtex_syntax_conceal = {
  accents = 1,
  ligatures = 1,
  cites = 1,
  fancy = 1,
  spacing = 1,
  greek = 0,
  math_bounds = 0,
  math_delimiters = 0,
  math_fracs = 0,
  math_super_sub = 0,
  math_symbols = 0,
  sections = 0,
  styles = 1,
}

vim.g.beancount_root = "main.beancount"

-- Neovide settings
vim.g.neovide_remember_window_size = true
vim.o.guifont = "Cascadia Code:h13"
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_vfx_particle_lifetime = 1.4
vim.g.neovide_cursor_vfx_particle_density = 8.0
