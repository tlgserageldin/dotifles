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

	use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

	use ('mbbill/undotree')
end)
