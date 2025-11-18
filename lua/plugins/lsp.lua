return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
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
                "lua-language-server",
                "tombi",
                "yamlls",
                "texlab",
                "shellcheck",

                -- formatters
                "shfmt",
                "yamlfmt",
                "xmlformatter",
                "latexindent",
            },
        },
        integrations = {
            ["mason-lspconfig"] = true,
            ["mason-null-ls"] = true,
            ["mason-nvim-dap"] = true,
        },
    },
}
