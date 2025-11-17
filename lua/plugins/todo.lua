return {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	event = "VeryLazy",
	opts = {
		-- your options
	},
	config = function(_, opts)
		require("todo-comments").setup(opts)
		-- load the Telescope extension safely
		pcall(function()
			require("telescope").load_extension("todo-comments")
		end)
	end,
}
