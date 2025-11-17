require("opts")
require("config.lazy")
require("mapping")

vim.lsp.enable({
	"lua_ls",
})

vim.cmd("colorscheme vscode")
