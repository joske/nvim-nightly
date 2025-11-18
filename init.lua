require "opts"
require "config.lazy"
require "mappings"

vim.lsp.enable { "lua_ls", "bashls", "yamlls", "tombi", "texlab", "json-lsp" }

vim.cmd "colorscheme vscode"
