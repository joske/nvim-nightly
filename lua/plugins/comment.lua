return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    toggler = {
      line = "<leader>/",
      block = "<leader>b",
    },
    opleader = {
      line = "<leader>/",
      block = "<leader>b",
    },
  },
  config = function(_, opts)
    require("Comment").setup(opts)
  end,
}

