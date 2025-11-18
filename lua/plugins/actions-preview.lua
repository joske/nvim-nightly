return {
	"aznhe21/actions-preview.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		backend = { "snacks" },
		snacks = {
			layout = { preset = "dropdown" },
		},
	},
}
