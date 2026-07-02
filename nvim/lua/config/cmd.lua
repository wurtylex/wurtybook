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

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore cursor to last position when reopening a tex file',
  group = vim.api.nvim_create_augroup('restore-cursor', { clear = true }),
  pattern = { '*.tex', '*.latex' },
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
