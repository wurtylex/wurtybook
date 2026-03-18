return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#19120c',
				base01 = '#19120c',
				base02 = '#a39d96',
				base03 = '#a39d96',
				base04 = '#fff6ee',
				base05 = '#fffbf8',
				base06 = '#fffbf8',
				base07 = '#fffbf8',
				base08 = '#ff9e97',
				base09 = '#ff9e97',
				base0A = '#ffc58a',
				base0B = '#aeff9e',
				base0C = '#ffe0c1',
				base0D = '#ffc58a',
				base0E = '#ffcf9e',
				base0F = '#ffcf9e',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#a39d96',
				fg = '#fffbf8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#ffc58a',
				fg = '#19120c',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#a39d96' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffe0c1', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffcf9e',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#ffc58a',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#ffc58a',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffe0c1',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#aeff9e',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#fff6ee' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#fff6ee' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#a39d96',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
