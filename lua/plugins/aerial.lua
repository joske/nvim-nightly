return {
    'stevearc/aerial.nvim',
    opts = {
        backends = { "lsp", "treesitter", "markdown" },
        layout = {
            max_width = { 40, 0.2 },
            min_width = 20,
            default_direction = "right",
        },
        show_guides = true,
        attach_mode = "window",
        close_automatic_events = { "unsupported", "unfocus" },
        open_automatic = false,
        ignore = {
            filetypes = { "help", "alpha", "dashboard", "neo-tree", "nvim-tree", "lazy", "mason", "toggleterm" },
            unlisted_buffers = true
        },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function(_, opts)
        require('aerial').setup(opts)
    end,
}
