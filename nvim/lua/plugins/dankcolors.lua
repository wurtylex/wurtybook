return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#18111a',
				base01 = '#18111a',
				base02 = '#a199a5',
				base03 = '#a199a5',
				base04 = '#faefff',
				base05 = '#fdf8ff',
				base06 = '#fdf8ff',
				base07 = '#fdf8ff',
				base08 = '#ff9fae',
				base09 = '#ff9fae',
				base0A = '#ebbeff',
				base0B = '#a5ffbc',
				base0C = '#f4dcff',
				base0D = '#ebbeff',
				base0E = '#eec9ff',
				base0F = '#eec9ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#a199a5',
				fg = '#fdf8ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#ebbeff',
				fg = '#18111a',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#a199a5' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#f4dcff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#eec9ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#ebbeff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#ebbeff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#f4dcff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffbc',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#faefff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#faefff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#a199a5',
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
