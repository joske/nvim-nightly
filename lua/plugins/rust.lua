return {
	{
    "mrcjkb/rustaceanvim",
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = { cargo = { allFeatures = true }, checkOnSave = true },
          },
        },
      }
    end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {},
	},
  }
