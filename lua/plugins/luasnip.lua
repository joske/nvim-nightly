return {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
        history = true,
        delete_check_events = "TextChanged",
        region_check_events = "CursorMoved",
    },
    config = function(_, opts)
        require("luasnip").config.setup(opts)
    end,
}
