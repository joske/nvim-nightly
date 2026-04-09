return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        ensure_installed = { "rust", "bash", "toml", "json", "yaml", "markdown", "latex", "html" },
        highlight = { enable = true },
    },
}
