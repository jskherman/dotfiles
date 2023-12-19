--  bootstrap lazy package manager
--  <https://github.com/folke/lazy.nvim>
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
	defaults = {
		version = false,
	},
	dev = {
		path = "~/projects",
		-- patterns = { "jmbuhr", "quarto-dev" },
		fallback = true,
	},
	install = { colorscheme = { "catppuccin", "habamax" } },
	-- checker = { enabled = true },
	rtp = {
		disabled_plugins = {
			"gzip",
			"matchit",
			"matchparen",
			"netrwPlugin",
			"tarPlugin",
			"tohtml",
			"tutor",
			"zipPlugin",
		},
	},
	checker = {
		-- automatically check for plugin updates
		enabled = false,
		notify = true, -- get a notification when new updates are found
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = false, -- get a notification when changes are found
	},
})
