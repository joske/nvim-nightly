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
        open_automatic = true,
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function(_, opts)
        require('aerial').setup(opts)

        -- Auto-close aerial when it's the last window
        vim.api.nvim_create_autocmd("QuitPre", {
            callback = function()
                local wins = vim.api.nvim_list_wins()
                -- Check if aerial is open
                for _, win in ipairs(wins) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local ft = vim.bo[buf].filetype
                    if ft == "aerial" then
                        vim.cmd("AerialClose")
                    end
                end
            end,
        })
    end,
}
