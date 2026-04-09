return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        ensure_installed = { "lua", "rust", "bash", "toml", "json", "yaml", "markdown" },
        highlight = { enable = true },
    },
}
