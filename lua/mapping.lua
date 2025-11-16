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

local function git_files()
	builtin.find_files({ no_ignore = true })
end

map({ "n" }, "L", "<cmd>bn<cr>", { desc = "Next Buffer" })
map({ "n" }, "H", "<cmd>bp<cr>", { desc = "Previous Buffer" })

map({ "n" }, "<leader>fw", builtin.live_grep, { desc = "Live Grep" })
map({ "n" }, "<leader>ff", builtin.find_files, { desc = "Files" })
map({ "n" }, "<leader>fg", git_files, { desc = "Git Files" })
map({ "n" }, "<leader>fb", builtin.buffers, { desc = "Find Buffer" })
map({ "n" }, "<leader>fi", builtin.grep_string, { desc = "Grep String" })
map({ "n" }, "<leader>fo", builtin.oldfiles, { desc = "Old Files" })
map({ "n" }, "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
map({ "n" }, "<leader>fm", builtin.man_pages, { desc = "Man Pages" })
map({ "n" }, "<leader>fr", builtin.lsp_references, { desc = "LSP References" })
map({ "n" }, "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
map({ "n" }, "<leader>fi", builtin.lsp_implementations, { desc = "LSP Implementations" })
map({ "n" }, "<leader>fT", builtin.lsp_type_definitions, { desc = "LSP Type Definitions" })
map({ "n" }, "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy Find" })
map({ "n" }, "<leader>ft", builtin.builtin)
map({ "n" }, "<leader>fc", builtin.git_bcommits)
map({ "n" }, "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
map({ "n" }, "<leader>se", "<cmd>Telescope env<cr>")
map({ "n" }, "<leader>sa", require("actions-preview").code_actions)
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })
map({ "n", "i", "v" }, "<C-s>", "<esc>:w<CR>", { silent = true })
map({ "n" }, "<leader>e", "<Cmd>:Neotree toggle<CR>", { desc = "Toggle Neotree" })
map({ "n" }, "<leader>o", "<Cmd>:Neotree focus<CR>", { desc = "Focus Neotree" })

-- rust
map({ "n" }, "<Leader>ra", "<cmd>RustLsp codeAction<CR>", { desc = "Code Action" })
map({ "n" }, "<Leader>rm", "<cmd>RustLsp expandMacro<CR>", { desc = "Expand Macro" })
map({ "n" }, "<Leader>rC", "<cmd>RustLsp openCargo<CR>", { desc = "Open Cargo.toml" })

-- LSP
map({ "n" }, "<Leader>lr", vim.lsp.buf.rename, { desc = "LSP Rename" })
