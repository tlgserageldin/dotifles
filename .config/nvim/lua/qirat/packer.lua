-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use ({'wbthomason/packer.nvim'})

    -- git
    use ({'tpope/vim-fugitive'})

    -- auto tabstop and spaces
    use ({'tpope/vim-sleuth'})

    -- fuzzyfind
    use ({
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
        },
    })

    -- colors
    use ({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function ()
            vim.cmd('colorscheme rose-pine')
        end
    })

    -- treesitter
    use ({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
            {'nvim-treesitter/nvim-treesitter-textobjects'},
            {'nvim-treesitter/nvim-treesitter-context'},
        },
    })

    -- undotree
    use ({'mbbill/undotree'})

    -- lsp
    use ({
        'neovim/nvim-lspconfig',
        requires = {
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        }
    })

    -- autocomplete
    use ({
        'hrsh7th/nvim-cmp',
        requires = {
            {'L3MON4D3/LuaSnip'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'hrsh7th/cmp-nvim-lsp-signature-help'},
            {'hrsh7th/cmp-nvim-lua'},
        }
    })

end)
