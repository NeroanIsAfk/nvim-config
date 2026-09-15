vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'nvim-treesitter' and kind == 'update' then
			if not ev.data.active then
				vim.cmd.packadd('nvim-treesitter')
			end
			vim.cmd('TSUpdate')
		end
	end,
})

vim.pack.add({
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

if (vim.fn.has('win32') == 1) then
	vim.env.CC = 'gcc'
end

require('nvim-treesitter').install({ 'toml', 'javascript', 'typescript', 'tsx', "html", "css", "c", "cpp", "rust", "go" })

vim.api.nvim_create_autocmd({"FileType"}, {
	pattern = {"toml", "javascript", "typescript", "javascriptreact", "typescriptreact", "html", "css", "c", "cpp", "rust", "go"},
	callback = function(ev) vim.treesitter.start(ev.buf) end
})
