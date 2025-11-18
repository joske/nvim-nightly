return {
    {
        "mrcjkb/rustaceanvim",
        init = function()
            vim.g.rustaceanvim = {
                tools = {
                    codelens = { enable = true },
                },
                server = {
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = { allFeatures = true },
                            checkOnSave = true,
                            lens = { enable = true },
                        },
                    },
                },
            }

            local codelens_group = vim.api.nvim_create_augroup("RustCodeLens", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                group = codelens_group,
                pattern = "*.rs",
                callback = function(args)
                    local bufnr = args.buf
                    if vim.bo[bufnr].filetype ~= "rust" or not vim.lsp.codelens then return end
                    vim.api.nvim_buf_call(bufnr, function()
                        pcall(vim.lsp.codelens.refresh)
                    end)
                end,
            })
        end,
    },
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {},
    },
}
