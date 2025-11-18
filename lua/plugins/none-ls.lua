return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require "null-ls"
        null_ls.setup {
            sources = {
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.yamlfmt,
                require("none-ls-shellcheck.diagnostics"),
                require("none-ls-shellcheck.code_actions"),
            },
        }
    end,
}
