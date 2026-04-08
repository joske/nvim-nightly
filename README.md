# Neovim Configuration

Modern Neovim config for 0.12+

## Stack

- **lazy.nvim** for package management
- **blink.cmp** for completions
- **copilot.lua** for GitHub Copilot integration
- **LSP** via nvim-lspconfig (lua_ls, bashls, yamlls, tombi, texlab, json-lsp)
- **Mason** for tool installation
- **none-ls** for formatting (shfmt, yamlfmt) and linting (shellcheck)
- **Treesitter** for syntax highlighting
- **Snacks** for terminal, pickers, explorer, notifications, lazygit integration, github, and dashboard
- **lualine** for statusline
- **bufferline** for buffer tabs
- **mini.clue** for keybinding hints
- **mini.pairs**, **mini.move**, **mini.comment** for editor enhancements
- **rustaceanvim** + **crates.nvim** for Rust support
- **neotest** for testing
- **nvim-dap** + **dapui** for debugging
- **aerial.nvim** for code outline
- **Trouble** for diagnostics
- **todo-comments** for TODO highlighting
- **fugitive** + **lazygit.nvim** for git
- **fidget** for LSP progress
- **resession** for session management
- **markdown-preview** for Markdown
- **actions-preview** for code action preview
- **rainbow-delimiters** for bracket colorization

## Features

- Format on save
- Inlay hints for supported LSPs
- Neovide support

## Requirements

- Neovim 0.12+
- Git
- Nerd Font
- ripgrep
- fd
- fzf
- node/yarn
- lazygit
- rust/rust-analyzer
- tree-sitter CLI
- latex
