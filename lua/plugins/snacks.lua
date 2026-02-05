return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	init = function()
		vim.api.nvim_create_autocmd("QuitPre", {
			callback = function()
				local wins = vim.api.nvim_list_wins()
				local explorer_wins = {}
				for _, win in ipairs(wins) do
					local buf = vim.api.nvim_win_get_buf(win)
					local ft = vim.bo[buf].filetype
					if ft:match("^snacks") then
						table.insert(explorer_wins, win)
					end
				end
				-- If quitting would leave only snacks windows, close them too
				if #wins - 1 == #explorer_wins then
					for _, win in ipairs(explorer_wins) do
						pcall(vim.api.nvim_win_close, win, true)
					end
				end
			end,
		})
		vim.ui.select = function(...)
			return require("snacks").picker.select(...)
		end
		vim.ui.input = function(...)
			return require("snacks").input(...)
		end
	end,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		dim = { enabled = true },
		explorer = { enabled = true },
		git = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 1000,
		},
		picker = { enabled = true },
		quickfile = { enabled = false },
		scope = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		terminal = {
			enabled = true,
			win = {
				position = "float",
			},
		},
		words = { enabled = true },
		styles = {
			notification = {
				wo = { wrap = true }, -- Wrap notifications
			},
		},
	},
}
