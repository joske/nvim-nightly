# Neovim Configuration

Modern Neovim config for 0.12+

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Clone the repository

```shell
git clone https://github.com/joske/nvim-nightly ~/.config/nvim
```

## Stack

- **lazy.nvim** for package management
- **blink.cmp** for completions
- **copilot.lua** for GitHub Copilot integration
- **LSP** via nvim-lspconfig (lua_ls, bashls, yamlls, tombi, texlab, json-lsp)
- **Mason** for tool installation
- **none-ls** for formatting (shfmt, yamlfmt) and linting (shellcheck)
- **Treesitter** for syntax highlighting
- **Snacks** for picker, explorer, dashboard, notifications, lazygit, git, GitHub, terminal, dim, and indent
- **lualine** for statusline
- **bufferline** for buffer tabs
- **which-key** for keybinding hints
- **rustaceanvim** + **crates.nvim** for Rust support
- **neotest** for testing
- **nvim-dap** + **dapui** for debugging
- **aerial.nvim** for code outline
- **Trouble** for diagnostics
- **todo-comments** for TODO highlighting
- **fugitive** + **lazygit.nvim** for git
- **fidget** for LSP progress
- **resession** for session management
- **render-markdown** for in-editor markdown rendering
- **markdown-preview** for browser-based markdown preview
- **actions-preview** for code action preview
- **rainbow-delimiters** for bracket colorization

- **mini.move**, **mini.pairs**, **mini.comment**, **mini.icons** for editor enhancements
- **LuaSnip** for snippets

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
