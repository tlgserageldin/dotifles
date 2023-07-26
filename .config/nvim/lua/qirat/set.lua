-- set leader
vim.g.mapleader = " "

-- fat cursor
vim.opt.guicursor = ""

-- numbers
vim.opt.nu = true
vim.opt.rnu = true

-- indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- no line wrap
vim.opt.wrap = false

-- mouse
vim.opt.mouse = ""

-- undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- fast update time
vim.opt.updatetime = 50

-- show where 80 char is
vim.opt.colorcolumn = "80"

-- keep 8 lines above or below cursor
vim.opt.scrolloff = 8
