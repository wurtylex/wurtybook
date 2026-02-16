return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false },
        },
      }

      vim.cmd.colorscheme 'tokyonight-storm'
    end,
  },
  {
    priority = 1000,
    'oncomouse/lushwal.nvim',
    cmd = { 'LushwalCompile' },
    dependencies = {
      { 'rktjmp/lush.nvim' },
      { 'rktjmp/shipwright.nvim' },
    },
    lazy = false,
  },
}
