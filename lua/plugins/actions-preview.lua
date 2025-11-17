return {
    "aznhe21/actions-preview.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = function()
      return {
        backend = { "telescope" },
        extensions = { "env" },
        telescope = vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {}),
      }
    end,
  }
