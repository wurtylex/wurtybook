-- Shared LuaSnip helpers: visual-selection capture and filetype-aware context
-- detection, so the tex snippets can also be used in markdown ($...$ / $$...$$).
local ls = require 'luasnip'
local sn = ls.snippet_node
local i = ls.insert_node
local make_condition = require('luasnip.extras.conditions').make_condition

local M = {}

-- condition-only: upstream line_begin needs the matched_trigger argument, so
-- it (and anything composed with it) must never be used as show_condition
M.line_begin = require('luasnip.extras.conditions.expand').line_begin

M.get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- markdown context detection (treesitter) -----------------------------------

local MD_MATH_NODES = {
  latex_block = true, -- markdown_inline: $...$ and $$...$$
  -- tree-sitter-latex node types, present when the latex parser is installed
  -- and injected into latex_block:
  displayed_equation = true,
  inline_formula = true,
  math_environment = true,
}

local MD_CODE_NODES = {
  code_span = true,
  fenced_code_block = true,
  indented_code_block = true,
}

-- Set of ancestor node types at the cursor. The trigger text is already in
-- the buffer when a condition runs, so reparse before reading the tree.
local function md_node_types(ignore_injections)
  local ok, parser = pcall(vim.treesitter.get_parser, 0, 'markdown')
  if not ok or not parser then
    return nil
  end
  parser:parse(true)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]
  if col > 0 and vim.api.nvim_get_mode().mode:sub(1, 1) == 'i' then
    col = col - 1 -- in insert mode the cursor sits after the just-typed char
  end
  local node = vim.treesitter.get_node { pos = { row, col }, ignore_injections = ignore_injections }
  local types = {}
  while node do
    types[node:type()] = true
    node = node:parent()
  end
  return types
end

local function md_in_mathzone()
  local types = md_node_types(false)
  if not types then
    return false
  end
  for node_type in pairs(types) do
    if MD_MATH_NODES[node_type] then
      return true
    end
  end
  return false
end

local function md_in_code()
  -- fenced/indented blocks live in the outer markdown tree (their content is
  -- an injected language), code spans in the injected inline tree: check both.
  for _, ignore_injections in ipairs { true, false } do
    local types = md_node_types(ignore_injections)
    if types then
      for node_type in pairs(types) do
        if MD_CODE_NODES[node_type] then
          return true
        end
      end
    end
  end
  return false
end

-- conditions -----------------------------------------------------------------
-- make_condition objects compose with * (and), + (or), - (not).

M.is_tex = make_condition(function()
  return vim.bo.filetype == 'tex'
end)

M.is_markdown = make_condition(function()
  return vim.bo.filetype == 'markdown'
end)

M.in_mathzone = make_condition(function()
  local ft = vim.bo.filetype
  if ft == 'tex' then
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
  elseif ft == 'markdown' then
    return md_in_mathzone()
  end
  return false
end)

M.in_text = make_condition(function(...)
  return not M.in_mathzone(...)
end)

-- anywhere in a tex file (original behaviour), but only inside math in markdown
M.tex_or_math = make_condition(function(...)
  return vim.bo.filetype == 'tex' or M.in_mathzone(...)
end)

-- tex prose only: for \textit-style snippets that make no sense in markdown
M.in_tex_text = make_condition(function(...)
  return vim.bo.filetype == 'tex' and not M.in_mathzone(...)
end)

-- markdown prose only: outside math and outside code spans/blocks
M.in_md_text = make_condition(function()
  return vim.bo.filetype == 'markdown' and not md_in_mathzone() and not md_in_code()
end)

-- everywhere except markdown code contexts (for snippets that should keep
-- their unconditional tex behaviour)
M.not_md_code = make_condition(function()
  return not (vim.bo.filetype == 'markdown' and md_in_code())
end)

return M
