return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          preview = { treesitter = false },
          color_devicons = true,
          sorting_strategy = "ascending",
          path_displays = { "smart" },
          layout_config = {
            height = 100,
            width = 400,
            prompt_position = "top",
            preview_cutoff = 40,
          },
          mappings = {
            i = { ["<C-j>"] = "move_selection_next", ["<C-k>"] = "move_selection_previous" },
            n = { ["<C-j>"] = "move_selection_next", ["<C-k>"] = "move_selection_previous" },
          },
        },
      })
      telescope.load_extension("ui-select")
    end,
  }
