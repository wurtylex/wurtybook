-- markdown counterparts of the font snippets in tex/text.lua
local ls = require 'luasnip'
local s = ls.snippet
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta

local u = require 'util.snippets'
local get_visual = u.get_visual

return {
  -- code, counterpart of \texttt
  s({ trig = 'ttt', snippetType = 'autosnippet' }, fmta('`<>`', { d(1, get_visual) }), { condition = u.in_md_text, show_condition = u.in_md_text }),
  -- italic, counterpart of \textit
  s({ trig = 'tii', snippetType = 'autosnippet' }, fmta('*<>*', { d(1, get_visual) }), { condition = u.in_md_text, show_condition = u.in_md_text }),
  -- bold, counterpart of \textbf
  s({ trig = 'tbt', snippetType = 'autosnippet' }, fmta('**<>**', { d(1, get_visual) }), { condition = u.in_md_text, show_condition = u.in_md_text }),
}
