return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  build = vim.fn.has "win32" == 0
      and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
    or nil,
  dependencies = { "rafamadriz/friendly-snippets", },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
    region_check_events = "CursorMoved",
  },
  config = function(_, opts)
    require("luasnip").config.setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load()
    -- (optional) also load your own lua snippets if you have any
    -- require("luasnip.loaders.from_lua").lazy_load()
  end,
}
