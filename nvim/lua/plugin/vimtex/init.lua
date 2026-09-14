return {
  'lervag/vimtex',
  -- The headless Zathura callback needs :VimtexInverseSearch at startup.
  lazy = false,
  init = function()
    -- PDF viewer: Skim on macOS (SyncTeX forward/backward search), zathura on Linux.
    if vim.fn.has 'mac' == 1 then
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_view_skim_sync = 1 -- forward search after compile
      vim.g.vimtex_view_skim_activate = 1 -- focus Skim on forward search
    else
      -- Let Zathura reuse its PDF window without X11/xdotool on Wayland.
      if vim.env.WAYLAND_DISPLAY or vim.fn.executable 'xdotool' == 0 then
        vim.g.vimtex_view_method = 'zathura_simple'
      else
        vim.g.vimtex_view_method = 'zathura'
      end
      vim.g.vimtex_view_zathura_use_synctex = 1
    end
    vim.g.vimtex_view_forward_search_on_start = 1
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = '.build',
      options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1', -- Generate the source/PDF positions used by both searches.
        '-interaction=nonstopmode',
      },
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
