local ls = require 'luasnip'
local s = ls.snippet
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta

local u = require 'util.snippets'
local get_visual = u.get_visual

return {
  --fonts
  -- TypeWriter
  s({ trig = 'ttt', snippetType = 'autosnippet' }, fmta('\\texttt{<>}', { d(1, get_visual) }), { condition = u.in_tex_text, show_condition = u.in_tex_text }),
  -- Italic
  s({ trig = 'tii', snippetType = 'autosnippet' }, fmta('\\textit{<>}', { d(1, get_visual) }), { condition = u.in_tex_text, show_condition = u.in_tex_text }),
  -- Bold
  s({ trig = 'tbt', snippetType = 'autosnippet' }, fmta('\\textbf{<>}', { d(1, get_visual) }), { condition = u.in_tex_text, show_condition = u.in_tex_text }),
  -- Small Caps
  s({ trig = 'tsc', snippetType = 'autosnippet' }, fmta('\\textsc{<>}', { d(1, get_visual) }), { condition = u.in_tex_text, show_condition = u.in_tex_text }),
  -- Roman Math
  s({ trig = 'rmm', snippetType = 'autosnippet' }, fmta('\\mathrm{<>}', { d(1, get_visual) }), { condition = u.in_mathzone, show_condition = u.in_mathzone }),
  -- Math Calig
  s({ trig = 'mcc', snippetType = 'autosnippet' }, fmta('\\mathcal{<>}', { d(1, get_visual) }), { condition = u.in_mathzone, show_condition = u.in_mathzone }),
  -- Math BoldFace
  s({ trig = 'mbf', snippetType = 'autosnippet' }, fmta('\\mathbf{<>}', { d(1, get_visual) }), { condition = u.in_mathzone, show_condition = u.in_mathzone }),
  -- Math BlackBoard
  s({ trig = 'mbb', snippetType = 'autosnippet' }, fmta('\\mathbb{<>}', { d(1, get_visual) }), { condition = u.in_mathzone, show_condition = u.in_mathzone }),
  -- Regular Text in math mode
  s({ trig = 'tee', snippetType = 'autosnippet' }, fmta('\\text{<>}', { d(1, get_visual) }), { condition = u.in_mathzone, show_condition = u.in_mathzone }),
}
