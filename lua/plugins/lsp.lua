vim.pack.add {
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
}

---@type vim.lsp.Config
vim.lsp.config.lua_ls = {
	root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
	---@type lspconfig.settings.lua_ls
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
				},
			},
			signatureHelp = { enable = true },
		},
	},
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
vim.diagnostic.config({ virtual_text = true })
