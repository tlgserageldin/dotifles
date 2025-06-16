-- init.lua ───────────────────────────────────────────────────────────────────
-- speed up startup by letting ~/.config/nvim/lua be in package.path
vim.loader.enable()

-- core settings & keymaps
require("qirat.set")
require("qirat.remap")

-- lazy.nvim bootstrap
require("lazy").setup("qirat.plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "tokyonight", "gruvbox" } },
  performance = { rtp = { disabled_plugins = { "gzip" } } },
})
