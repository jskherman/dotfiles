local function set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = { "*" },
	command = "checktime",
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = { "*" },
	callback = function(_)
		vim.cmd.setlocal("nonumber")
		set_terminal_keymaps()
	end,
})
