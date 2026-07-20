local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local rep = require('luasnip.extras').rep
local fmta = require('luasnip.extras.fmt').fmta

local u = require 'util.snippets'
local get_visual = u.get_visual

local generate_matrix = function(args, snip)
  local rows = tonumber(snip.captures[2])
  local cols = tonumber(snip.captures[3])
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. 'x1', i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t ' & ')
      table.insert(nodes, r(ins_indx, tostring(j) .. 'x' .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t { '\\\\', '' })
  end
  -- fix last node.
  nodes[#nodes] = t '\\\\'
  return sn(nil, nodes)
end

local generate_cases = function(args, snip)
  local rows = tonumber(snip.captures[1]) or 2 -- default option 2 for cases
  local cols = 2 -- fix to 2 cols
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. 'x1', i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t ' & ')
      table.insert(nodes, r(ins_indx, tostring(j) .. 'x' .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t { '\\\\', '' })
  end
  -- fix last node.
  table.remove(nodes, #nodes)
  return sn(nil, nodes)
end

return {
  -- Enviroments
  -- Generic Enviroment
  s(
    { trig = 'env', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        d(2, get_visual),
        rep(1),
      }
    ),
    { condition = u.line_begin * u.tex_or_math, show_condition = u.tex_or_math }
  ),
  -- Generic Enviroment with 2 arguments
  s(
    { trig = 'e2', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{<>}{<>}
          <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        d(3, get_visual),
        rep(1),
      }
    ),
    { condition = u.line_begin * u.tex_or_math, show_condition = u.tex_or_math }
  ),
  -- Generic Enviroment with 3 arguments
  s(
    { trig = 'e3', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{<>}{<>}{<>}
          <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        i(3),
        d(4, get_visual),
        rep(1),
      }
    ),
    { condition = u.line_begin * u.tex_or_math, show_condition = u.tex_or_math }
  ),
  --equation
  s(
    { trig = 'beq', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{equation*}
          <>
        \end{equation*}
      ]],
      { d(1, get_visual) }
    ),
    { condition = u.line_begin * u.is_tex, show_condition = u.is_tex }
  ),
  --align
  s(
    { trig = 'bal', snippetType = 'autosnippet' },
    fmta(
      [[
        \begin{align*}
          <>
        \end{align*}
      ]],
      { d(1, get_visual) }
    ),
    { condition = u.line_begin * u.is_tex, show_condition = u.is_tex }
  ),
  -- inline math mode
  s(
    { trig = '([^%l])mm', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>$<>$', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = u.not_md_code, show_condition = u.not_md_code }
  ),
  -- centered math mode (markdown counterpart lives in snippets/markdown/math.lua)
  s(
    { trig = 'cmm', wordTrig = false, snippetType = 'autosnippet' },
    fmta('\\[<>\\]', {
      d(1, get_visual),
    }),
    { condition = u.is_tex, show_condition = u.is_tex }
  ),
  -- matrices
  s(
    { trig = '([bBpvV])mat(%d+)x(%d+)([ar])', name = '[bBpvV]matrix', dscr = 'matrices', regTrig = true, hidden = true, snippetType = 'autosnippet' },
    fmta(
      [[
    \begin{<>}<>
    <>
    \end{<>}]],
      {
        f(function(_, snip)
          return snip.captures[1] .. 'matrix'
        end),
        f(function(_, snip)
          if snip.captures[4] == 'a' then
            local out = string.rep('c', tonumber(snip.captures[3]) - 1)
            return '[' .. out .. '|c]'
          end
          return ''
        end),
        d(1, generate_matrix),
        f(function(_, snip)
          return snip.captures[1] .. 'matrix'
        end),
      }
    ),
    { condition = u.in_mathzone, show_condition = u.in_mathzone }
  ),
  -- cases
  s(
    { trig = '(%d?)cases', name = 'cases', dscr = 'cases', regTrig = true, hidden = true, snippetType = 'autosnippet' },
    fmta(
      [[
    \begin{cases}
    <>
    \end{cases}
    ]],
      { d(1, generate_cases) }
    ),
    { condition = u.in_mathzone, show_condition = u.in_mathzone }
  ),
}
