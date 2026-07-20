local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node

local u = require 'util.snippets'

-- anywhere in tex (original behaviour), only inside math in markdown
local cond = { condition = u.tex_or_math, show_condition = u.tex_or_math }

return {
  -- Basic Symbols That are commonly used
  s({ trig = ';a', snippetType = 'autosnippet' }, { t '\\alpha' }, cond),
  s({ trig = ';b', snippetType = 'autosnippet' }, { t '\\beta' }, cond),
  s({ trig = ';g', snippetType = 'autosnippet' }, { t '\\gamma' }, cond),
  s({ trig = ';G', snippetType = 'autosnippet' }, { t '\\Gamma' }, cond),
  s({ trig = ';d', snippetType = 'autosnippet' }, { t '\\delta' }, cond),
  s({ trig = ';D', snippetType = 'autosnippet' }, { t '\\Delta' }, cond),
  s({ trig = ';e', snippetType = 'autosnippet' }, { t '\\epsilon' }, cond),
  s({ trig = ';ve', snippetType = 'autosnippet' }, { t '\\varepsilon' }, cond),
  s({ trig = ';z', snippetType = 'autosnippet' }, { t '\\zeta' }, cond),
  s({ trig = ';h', snippetType = 'autosnippet' }, { t '\\eta' }, cond),
  s({ trig = ';o', snippetType = 'autosnippet' }, { t '\\theta' }, cond),
  s({ trig = ';vo', snippetType = 'autosnippet' }, { t '\\vartheta' }, cond),
  s({ trig = ';O', snippetType = 'autosnippet' }, { t '\\Theta' }, cond),
  s({ trig = ';k', snippetType = 'autosnippet' }, { t '\\kappa' }, cond),
  s({ trig = ';l', snippetType = 'autosnippet' }, { t '\\lambda' }, cond),
  s({ trig = ';L', snippetType = 'autosnippet' }, { t '\\Lambda' }, cond),
  s({ trig = ';m', snippetType = 'autosnippet' }, { t '\\mu' }, cond),
  s({ trig = ';n', snippetType = 'autosnippet' }, { t '\\nu' }, cond),
  s({ trig = ';x', snippetType = 'autosnippet' }, { t '\\xi' }, cond),
  s({ trig = ';i', snippetType = 'autosnippet' }, { t '\\pi' }, cond),
  s({ trig = ';I', snippetType = 'autosnippet' }, { t '\\Pi' }, cond),
  s({ trig = ';r', snippetType = 'autosnippet' }, { t '\\rho' }, cond),
  s({ trig = ';s', snippetType = 'autosnippet' }, { t '\\sigma' }, cond),
  s({ trig = ';S', snippetType = 'autosnippet' }, { t '\\Sigma' }, cond),
  s({ trig = ';t', snippetType = 'autosnippet' }, { t '\\tau' }, cond),
  s({ trig = ';f', snippetType = 'autosnippet' }, { t '\\phi' }, cond),
  s({ trig = ';vf', snippetType = 'autosnippet' }, { t '\\varphi' }, cond),
  s({ trig = ';F', snippetType = 'autosnippet' }, { t '\\Phi' }, cond),
  s({ trig = ';c', snippetType = 'autosnippet' }, { t '\\chi' }, cond),
  s({ trig = ';p', snippetType = 'autosnippet' }, { t '\\psi' }, cond),
  s({ trig = ';P', snippetType = 'autosnippet' }, { t '\\Psi' }, cond),
  s({ trig = ';w', snippetType = 'autosnippet' }, { t '\\omega' }, cond),
  s({ trig = ';W', snippetType = 'autosnippet' }, { t '\\Omega' }, cond),
}
