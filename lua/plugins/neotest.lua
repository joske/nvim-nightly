return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<leader>tt", function() require("neotest").run.run() end,                  desc = "Run nearest test" },
        { "<leader>tT", function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run file tests" },
        { "<leader>ts", function() require("neotest").summary.toggle() end,           desc = "Toggle test summary" },
        { "<leader>to", function() require("neotest").output_panel.toggle() end,      desc = "Toggle test output" },
        { "<leader>rt", function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Rust: cargo test (file)" },
        { "<leader>rT", function() require("neotest").run.run() end,                  desc = "Rust: cargo test (nearest)" },
    },
    config = function()
        require("neotest").setup {
            adapters = {
                require("rustaceanvim.neotest")({
                    args = { "--no-capture" },
                }),
            },
        }
    end,
}
