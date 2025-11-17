require("opts")
require("config.lazy")
require("mappings")

require("mini.move").setup()
require("mini.pairs").setup()

vim.lsp.enable("lua_ls", "bashls")

vim.cmd("colorscheme vscode")
