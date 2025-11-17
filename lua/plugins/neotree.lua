return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
  },
  lazy = false,
  config = function()
    local events = require("neo-tree.events")
    require("neo-tree").setup({
      event_handlers = {
        {
          event = events.NEO_TREE_BUFFER_ENTER,
          handler = function()
            -- quit only if Neo-tree is the only window AND no listed buffers remain
            if #vim.api.nvim_list_wins() == 1 and #vim.fn.getbufinfo({ buflisted = 1 }) == 0 then
              vim.cmd("quit")
            end
          end,
        },
      },
    })
  end,
}

