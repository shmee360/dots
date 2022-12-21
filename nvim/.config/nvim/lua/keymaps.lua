local map = vim.api.nvim_set_keymap

local no_silent = { noremap = true, silent = true }
local no_silent_expr = { noremap = true, silent = true, expr = true }

map('', '<A-b>', '<nop>', no_silent)
map('', '<A-n>', '<nop>', no_silent)
map('', '<A-s>', '<nop>', no_silent)
map('', '<A-<up>>', '<nop>', no_silent)
map('', '<A-<down>>', '<nop>', no_silent)
map('', '<A-<left>>', '<nop>', no_silent)
map('', '<A-<right>>', '<nop>', no_silent)

-- Making Spacebar the leader
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local initfile = _G.isWin() and '$MYVIMRC/../init.lua' or '$MYVIMRC'
function _G.vimrc_open()
	if not vim.api.nvim_buf_get_option(0, 'modified') then
		return ':e ' .. initfile .. '\r'
	else
		return ':vsplit ' .. initfile .. '\r'
	end
end

map('n', '<leader>a', ':luafile ' .. initfile .. '<cr>', no_silent)
map('n', '<leader>vc', "v:lua.vimrc_open()", no_silent_expr)
map('n', '<leader>n', '<cmd>:noh<cr>', { noremap = true })

-- Split Switching
map('', '<c-h>', '<c-w>h', { silent = true })
map('', '<c-j>', '<c-w>j', { silent = true })
map('', '<c-k>', '<c-w>k', { silent = true })
map('', '<c-l>', '<c-w>l', { silent = true })

-- Accent Helper
map('n', '<leader>dk', ':call ToggleDeadKeys()<cr>', { noremap = true })

-- Package Manager Shortcuts
map('n', '<leader>s', ':PaqSync<cr>', { noremap = true })

-- Navigation Drawer Shortcuts
map('n', '<C-n>', ':NvimTreeToggle<cr>', no_silent)

-- Code navigation shortcuts
-- as found in :help lsp
map('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', no_silent)
map('n', 'K',     '<cmd>lua vim.lsp.buf.hover()<CR>', no_silent)
map('n', 'gD',    '<cmd>lua vim.lsp.buf.implementation()<CR>', no_silent)
map('n', '<c-f>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', no_silent)
map('n', '1gD',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', no_silent)
map('n', 'gs',    '<cmd>lua vim.lsp.buf.references()<CR>', no_silent)
map('n', 'g0',    '<cmd>lua vim.lsp.buf.document_symbol()<CR>', no_silent)
map('n', 'gW',    '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', no_silent)
map('n', 'gd',    '<cmd>lua vim.lsp.buf.declaration()<CR>', no_silent)
map('n', 'grr',    '<cmd>lua vim.lsp.buf.rename()<CR>', no_silent)
map('n', '<leader>l', ':LspInfo<cr>', no_silent)

-- Goto previous/next diagnostic warning/error
map('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', no_silent)
map('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', no_silent)

-- Completion
map('i', '<C-Space>', 'compe#complete()', no_silent_expr)
map('i', '<CR>',      "compe#confirm('<CR>')", no_silent_expr)
map('i', '<C-e>',     "compe#close('<C-e>')", no_silent_expr)

-- Use <Tab> and <S-Tab> to navigate through popup menu
map('i', '<Tab>',   'pumvisible() ? "<C-n>" : "<Tab>"', no_silent_expr)
map('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', no_silent_expr)

-- Barbar
-- Move to previous/next
map('n', '<A-h>', '<cmd>:BufferPrevious<cr>', no_silent)
map('n', '<A-l>', '<cmd>:BufferNext<cr>', no_silent)

-- Re-order to previous/next
map('n', '<A-H>', '<cmd>:BufferMovePrevious<cr>', no_silent)
map('n', '<A-L>', '<cmd>:BufferMoveNext<cr>', no_silent)

-- Close/pin
map('n', '<leader>c', ':BufferClose<cr>', no_silent)
map('n', '<leader>p', ':BufferPin<cr>', no_silent)
map('n', '<leader>C', ':BufferCloseAllButPinned<cr>', no_silent)

-- Terminal
map('t', '<esc>', '<C-\\><C-n>', no_silent)
