-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {'tpope/vim-fugitive'}

	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function ()
			vim.cmd('colorscheme rose-pine')
		end
	})

	use ( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

	use ('mbbill/undotree')

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},

        {'L3MON4D3/LuaSnip',     -- Required
        tag = 'v2.*',
        run = 'make install jsregexp'}
    }
}

end)
