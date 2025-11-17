require("opts")
require("config.lazy")
require("mappings")

require("mini.move").setup()
require("mini.pairs").setup()

vim.lsp.enable("lua_ls", "bashls", "yamlls", "tombi", "shellcheck")

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.yamlfmt,
	},
})
vim.cmd("colorscheme vscode")
