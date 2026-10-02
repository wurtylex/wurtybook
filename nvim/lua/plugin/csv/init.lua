return {
  'hat0uma/csvview.nvim',
  ft = { 'csv', 'tsv' },
  cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle', 'CsvViewInfo' },
  keys = {
    { '<leader>tc', '<cmd>CsvViewToggle<CR>', ft = { 'csv', 'tsv' }, desc = '[T]oggle [C]SV view' },
  },
  opts = {
    parser = {
      -- Detect comma/semicolon CSVs; TSVs always use tabs.
      delimiter = { ft = { tsv = '\t' }, fallbacks = { ',', '\t', ';', '|' } },
    },
    view = { display_mode = 'border' },
    keymaps = {
      -- cif edits a field; daf deletes it with its delimiter.
      textobject_field_inner = { 'if', mode = { 'o', 'x' } },
      textobject_field_outer = { 'af', mode = { 'o', 'x' } },
      jump_next_field_end = { '<Tab>', mode = { 'n', 'x' } },
      jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'x' } },
      jump_next_row = { ']r', mode = { 'n', 'x' } },
      jump_prev_row = { '[r', mode = { 'n', 'x' } },
    },
  },
  config = function(_, opts)
    local csvview = require 'csvview'
    csvview.setup(opts)

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('CsvViewAutoEnable', { clear = true }),
      pattern = { 'csv', 'tsv' },
      callback = function(event)
        csvview.enable(event.buf)
      end,
    })
  end,
}
