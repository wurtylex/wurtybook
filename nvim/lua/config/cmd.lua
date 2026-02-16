-- vim.cmd.colorscheme 'lushwal' -- transparent to use system colors
-- NOTE: above makes me hella dizzy sometimes since bad colors

vim.cmd 'filetype plugin indent on'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
