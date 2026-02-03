return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        picker = { enabled = true },
        quickfile = { enabled = false },
        scope = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = true },
        styles = {
            notification = {
                wo = { wrap = true } -- Wrap notifications
            },
        },
    },
}
