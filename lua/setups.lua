require("crates").setup({})
require("marks").setup({
	builtin_marks = { "<", ">", "^" },
	refresh_interval = 250,
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	excluded_filetypes = {},
	excluded_buftypes = {},
	mappings = {},
})

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
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
			n = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
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

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "rust", "bash", "toml", "json", "yaml", "markdown" },
	highlight = {
		enable = true,
	},
})

local function lsp_clients()
	local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
	if next(buf_clients) == nil then
		return ""
	end
	local names = {}
	for _, client in pairs(buf_clients) do
		table.insert(names, client.name)
	end
	return " " .. table.concat(names, ", ")
end
-- one statusline across the whole UI
vim.opt.laststatus = 3

require("lualine").setup({
	options = {
		globalstatus = true, -- lualine mirrors laststatus=3
		theme = "auto",
		-- make sure neo-tree isn't disabled here:
		disabled_filetypes = { statusline = {}, winbar = {} },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = { lsp_clients, "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	-- optional: lualine knows how to play nice with neo-tree
	extensions = { "neo-tree" },
})

require("fidget").setup()
require("toggleterm").setup()
require("trouble").setup()
