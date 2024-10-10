vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.g.mapleader = "\\"

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
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "cpp", "python"},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end
	},
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

			lsp_zero.extend_lspconfig({
				sign_text = true, -- show diagnostic signs in the text buffer
				lsp_attach = function(client, buffer_no)
					lsp_zero.default_keymaps({
						buffer = buffer_no,
						preserve_mappings = false -- override existing keybindings
					})
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			})

			-- Autocompletion setup
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{name = 'nvim_lsp'},
				},
				snippet = {
					expand = function(args)
						-- Require Neovim v0.10
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({}),
			})

			require("lazy-lsp").setup {
				excluded_servers = { "ccls", "sourcekit" } -- avoid loading duplicates to clangd server
			}
		end,
	},
})

vim.cmd.colorscheme('noctishc')
-- Override comment colors to make it easier to read
vim.api.nvim_set_hl(0, "Comment", { fg = "#999999", italic = true })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment"})

vim.keymap.set("n", "<c-P>", require('fzf-lua').files, { desc = "Fzf Files" })
vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>lg', '<cmd>lua require("fzf-lua").live_grep()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', ':Explore<CR>', { noremap = true, silent = true })
