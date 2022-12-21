local o = vim.o
local g = vim.g
local fn = vim.fn

if isWin() then
	o.shell = 'pwsh.exe'
	o.shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned ' ..
					 '-Command [Console]::InputEncoding=[Console]' ..
					 '::OutputEncoding=[System.Text.Encoding]::UTF8;'
	o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	o.shellquote = ''
	o.shellxquote = ''

	o.clipboard = 'unnamed'

	g.netrw_cygwin = 0
	g.netrw_scp_cmd = 'C:\\Windows\\System32\\OpenSSH\\scp.exe'
else
	if o.clipboard == '' then
		o.clipboard = 'unnamedplus'
	else
		o.clipboard = o.clipboard .. ',unnamedplus'
	end

	-- If we're in WSL
	if fn.executable('win32yank.exe') then
		-- https://superuser.com/a/1557751 (fixing wsl)
		-- win32yank MUST BE INSTALLED FROM SOURCE AND PUT IN THE PATH
		g.clipboard = {
			cache_enabled = 0,
			copy = {
				["*"] = "win32yank.exe -i --crlf",
				["+"] = "win32yank.exe -i --crlf"
			},
			name = "win32yank-wsl",
			paste = {
				["*"] = "win32yank.exe -o --lf",
				["+"] = "win32yank.exe -o --lf"
			}
		}
	end
end
