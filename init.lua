vim.cmd([[set noswapfile]])

vim.opt.winborder = "rounded"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.number = true

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/chentoast/marks.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/aznhe21/actions-preview.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",        version = "main" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim",          version = "0.1.8" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/LinArcX/telescope-env.nvim" },
	{ src = "https://github.com/saecki/crates.nvim",                     tag = 'stable' },
	{
		src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
		version = vim.version.range('3')
	},
	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	-- optional, but recommended
	"https://github.com/nvim-tree/nvim-web-devicons",
	{ src = "https://github.com/Mofiqul/vscode.nvim" },
	{ src = "https://github.com/mrcjkb/rustaceanvim", ft = "rust" },
})

require("crates").setup()
--require("rustaceanvim").setup()

require("marks").setup({
	builtin_marks = { "<", ">", "^" },
	refresh_interval = 250,
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	excluded_filetypes = {},
	excluded_buftypes = {},
	mappings = {},
})

local default_color = "vague"

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
	"rust_analyzer",
})

require("vague").setup({ transparent = true })
require("luasnip").setup({ enable_autosnippets = true })

local ls = require("luasnip")
local builtin = require("telescope.builtin")
local map = vim.keymap.set

vim.g.mapleader = " "

vim.cmd([[
	noremap! <c-r><c-d> <c-r>=strftime('%F')<cr>
	noremap! <c-r><c-t> <c-r>=strftime('%T')<cr>
	noremap! <c-r><c-f> <c-r>=expand('%:t')<cr>
	noremap! <c-r><c-p> <c-r>=expand('%:p')<cr>
	xnoremap <expr> . "<esc><cmd>'<,'>normal! ".v:count1.'.<cr>'
]])

map({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format current buffer" })
map({ "v", "x", "n" }, "<C-y>", '"+y', { desc = "System clipboard yank." })

function git_files()
	builtin.find_files({ no_ignore = true })
end

map({ "n" }, "L", "<cmd>bn<cr>", { desc = "Next Buffer" })
map({ "n" }, "H", "<cmd>bp<cr>", { desc = "Previous Buffer" })

map({ "n" }, "<leader>fw", builtin.live_grep)
map({ "n" }, "<leader>fg", git_files)
map({ "n" }, "<leader>fb", builtin.buffers)
map({ "n" }, "<leader>fi", builtin.grep_string)
map({ "n" }, "<leader>fo", builtin.oldfiles)
map({ "n" }, "<leader>fh", builtin.help_tags)
map({ "n" }, "<leader>fm", builtin.man_pages)
map({ "n" }, "<leader>fr", builtin.lsp_references)
map({ "n" }, "<leader>fd", builtin.diagnostics)
map({ "n" }, "<leader>fi", builtin.lsp_implementations)
map({ "n" }, "<leader>fT", builtin.lsp_type_definitions)
map({ "n" }, "<leader>fs", builtin.current_buffer_fuzzy_find)
map({ "n" }, "<leader>ft", builtin.builtin)
map({ "n" }, "<leader>fc", builtin.git_bcommits)
map({ "n" }, "<leader>fk", builtin.keymaps)
map({ "n" }, "<leader>se", "<cmd>Telescope env<cr>")
map({ "n" }, "<leader>sa", require("actions-preview").code_actions)
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })
map({ "n", 'i', 'v' }, "<C-s>", "<esc>:w<CR>", { silent = true })
map({ "n" }, "<leader>e", "<Cmd>:Neotree toggle<CR>", { desc = "Toggle Neotree" })
map({ "n" }, "<leader>o", "<Cmd>:Neotree focus<CR>", { desc = "Focus Neotree" })

-- rust
function expand_macro()
	vim.cmd.rust_analyzer("expandMacro")
end

map({ "n" }, "<Leader>rm", expand_macro, { desc = "Expand Macro" })

vim.cmd("colorscheme vscode")
