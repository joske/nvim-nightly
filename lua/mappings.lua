local map = vim.keymap.set

-- Remap 0 to go to first non-blank character
vim.keymap.set("n", "0", function()
    local col = vim.fn.col "."
    local first_non_blank = vim.fn.match(vim.fn.getline ".", "\\S") + 1
    if col == first_non_blank then
        return "0"
    else
        return "^"
    end
end, { expr = true, silent = true, desc = "Toggle between first column and first non-blank" })

vim.cmd [[
	noremap! <c-r><c-d> <c-r>=strftime('%F')<cr>
	noremap! <c-r><c-t> <c-r>=strftime('%T')<cr>
	noremap! <c-r><c-f> <c-r>=expand('%:t')<cr>
	noremap! <c-r><c-p> <c-r>=expand('%:p')<cr>
	xnoremap <expr> . "<esc><cmd>'<,'>normal! ".v:count1.'.<cr>'
]]

local function toggle_inlay_hints()
    if not vim.lsp.inlay_hint then
        vim.notify("Inlay hints not supported", vim.log.levels.WARN)
        return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
end

local function env_picker()
    local env = vim.fn.environ()
    local items = {}
    for name, value in pairs(env) do
        items[#items + 1] = {
            text = string.format("%s=%s", name, value),
            name = name,
            env_value = value,
        }
    end
    table.sort(items, function(a, b) return a.name < b.name end)
    Snacks.picker {
        title = "Environment Variables",
        items = items,
        format = "text",
        confirm = function(picker, item)
            if not item then return end
            picker:close()
            vim.fn.setreg("+", item.env_value)
            Snacks.notify(("Copied %s to clipboard"):format(item.name))
        end,
    }
end

-- navigation
map({ "n" }, "L", "<cmd>bn<cr>", { desc = "Next Buffer" })
map({ "n" }, "H", "<cmd>bp<cr>", { desc = "Previous Buffer" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-Down>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-Up>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize split left" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize split right" })
map("n", "<leader>c", "<cmd>bp | sp | bn | bd<CR>", { desc = "Close current buffer" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ui
map("n", "<leader>u", "", { desc = "UI" })
map("n", "<leader>uh", toggle_inlay_hints, { desc = "Toggle Inlay Hints" })

-- pickers
map({ "n" }, "<leader>f", "", { desc = "Find" })
map({ "n" }, "<leader>fB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
map({ "n" }, "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Find Buffer" })
map({ "n" }, "<leader>fc", function() Snacks.picker.git_log_file() end, { desc = "File Commits" })
map({ "n" }, "<leader>fd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
map({ "n" }, "<leader>fe", env_picker, { desc = "Environment Variables" })
map({ "n" }, "<leader>ff", function() Snacks.picker.files() end, { desc = "Files" })
map({ "n" }, "<leader>fg", function() Snacks.picker.files { ignored = false } end, { desc = "Project Files (All)" })
map({ "n" }, "<leader>fh", function() Snacks.picker.help() end, { desc = "Help Tags" })
map({ "n" }, "<leader>fk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map({ "n" }, "<leader>fm", function() Snacks.picker.man() end, { desc = "Man Pages" })
map({ "n" }, "<leader>fo", function() Snacks.picker.recent() end, { desc = "Recent Files" })
map({ "n" }, "<leader>fr", function() Snacks.picker.lsp_references() end, { desc = "LSP References" })
map({ "n" }, "<leader>fs", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
map({ "n" }, "<leader>ft", function() Snacks.picker.pickers() end, { desc = "Snacks Pickers" })
map({ "n" }, "<leader>fT", function() Snacks.picker.lsp_type_definitions() end, { desc = "LSP Type Definitions" })
map({ "n" }, "<leader>fw", function() Snacks.picker.grep() end, { desc = "Live Grep" })

-- quit
map({ "n" }, "<leader>q", "<cmd>:qa<CR>", { desc = "Quit NeoVim." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Write and Quit" })

-- explorer
map({ "n" }, "<leader>e", function() Snacks.explorer() end, { desc = "Toggle Explorer" })
map({ "n" }, "<leader>o", function()
    local explorers = Snacks.picker.get({ source = "explorer" })
    if #explorers > 0 then
        explorers[1]:focus()
    else
        Snacks.explorer()
    end
end, { desc = "Focus Explorer" })

-- packages
map({ "n" }, "<leader>p", "", { desc = "Packages" })
map({ "n" }, "<leader>pa", "<cmd>Lazy update<CR>", { desc = "Update" })
map({ "n" }, "<leader>pm", "<cmd>Mason<CR>", { desc = "Mason" })

-- markdown
map({ "n" }, "<Leader>gm", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown Preview" })

-- git
map("n", "<leader>g", "", { desc = "Git" })
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "LazyGit" })
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git Blame" })
map("n", "<leader>gB", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
map("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
map("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
map("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub Pull Requests (open)" })
map("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "GitHub Pull Requests (all)" })

-- notifications
map("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
map({ "n" }, "<leader>nh", function() Snacks.notifier.show_history() end, { desc = "Show Notification History" })

-- trouble
map({ "n" }, "<leader>x", "", { desc = "Trouble" })
map({ "n" }, "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
map({ "n" }, "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Document Diagnostics" })
map({ "n" }, "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List" })
map({ "n" }, "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix" })
map({ "n" }, "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP References" })

-- todo
map({ "n" }, "<leader>T", "", { desc = "TODOs" })
map({ "n" }, "<leader>Tt", function() Snacks.picker.todo_comments() end, { desc = "TODO Picker" })
map({ "n" }, "<leader>Tx", "<cmd>TodoTrouble<CR>", { desc = "TODO Trouble" })
map({ "n" }, "<leader>Tq", "<cmd>TodoQuickFix<CR>", { desc = "TODO QuickFix" })

-- LSP
map({ "n" }, "<Leader>l", "", { desc = "LSP" })
map({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
map({ "n", "v", "x" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
map({ "n" }, "<Leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
map({ "n" }, "<Leader>lc", "", { desc = "Calls" })
map({ "n" }, "<Leader>lci", function() vim.lsp.buf.incoming_calls() end, { desc = "Incoming Calls" })
map({ "n" }, "<Leader>lco", function() vim.lsp.buf.outgoing_calls() end, { desc = "Outgoing Calls" })
map({ "n" }, "<leader>lS", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })
map({ "n" }, "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Definition" })
map({ "n" }, "gi", function() Snacks.picker.lsp_implementations() end, { desc = "Implementations" })
map({ "n" }, "gr", function() Snacks.picker.lsp_references() end, { desc = "References" })

-- Build
map({ "n" }, "<leader>b", "", { desc = "Build" })

-- save
map({ "n", "i", "v" }, "<C-s>", "<esc><cmd>w<CR>", { silent = true })

-- term
map({ "n", "t" }, "<F7>", function() Snacks.terminal() end, { desc = "Open Terminal" })

-- session
map({ "n" }, "<leader>S", "", { desc = "Session" })
map({ "n" }, "<leader>Ss", function() require("resession").save() end, { desc = "Save Session" })
map({ "n" }, "<leader>Sl", function() require("resession").load(nil, { reset = false }) end, { desc = "Load Session" })
map({ "n" }, "<leader>S.",
    function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession", reset = false }) end,
    { desc = "Load Dir Session" })
