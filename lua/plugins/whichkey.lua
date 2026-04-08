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
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
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
