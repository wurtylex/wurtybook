function _G.R(mod)
  local info = debug.getinfo(2, 'S')
  local source = info.source:sub(2)
  local path = source:match 'lua/(.*)/init%.lua$' or source:match 'lua/(.*)%.lua$'
  return require(path:gsub('/', '.') .. '.' .. mod)
end
