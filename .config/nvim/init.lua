-- init.lua ───────────────────────────────────────────────────────────────────
-- speed up startup by letting ~/.config/nvim/lua be in package.path
vim.loader.enable()

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- core settings & keymaps
require("qirat.remap")
require("qirat.set")

-- lazy.nvim bootstrap
require("lazy").setup("qirat.plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "tokyonight", "gruvbox" } },
  performance = { rtp = { disabled_plugins = { "gzip" } } },
})
