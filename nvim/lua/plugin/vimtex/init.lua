return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = '.build',
    }
    vim.g.vimtex_quickfix_ignore_filters = {
      '^Underfull',
      '^Overfull',
      'LaTeX Warning',
      'Package .* Warning',
      'Class .* Warning',
    }
    vim.g.vimtex_quickfix_mode = 0

    vim.api.nvim_create_autocmd('User', {
      pattern = 'VimtexEventCompileSuccess',
      callback = function()
        vim.cmd('VimtexView')
      end,
    })
  end,
}
