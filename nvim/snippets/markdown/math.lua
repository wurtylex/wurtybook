-- markdown counterparts of the display-math snippets in tex/environments.lua
local ls = require 'luasnip'
local s = ls.snippet
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta

local u = require 'util.snippets'
local get_visual = u.get_visual

return {
  -- centered/display math, same trigger as the tex \[ \] snippet
  s(
    { trig = 'cmm', wordTrig = false, snippetType = 'autosnippet' },
    fmta('$$<>$$', { d(1, get_visual) }),
    { condition = u.in_md_text, show_condition = u.in_md_text }
  ),
  -- display equation block, same trigger as the tex equation* snippet
  s(
    { trig = 'beq', snippetType = 'autosnippet' },
    fmta(
      [[
        $$
        <>
        $$
      ]],
      { d(1, get_visual) }
    ),
    { condition = u.line_begin * u.in_md_text, show_condition = u.in_md_text }
  ),
  -- align block, same trigger as the tex align* snippet
  s(
    { trig = 'bal', snippetType = 'autosnippet' },
    fmta(
      [[
        $$
        \begin{align*}
        <>
        \end{align*}
        $$
      ]],
      { d(1, get_visual) }
    ),
    { condition = u.line_begin * u.in_md_text, show_condition = u.in_md_text }
  ),
}
