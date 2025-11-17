require("opts")
require("config.lazy")
require("mappings")

vim.lsp.enable({
	"lua_ls",
})

vim.cmd("colorscheme vscode")
