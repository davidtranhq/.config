-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.6',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use ({
	  "loctvl842/monokai-pro.nvim",
	  config = function()
		  require("monokai-pro").setup({
			  overrideScheme = function(cs, p, config, hp)
			   local cs_override = {}
			   local calc_bg = hp.blend(p.background, 0.75, '#000000')

			   cs_override.editor = {
			    background = calc_bg,
			   }
			   return cs_override
			  end
		  })
		  vim.cmd([[colorscheme monokai-pro]])
	  end
  })

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
end)
