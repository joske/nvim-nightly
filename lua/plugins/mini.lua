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
}
