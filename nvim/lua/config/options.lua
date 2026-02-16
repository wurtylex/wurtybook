-- See :help {entry} if needing more description future me (ex: :help tabstop)

-- Editing + Buffers
vim.o.modifiable = true
vim.o.encoding = 'utf-8'
vim.o.confirm = true -- prompt before quitting unsaved
vim.o.undofile = true

-- Clipboard
vim.o.clipboard = 'unnamedplus' -- sync OS clipboard with nvim clipboard

-- Indentation + Tabs
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.breakindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split' -- live preview of search/replace

-- UI: Lines, columns, and highlighting
vim.o.number = true
vim.o.cursorline = true -- highlight current line
vim.o.signcolumn = 'yes'
vim.o.showmode = false -- status line shows mode
vim.o.scrolloff = 10 -- keep context around cursor
vim.o.fillchars = 'eob: ' -- make ~ into empty spaces
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.list = true

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Responsiveness (measured in ms)
vim.o.updatetime = 250 -- faster diagnostics update
vim.o.timeoutlen = 300 -- shorter mapped sequence wait
