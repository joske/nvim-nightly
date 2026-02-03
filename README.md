# Neovim Configuration

Modern Neovim config for 0.11+

## Stack

- **lazy.nvim** for package management
- **blink.cmp** for completions
- **LSP** via nvim-lspconfig (lua_ls, bashls, yamlls, tombi, texlab, json-lsp)
- **Mason** for tool installation
- **none-ls** for formatting (shfmt, yamlfmt) and linting (shellcheck)
- **Treesitter** for syntax highlighting
- **Snacks** for terminal, pickers, explorer, notifications, lazygit integration, and dashboard
- **lualine** for statusline
- **bufferline** for buffer tabs
- **which-key** for keybinding hints
- **rustaceanvim** for Rust support
- **mini.pairs** and **mini.move** for editor enhancements
- **Trouble** for diagnostics
- **Comment.nvim** for toggling comments
- **todo-comments** for TODO highlighting
- **fugitive** for git commands
- **fidget** for LSP progress

## Features

- Format on save
- Auto-refresh git status in neo-tree after lazygit operations
- Inlay hints for supported LSPs

## Requirements

- Neovim 0.11+
- Git
- Nerd Font
- ripgrep
- fd
- fzf
- latex
- yarn
- lazygit/git
- rust/rust_analyzer
