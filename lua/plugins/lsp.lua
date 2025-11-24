return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "gbprod/none-ls-shellcheck.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup {}
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        -- overrides `require("mason-tool-installer").setup(...)`
        opts = {
            -- Make sure to use the names found in `:Mason`
            ensure_installed = {
                -- language servers
                -- don't put rust-analyzer here, use the system rust-analyzer instead
                "lua-language-server",
                "tombi",
                "yamlls",
                "texlab",
                "json-lsp",
                "marksman",
                "dockerfile-language-server",

                -- formatters
                "shfmt",
                "yamlfmt",
                "latexindent",

                -- linters
                "shellcheck",
            },
            integrations = {
                ["mason-lspconfig"] = true,
                ["mason-null-ls"] = true,
                ["mason-nvim-dap"] = true,
            },
        },
    },
}
