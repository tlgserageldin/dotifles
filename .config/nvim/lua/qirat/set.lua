-- keep the signcolumn on by defaul
vim.wo.signcolumn = 'yes'

-- foldmethod
vim.opt.foldmethod = 'marker'

-- highlight line the cursor is on
vim.opt.cursorline = false
vim.opt.cursorlineopt = "line"

-- fat cursor
vim.opt.guicursor = ""

-- numbers
vim.opt.nu = true
vim.opt.rnu = true

-- indent
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- no line wrap
vim.opt.wrap = false

-- mouse
vim.opt.mouse = ""

-- undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- disable swap files
vim.opt.swapfile = false

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- fast update time
vim.opt.updatetime = 50

-- keep 8 lines above or below cursor
vim.opt.scrolloff = 8

-- netrw
vim.g.netrw_banner = 0              -- hide banner
vim.g.netrw_liststyle = 3           -- tree view
vim.g.netrw_browse_split = 2        -- open files in vertical split
vim.opt.splitright = true           -- make splits open to the right
vim.g.netrw_winsize = 25            -- set width of explorer
