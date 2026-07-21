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
    local ap_conds = require 'nvim-autopairs.conds'
    local ap_utils = require 'nvim-autopairs.utils'

    npairs.setup(opts)

    -- Brackets typed inside $...$ / $$...$$: the default rules refuse to pair
    -- when the next char matches `ignored_next_char`, which includes `$`, so
    -- typing `(` with the cursor sitting right before a closing `$` inserted
    -- only `(`. Short-circuit that veto (a cond returning non-nil wins, and
    -- these sit at index 1) while keeping the unbalanced-line check.
    local is_bracket_line = ap_conds.is_bracket_line()
    local function pair_before_math_delim(o)
      local ft = vim.bo.filetype
      if ft ~= 'tex' and ft ~= 'markdown' then
        return
      end
      if ap_utils.text_sub_char(o.line, o.col, 1) ~= '$' then
        return -- not at a math delimiter: let the default conditions decide
      end
      return is_bracket_line(o) ~= false
    end
    for _, open in ipairs { '(', '[', '{' } do
      for _, rule in ipairs(npairs.get_rules(open)) do
        rule:with_pair(pair_before_math_delim, 1)
      end
    end

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
