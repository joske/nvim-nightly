return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },

    version = "1.*",

    ---@module 'blink.cmp'
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = "enter" },
        signature = { enabled = true },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            menu = {
                auto_show = true,
                draw = {
                    treesitter = { "lsp" },
                    columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
                },
            },
        },
        snippets = { preset = "luasnip" },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
