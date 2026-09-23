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

---The function will verify if a parser is present for a language and will launch the highlight for the language
---@param buf integer a number that is used by Neovim
---@param language string language name used in treesitter
---@return boolean false if the parser isn't found in the parser runtime directory, true if the language is found and the highlight is started
local function attach(buf, language)
	-- check if the parser exists before starting highlighter
	if not vim.treesitter.language.add(language) then
		return false
	end
	
	vim.treesitter.start(buf, language)
	return true
end

vim.api.nvim_create_autocmd({"FileType"}, {
	---The function is going to be triggered each time the user opens a file, it will check if the user has the parser for this language. If so, it is going to load the parser and starts the highlight. If not, it will try to install the parser for the language and try to start the highlight
	callback = function(args)
		local buf, filetype = args.buf, args.match
		local language = vim.treesitter.language.get_lang(filetype)
		
		if not language then
			return
		end

		if attach(buf, language) then
			return
		end
		-- attempt to start highlighter after installing missing language
		require('nvim-treesitter').install(language):await(function()
			attach(buf, language)
		end)
	end,
})
