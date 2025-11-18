require "opts"
require "config.lazy"
require "mappings"

vim.lsp.enable { "lua_ls", "bashls", "yamlls", "tombi", "shellcheck", "xmlformatter", "texlab" }

vim.cmd "colorscheme vscode"
