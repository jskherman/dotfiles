-- Set path to typst executable
vim.g.typst_cmd = "C:\\apps\\bin\\typst.exe"

-- -- Define a Lua function for watching a file with Typst
-- function TypstWatch()
--     vim.cmd('vsp')
--     vim.cmd('vertical resize 20')
--     vim.fn.termopen('typst watch ' .. vim.fn.expand('%:p'))
--     vim.cmd('wincmd h')
-- end

-- -- Create key mappings
-- vim.api.nvim_set_keymap('n', '<leader>fc', [[:lua TypstWatch()<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fr', [[:silent !sumatrapdf --fork %:p:r.pdf &<CR>]], { noremap = true, silent = true })

return {
    'kaarmu/typst.vim',
    ft = 'typst',
    lazy=false,
}