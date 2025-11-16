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

local function git_files()
	builtin.find_files({ no_ignore = true })
end

-- navigation
map({ "n" }, "L", "<cmd>bn<cr>", { desc = "Next Buffer" })
map({ "n" }, "H", "<cmd>bp<cr>", { desc = "Previous Buffer" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to upper window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to lower window" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize split left" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize split right" })

-- telescope
map({ "n" }, "<leader>f", "", { desc = "Find" })
map({ "n" }, "<leader>fa", require("actions-preview").code_actions)
map({ "n" }, "<leader>fB", function()
	Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })
map({ "n" }, "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Find Buffer" })
map({ "n" }, "<leader>fc", builtin.git_bcommits)
map({ "n" }, "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
map({ "n" }, "<leader>fe", "<cmd>Telescope env<cr>")
map({ "n" }, "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Files" })
map({ "n" }, "<leader>fd", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
map({ "n" }, "<leader>fg", git_files, { desc = "Git Files" })
map({ "n" }, "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
map({ "n" }, "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
map({ "n" }, "<leader>fm", builtin.man_pages, { desc = "Man Pages" })
map({ "n" }, "<leader>fo", builtin.oldfiles, { desc = "Old Files" })
map({ "n" }, "<leader>fr", builtin.lsp_references, { desc = "LSP References" })
map({ "n" }, "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy Find" })
map({ "n" }, "<leader>ft", builtin.builtin)
map({ "n" }, "<leader>fT", builtin.lsp_type_definitions, { desc = "LSP Type Definitions" })
map({ "n" }, "<leader>fw", function()
	Snacks.picker.grep()
end, { desc = "Live Grep" })

-- quit
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })

-- neotree
map({ "n" }, "<leader>e", "<Cmd>:Neotree toggle<CR>", { desc = "Toggle Neotree" })
map({ "n" }, "<leader>o", "<Cmd>:Neotree focus<CR>", { desc = "Focus Neotree" })

-- rust
map({ "n" }, "<Leader>r", "", { desc = "Rust" })
map({ "n" }, "<Leader>ra", "<cmd>RustLsp codeAction<CR>", { desc = "Code Action" })
map({ "n" }, "<Leader>rC", "<cmd>RustLsp openCargo<CR>", { desc = "Open Cargo.toml" })
map({ "n" }, "<Leader>rm", "<cmd>RustLsp expandMacro<CR>", { desc = "Expand Macro" })

-- git
map("n", "<leader>g", "", { desc = "Git" })
map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "LazyGit" })

map("n", "<leader>n", function()
	Snacks.picker.notifications()
end, { desc = "Notification History" })

-- LSP
map({ "n" }, "<Leader>l", "", { desc = "LSP" })
map({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format, { desc = "LSP Format" })
map({ "n" }, "<Leader>lr", vim.lsp.buf.rename, { desc = "LSP Rename" })

map({ "n" }, "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "LSP Definition" })
map({ "n" }, "gi", function()
	Snacks.picker.lsp_implementations()
end, { desc = "LSP Implementations" })
map({ "n" }, "gr", function()
	Snacks.picker.lsp_references()
end, { desc = "LSP References" })

-- save
map({ "n", "i", "v" }, "<C-s>", "<esc>:w<CR>", { silent = true })

-- term
map({ "n", "t" }, "<F7>", "<cmd>ToggleTerm<CR>", { desc = "Open Terminal" })
