return {
  'Julian/lean.nvim',
  event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

  dependencies = {
    -- optional dependencies:

    'nvim-telescope/telescope.nvim', -- for Lean-specific pickers
    'andymass/vim-matchup', -- for enhanced % motion behavior
    'andrewradev/switch.vim', -- for switch support
    'tomtom/tcomment_vim', -- for commenting
  },

  ---@type lean.Config
  opts = { -- see the manual for full configuration options
    mappings = true,
  },

  config = function(_, opts)
    require('lean').setup(opts)

    -- Closing a Lean buffer with :q / :wq leaves the infoview split open,
    -- forcing a second :q. Close the infoview just before quitting so one
    -- command tears down both windows.
    vim.api.nvim_create_autocmd('QuitPre', {
      pattern = '*.lean',
      callback = function()
        require('lean.infoview').close_all()
      end,
    })
  end,
}
