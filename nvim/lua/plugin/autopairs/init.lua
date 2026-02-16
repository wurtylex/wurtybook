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
      Rule('$', '$', 'tex'):with_pair(ts_conds.is_not_ts_node { 'comment' }),
    }
  end,
}
