return {
	{ "Mofiqul/vscode.nvim" },
	{ "tpope/vim-fugitive",    lazy = false },
	{ "j-hui/fidget.nvim",     event = "LspAttach", opts = {} },
	{
		"nvim-mini/mini.move",
		version = "*",
		config = function()
			require("mini.move").setup()
		end,
	},
	{
		"nvim-mini/mini.pairs",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	},
}
