return {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	opts = {
		-- your options
	},
	config = function(_, opts) require("todo-comments").setup(opts) end,
}
