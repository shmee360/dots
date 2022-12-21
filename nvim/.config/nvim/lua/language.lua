local o = vim.o
local cmd = vim.cmd

-- Rust
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

lspconfig = require 'lspconfig'

-- Python
lspconfig.pyright.setup{}

-- R
lspconfig.r_language_server.setup{}

-- TypeScript
lspconfig.tsserver.setup {
    -- on_attach = function(client)
    --     client.resolved_capabilities.document_formatting = false
    -- end
}

-- local filetypes = {
--     typescript = "eslint",
--     typescriptreact = "eslint",
--     javascript = "eslint",
-- 	javascriptreact = "eslint",
-- }

-- local linters = {
--     eslint = {
--         sourceName = "eslint",
--         command = "eslint_d",
--         rootPatterns = {".eslintrc.js", "package.json"},
--         debounce = 100,
--         args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
--         parseJson = {
--             errorsRoot = "[0].messages",
--             line = "line",
--             column = "column",
--             endLine = "endLine",
--             endColumn = "endColumn",
--             message = "${message} [${ruleId}]",
--             security = "severity"
--         },
--         securities = {[2] = "error", [1] = "warning"}
--     }
-- }

-- local formatters = {
--     prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
-- }

-- local formatFiletypes = {
--     typescript = "prettier",
--     typescriptreact = "prettier",
--     javascript = "prettier",
--     javascriptreact = "prettier",
--     json = "prettier",
--     css = "prettier",
--     less = "prettier",
--     scss = "prettier",
-- }

-- lspconfig.diagnosticls.setup {
--     filetypes = vim.tbl_keys(filetypes),
--     init_options = {
--         filetypes = filetypes,
--         linters = linters,
--         formatters = formatters,
--         formatFiletypes = formatFiletypes
--     }
-- }

-- Haskell
lspconfig.hls.setup{
	settings = { haskell = {
		formattingProvider = 'fourmolu'
	}}
}
cmd('au BufWritePre *.hs lua vim.lsp.buf.formatting_sync(nil, 1000)')

-- Vim
-- lspconfig.vimls.setup{}

-- Go
lspconfig.gopls.setup{
	cmd = {"gopls", "serve"},
    settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
    },
}

cmd('au BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)')

-- C/C++
lspconfig.ccls.setup{}

-- GDscript
lspconfig.gdscript.setup{}

cmd('au BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)')

cmd('au CursorHold * lua vim.diagnostic.open_float()')

-- Completion --
-- Set completeopt to have a better completion experience
o.completeopt = 'menu,menuone,noselect'

-- Avoid showing extra messages when using completion
o.shortmess = o.shortmess .. 'c'

require 'compe'.setup {
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;

	source = {
		path = true;
		buffer = true;
		calc = true;
		vsnip = true;
		nvim_lsp = true;
		nvim_lua = true;
		spell = true;
		tags = true;
		snippets_nvim = true;
	};
}
