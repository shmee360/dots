--   .--.--.       ___                         ,-.----.     ,----..
--  /  /    '.   ,--.'|_    ,--,               \    /  \   /   /   \
-- |  :  /`. /   |  | :,' ,--.'|               ;   :    \ |   :     :
-- ;  |  |--`    :  : ' : |  |,     ,--,  ,--, |   | .\ : .   |  ;. /
-- |  :  ;_    .;__,'  /  `--'_     |'. \/ .`| .   : |: | .   ; /--`
--  \  \    `. |  |   |   ,' ,'|    '  \/  / ; |   |  \ : ;   | ;
--   `----.   \:__,'| :   '  | |     \  \.' /  |   : .  / |   : |
--   __ \  \  |  '  : |__ |  | :      \  ;  ;  ;   | |  \ .   | '___
--  /  /`--'  /  |  | '.'|'  : |__   / \  \  \ |   | ;\  \'   ; : .'|
-- '--'.     /   ;  :    ;|  | '.'|./__;   ;  \:   ' | \.''   | '/  :
--   `--'---'    |  ,   / ;  :    ;|   :/\  \ ;:   : :-'  |   :    /
--                ---`-'  |  ,   / `---'  `--` |   |.'     \   \ .'
--                         ---`-'              `---'        `---`
-- -------------------------------------------------------------------

-- Dogshit:
-- source $OneDrive/vimrc/plugs.vimrc
-- source $OneDrive/vimrc/various.vimrc
-- source $OneDrive/vimrc/nerdtree.vimrc
-- source $OneDrive/vimrc/coc.vimrc

-- New Hotness:
local cmd = vim.cmd
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local fn = vim.fn
local api = vim.api
local g = vim.g

-- Plugins --
require 'paq' {
	'savq/paq-nvim';

	'qpkorr/vim-renamer';

	'gruvbox-community/gruvbox';
	'kyazdani42/nvim-web-devicons';

	'lukesmithxyz/vimling';

	'mhinz/vim-signify';

	'neovim/nvim-lspconfig';
	'hrsh7th/vim-vsnip';
	'hrsh7th/nvim-compe';

	'nvim-lua/popup.nvim';
	'nvim-lua/plenary.nvim';
	'nvim-telescope/telescope.nvim';

	'akinsho/toggleterm.nvim';

	'simrat39/rust-tools.nvim';
	'aklt/plantuml-syntax';
	'vim-pandoc/vim-pandoc';
	'vim-pandoc/vim-pandoc-syntax';
	'vim-pandoc/vim-rmarkdown';
	{"nvim-treesitter/nvim-treesitter", build=function() cmd("TSUpdate") end};

	'junegunn/goyo.vim';
	'mattn/emmet-vim';
	-- 'JoosepAlviste/nvim-ts-context-commentstring';
	'winston0410/commented.nvim';

	'kyazdani42/nvim-tree.lua';
	'akinsho/bufferline.nvim';
	'romgrk/barbar.nvim';

	'norcalli/nvim-colorizer.lua';
}

function isWin()
	local sysname = vim.loop.os_uname().sysname
	return sysname:lower():find("windows") ~= nil
end

-- ./lua/platform.lua
require 'platform'
-- ./lua/appearance.lua
require 'appearance'
-- ./lua/keymaps.lua
require 'keymaps'

-- fixing nvim-tree
require 'nvim-tree'.setup()

-- Write swapfile/git updates quicker
o.updatetime = 300

-- Sane split
o.splitbelow = true

-- ./lua/language.lua
require 'language'
