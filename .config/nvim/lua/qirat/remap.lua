-- open netrw
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- keep cursor in same place when joining lines
vim.keymap.set('n', 'J', 'mzJ`z')

-- keep cursor in place when scrolling pages
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- keep cursor in the middle when searching
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- keep contents of yank buffer after paste
vim.keymap.set('x', '<leader>p', '\"_dP')

-- yank to clipboard
vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>Y', '\"+Y')
vim.keymap.set('v', '<leader>y', '\"+y')

-- delete to void instead of copying the deletion
vim.keymap.set('n', '<leader>d', '\"_d')
vim.keymap.set('v', '<leader>d', '\"_d')

-- switch panes with Ctrl-[MOVEMENT]
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-l>', '<C-W>l')
