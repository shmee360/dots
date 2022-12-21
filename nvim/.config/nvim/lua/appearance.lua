local M = {}

local o = vim.o
local g = vim.g
local cmd = vim.cmd
local api = vim.api
local fn = vim.fn

-- dealing with devicon BS
local devicons = require 'nvim-web-devicons'

function get_icon_data(name, ext)
	if not devicons.has_loaded() then
		devicons.setup()
	end
	local icons = devicons.get_icons()

	local icon_data = icons[name]
	local by_name = icon_data and icon_data or nil

	if by_name then
		return by_name
	else
		icon_data = icons[ext]

		if icon_data then
			local by_ext = icon_data
			return by_ext
		end
	end
end

-- Colour Scheme
cmd('let $NVIM_TUI_ENABLE_TRUE_COLOR=1')
o.termguicolors = true
g.gruvbox_guisp_fallback = "bg"
cmd('colo gruvbox')

cmd('au FileType rmd,rmarkdown setlocal commentstring=<!--%s-->')

o.spellsuggest = "best,9"
cmd('au FileType rmd,rmarkdown setlocal spell spelllang=en_ca')

-- Treesitter Settings
require 'nvim-treesitter.install'.compilers = {'clang', 'gcc'}
require 'nvim-treesitter.configs'.setup {
	ensure_installed = {
		'c', 'cpp', 'css', 'commonlisp', 'cuda', 'dart', 'gdscript', 'glsl',
		'go', 'godot_resource', 'haskell', 'html', 'java', 'javascript',
		'json', 'jsonc', 'lua', 'markdown', 'markdown_inline', 'python', 'r',
		'regex', 'rust', 'scss', 'sql', 'toml', 'tsx', 'typescript', 'vue',
		'yaml'
	},
	highlight = { enable = true },
	indent = { enable = true },
	context_commentstring = {
		__default = '<!-- %s -->',
		enable = true
	},
}

require("commented").setup({
    -- hooks = {
		-- before_comment = require("ts_context_commentstring.internal").update_commentstring,
    -- },
    comment_padding = ' ',
    keybindings = {
        n = 'gc',
        v = 'gc',
        nl = 'gcc',
    },
    prefer_block_comment = false,
    set_keybindings = true,
    ex_mode_cmd = 'Comment',
})

-- Terminal
require("toggleterm").setup{
	open_mapping = [[<a-;>]],
	height = 10,
}

-- General Aesthetics
cmd('syntax enable')
cmd('filet plugin indent on')
o.signcolumn = 'yes'

-- Bufferline
g.bufferline = { icon_pinned = '' }

-- Statusline
o.showmode = false

local sep = '|'

function M.highlight(group, fg, bg)
	cmd('hi ' .. group .. ' guifg=' .. fg .. ' guibg=' .. bg)
end

M.highlight('StatusHint', '#b8bb26', '#504945')
M.highlight('StatusWarn', 'Orange', '#504945')
M.highlight('StatusErr', '#fb4934', '#504945')

M.highlight('BarRound', '#504945', '#282828')
M.highlight('FileBack', '#ebdbb2', '#076678')
M.highlight('FileSep', '#076678', '#504945')
M.highlight('FileLock', '#fb4934', '#076678')

local mode_highlights = {
	['n'] = {'normal', '#8ec07c'},
	['nt'] = {'normal', '#8ec07c'},
	['no'] = {'n·operator pending', '#8ec07c'},
	['v'] = {'visual', '#fe8019'},
	['V'] = {'v·line', '#fe8019'},
	[''] = {'v·block', '#fe8019'},
	['s'] = {'select', '#fabd2f'},
	['S'] = {'s·line', '#fabd2f'},
	[''] = {'s·block', '#fabd2f'},
	['i'] = {'insert', '#fabd2f'},
	['ic'] = {'insert', '#fabd2f'},
	['R'] = {'replace', '#fabd2f'},
	['Rv'] = {'v·replace', '#fabd2f'},
	['c'] = {'command', '#fb4934'},
	['cv'] = {'vim ex', '#fb4934'},
	['ce'] = {'ex', '#fb4934'},
	['r'] = {'prompt', '#fb4934'},
	['rm'] = {'more', '#fe8019'},
	['r?'] = {'confirm', '#b8bb26'},
	['!'] = {'shell', '#076678'},
	['t'] = {'terminal', '#076678'},
}

local line_endings = {
	['unix'] = '%#StatusHint#  %#StatusLine#',
	['dos'] = '%#StatusErr#  %#StatusLine#'
}

function status_line()
	local bufhandle = fn.winbufnr(g.statusline_winid)

	local filetype = api.nvim_buf_get_option(bufhandle, 'filetype')
	local bufterm = api.nvim_buf_get_option(bufhandle, 'buftype') == 'terminal'
	if filetype == 'NvimTree' or bufterm then return '' end

	local mode = api.nvim_get_mode().mode
	local buf_modified = api.nvim_buf_get_option(bufhandle, 'modified')
	local buf_ro = api.nvim_buf_get_option(bufhandle, 'readonly')
	g.fullname = api.nvim_buf_get_name(bufhandle)
	local bufhelp = api.nvim_buf_get_option(bufhandle, 'buftype') == 'help'
	local file_format = line_endings[api.nvim_buf_get_option(bufhandle, "fileformat")]
	local line_count = api.nvim_buf_line_count(bufhandle)

	local highlight = mode_highlights[mode][2]
	if highlight == nil then highlight = '#ebdbb2' end
	
	local modified = ''
	if buf_modified then
		modified = '  '
	end

	local read_only = ''
	if buf_ro then
		read_only = '%#FileLock#  %#FileBack#'
	end

	local preview = ''
	if fn.win_gettype() == 'preview' then
		preview = ' '
	end

	function tabLen(tab)
		local n = 0
		for _ in pairs(tab) do n = n + 1 end
		return n
	end

	local gnostics = ' '
	if next(vim.lsp.buf_get_clients(bufhandle)) ~= nil then
		local hints = tabLen(vim.diagnostic.get(bufhandle, { severity = {max=vim.diagnostic.severity.INFO }}))
		local warns = tabLen(vim.diagnostic.get(bufhandle, { severity = vim.diagnostic.severity.WARN }))
		local errs = tabLen(vim.diagnostic.get(bufhandle, { severity = vim.diagnostic.severity.ERROR }))

		gnostics = ' '
		if hints > 0 then
			gnostics = gnostics .. " %#StatusHint# " .. hints
		end
		if warns > 0 then
			gnostics = gnostics .. " %#StatusWarn# " .. warns
		end
		if errs > 0 then
			gnostics = gnostics .. " %#StatusErr# " .. errs
		end
	end

	g.extension = string.match(g.fullname, '^.*%.*.*%.(.+)$')
	if g.extension == nil or g.extension == g.fullname or string.find(g.extension, '/') then
		g.extension = ''
	end

	local icon_data = get_icon_data(g.fullname, g.extension)
	local icon

	if icon_data ~= nil then
		icon = icon_data.icon
		local hi_name = 'UserIcon' .. icon_data.name
		M.highlight(hi_name, icon_data.color, '#504945')
		icon = '%#' .. hi_name .. '#' .. icon .. ' %#StatusLine#'
	elseif bufhelp then
		icon = '%#StatusHint# %#StatusLine#'
	elseif filetype == 'mail' then
		icon = ' '
	else
		icon = '%#StatusErr# %#StatusLine#'
	end

	M.highlight('ModeBg', '#282828', highlight)
	M.highlight('ModeSep', highlight, '#504945')

	local statusline = ""
		.. " %#ModeSep#"
		.. "%#ModeBg#" .. mode_highlights[mode][1]
		.. "%#ModeSep#"
		.. " %#FileSep#%<"
		.. "%#FileBack#%f" .. modified .. read_only .. preview
		.. "%#FileSep# %#StatusLine#"
		.. gnostics
		.. "%#BarRound#%#VisualNC#"
		.. "%="
		.. "%#BarRound#%#StatusLine#" .. icon .. sep
		.. file_format .. sep
		.. " " .. line_count .. "l " .. sep
		.. " %-9(%l,%v%) %-4(%p%%%)"

		return statusline
end

o.statusline = "%!luaeval('status_line()')"

-- Indent
o.shiftwidth = 4
o.tabstop = 4

-- Line Numbering
o.number = true
o.relativenumber = true
