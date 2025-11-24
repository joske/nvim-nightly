return {
    {
        "nvim-mini/mini.move",
        version = "*",
        config = function() require("mini.move").setup() end,
    },
    {
        "nvim-mini/mini.pairs",
        version = "*",
        config = function() require("mini.pairs").setup() end,
    },
    {
        "nvim-mini/mini.clue",
        version = "*",
        config = function()
            require("mini.clue").setup({
                window = {
                    config = { anchor = 'SW', row = 'auto', col = 'auto', }
                },
                -- Register `<Leader>` as trigger
                triggers = {
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },
                },
            })
        end,
    },
    {
        "nvim-mini/mini.comment",
        version = "*",
        config = function()
            require("mini.comment").setup({
                mappings = {
                    comment = "<leader>/",
                    comment_line = "<leader>/",
                    comment_visual = "<leader>/",
                    textobject = "<leader>/",
                },
            })
        end,
    },
}
