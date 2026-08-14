return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    -- PDF viewer: Skim on macOS (SyncTeX forward/backward search), zathura on Linux.
    if vim.fn.has 'mac' == 1 then
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_view_skim_sync = 1 -- forward search after compile
      vim.g.vimtex_view_skim_activate = 1 -- focus Skim on forward search
    else
      vim.g.vimtex_view_method = 'zathura'
    end
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
  end,
}
