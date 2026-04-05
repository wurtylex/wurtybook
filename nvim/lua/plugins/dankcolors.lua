return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#1c1107',
				base01 = '#1c1107',
				base02 = '#a59e98',
				base03 = '#a59e98',
				base04 = '#fff6ee',
				base05 = '#fffbf8',
				base06 = '#fffbf8',
				base07 = '#fffbf8',
				base08 = '#ff9e99',
				base09 = '#ff9e99',
				base0A = '#ffc28b',
				base0B = '#b0ff9f',
				base0C = '#ffdfc1',
				base0D = '#ffc28b',
				base0E = '#ffcd9f',
				base0F = '#ffcd9f',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#a59e98',
				fg = '#fffbf8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#ffc28b',
				fg = '#1c1107',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#a59e98' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffdfc1', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffcd9f',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#ffc28b',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#ffc28b',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffdfc1',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#b0ff9f',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#fff6ee' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#fff6ee' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#a59e98',
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
