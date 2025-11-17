return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "lua", "rust", "bash", "toml", "json", "yaml", "markdown" },
      highlight = { enable = true },
    },
    config = function(_, opts)
      -- suppress LSP “missing-fields” warnings
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup(opts)
    end,
  }
