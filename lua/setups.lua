require("crates").setup({})
require("marks").setup({
	builtin_marks = { "<", ">", "^" },
	refresh_interval = 250,
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	excluded_filetypes = {},
	excluded_buftypes = {},
	mappings = {},
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"bashls",
	},
	automatic_installation = true,
})

local telescope = require("telescope")
telescope.setup({
	defaults = {
		preview = { treesitter = false },
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = {
			"─", -- top
			"│", -- right
			"─", -- bottom
			"│", -- left
			"┌", -- top-left
			"┐", -- top-right
			"┘", -- bottom-right
			"└", -- bottom-left
		},
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 40,
		},
	},
})
telescope.load_extension("ui-select")

require("actions-preview").setup({
	backend = { "telescope" },
	extensions = { "env" },
	telescope = vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {}),
})

vim.cmd([[set completeopt+=menuone,noselect,popup]])

vim.lsp.enable({
	"lua_ls",
})

require("luasnip").setup({ enable_autosnippets = true })

vim.g.rustaceanvim = {
	server = {
		default_settings = {
			["rust-analyzer"] = {
				cargo = { allFeatures = true },
				checkOnSave = true,
			},
		},
	},
}

local events = require("neo-tree.events")

require("neo-tree").setup({
	event_handlers = {
		{
			event = events.NEO_TREE_BUFFER_ENTER,
			handler = function()
				if #vim.api.nvim_list_wins() == 1 then
					vim.cmd("quit")
				end
			end,
		},
	},
})

require("lualine").setup()
