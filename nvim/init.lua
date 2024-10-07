vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"                                        
if not vim.uv.fs_stat(lazypath) then                                                                
	print("Installing lazy.nvim")                                                                     
	vim.fn.system({                                                                                   
		"git",                                                                                          
		"clone",                                                                                        
		"--filter=blob:none",                                                                           
		"https://github.com/folke/lazy.nvim.git",                                                       
		"--branch=stable", -- latest stable release                                                     
		lazypath,                                                                                       
	})                                                                                                
	print("Done")                                                                                     
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup({
	{"iagorrr/noctishc.nvim"},
	{"ibhagwan/fzf-lua"},
	{"github/copilot.vim"},
	{
		"dundalek/lazy-lsp.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			{"VonHeikemen/lsp-zero.nvim", branch = "v4.x"},
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings to learn the available actions
				lsp_zero.default_keymaps({
					buffer = bufnr,
					preserve_mappings = false
				})
			end)

			require("lazy-lsp").setup {}
		end,
	},
})

vim.cmd('colorscheme noctishc')
vim.keymap.set("n", "<c-P>", require('fzf-lua').files, { desc = "Fzf Files" })
