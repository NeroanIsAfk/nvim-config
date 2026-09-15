vim.pack.add {
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
}

vim.lsp.enable('lua_ls')
vim.lsp.enable('tsc')
vim.lsp.enable('html')
vim.lsp.enable('cssls')
vim.lsp.enable('clangd')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('gopls')

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.cmd("set completeopt+=noselect")
