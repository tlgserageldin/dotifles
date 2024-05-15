-- space is leader, dont do anything 
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, desc = 'Make space do nothing' })

-- open netrw
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = '[P]roject [V]iew'})

-- keep cursor in same place when joining lines
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join line in place' })

-- keep cursor in place when scrolling pages
vim.keymap.set('n', '<C-u>', '<C-u>zz',{ desc = 'Page up in place' } )
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page down in place' })

-- keep cursor in the middle when searching
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'keep cursor in the middle when searching' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'keep cursor in the middle when searching' })

-- keep contents of yank buffer after paste
vim.keymap.set('x', '<leader>p', '\"_dP', { desc = 'keep contents of yank buffer after paste' })

-- yank to clipboard
vim.keymap.set('n', '<leader>y', '\"+y', { desc = 'yank to clipboard' })
vim.keymap.set('n', '<leader>Y', '\"+Y', { desc = 'yank to clipboard' })
vim.keymap.set('v', '<leader>y', '\"+y', { desc = 'yank to clipboard' })

-- delete to void instead of copying the deletion
vim.keymap.set('n', '<leader>d', '\"_d', { desc = 'delete to void' })
vim.keymap.set('v', '<leader>d', '\"_d', { desc = 'delete to void' })

-- split and v-split with - and \\
vim.keymap.set('n', '<C-w>-', vim.cmd.split)
vim.keymap.set('n', '<C-w>\\', vim.cmd.vsplit)

