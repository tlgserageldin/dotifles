-- lua/qirat/plugins.lua
return {

  -- LSP + Mason
  { "williamboman/mason.nvim", opts = {} }, -- load immediately
  { "williamboman/mason-lspconfig.nvim", 
    dependencies = "mason.nvim",
    opts = {} },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      require("qirat.lsp")
    end,
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
    },
    config = function()
      require("qirat.cmp")
    end,
  },
  -- lazy itself
  { "folke/lazy.nvim",        version = "*" },

  -- git
  { "tpope/vim-fugitive",     cmd = { "G", "Git" } },

  -- telescope and fzf
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond  = function() return vim.fn.executable("make") == 1 end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          -- point Telescope at the fzf sorter:
          file_sorter      = require("telescope.sorters").get_fzf_sorter,
          generic_sorter   = require("telescope.sorters").get_fzf_sorter,
          -- any other defaults…
        },
        extensions = {
          fzf = {
            override_generic_sorter = true,  -- use for all sorts
            override_file_sorter    = true,  -- use for file sorts
            case_mode               = "smart_case",
          },
        },
      })
      -- load the extension:
      telescope.load_extension("fzf")
      require("qirat.telescope")
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build        = ":TSUpdate",
    event        = { "BufReadPre", "BufNewFile" },
    config = function() require("qirat.treesitter") end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 5,
        trim_scope = 'outer',
      })
    end,
  },


  -- snippets
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function() 
               require("luasnip").config.set_config{} 
             end,
  },

  -- undotree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },

  -- any other plugins you had in your packer.lua...
}
