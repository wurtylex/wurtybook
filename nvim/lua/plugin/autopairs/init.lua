return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true, -- enable Treesitter integration
  },
  config = function(_, opts)
    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'
    local ts_conds = require 'nvim-autopairs.ts-conds'

    npairs.setup(opts)

    npairs.add_rules {
      -- also markdown: a closed $ pair is what lets the treesitter mathzone
      -- detection (util/snippets.lua) see math while typing into it
      Rule('$', '$', { 'tex', 'markdown' })
        :with_pair(ts_conds.is_not_ts_node { 'comment' })
        :with_pair(function()
          return require('util.snippets').not_md_code()
        end),
    }
  end,
}
