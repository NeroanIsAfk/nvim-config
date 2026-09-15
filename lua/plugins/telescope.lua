vim.pack.add({
	{ src = 'https://github.com/nvim-lua/plenary.nvim'},
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files'})
