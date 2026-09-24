vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.opt.termguicolors = true

require('plugins.lsp')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.mini_pairs')
require('plugins.colorscheme')
-- not working
require('plugins.bufferline')
