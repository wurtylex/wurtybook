local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta

local u = require 'util.snippets'
local get_visual = u.get_visual

return {
  -- subscript
  s(
    { trig = '([%w%)%]%}]);', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = u.in_mathzone, show_condition = u.in_mathzone }
  ),
  -- superscript
  s(
    { trig = '([%w%)%]%}]):', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = u.in_mathzone, show_condition = u.in_mathzone }
  ),
  -- super and subscript
  s(
    { trig = '([%w%)%]%}])__', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>^{<>}_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = u.in_mathzone, show_condition = u.in_mathzone }
  ),
  -- euler
  s(
    { trig = '([^%a])ee', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>e^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = u.in_mathzone, show_condition = u.in_mathzone }
  ),
  -- frac
  s(
    { trig = 'ff', snippetType = 'autosnippet' },
    fmta('\\frac{<>}{<>}', {
      i(1),
      i(2),
    }),
    { condition = u.in_mathzone, show_condition = u.in_mathzone }
  ),
  -- operatorname
  s(
    { trig = 'opn', snippetType = 'autosnippet' },
    fmta('\\operatorname{<>}', {
      d(1, get_visual),
    }),
    { condition = u.in_mathzone, show_condition = u.in_mathzone }
  ),
}
