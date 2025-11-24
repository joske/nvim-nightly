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

local function git_files() Snacks.picker.files { ignored = false } end

local function todo_picker()
    local search = require "todo-comments.search"
    search.search(function(results)
        if not results or vim.tbl_isempty(results) then
            Snacks.notify("No TODOs found", vim.log.levels.INFO)
            return
        end
        local items = {}
        for _, item in ipairs(results) do
            items[#items + 1] = {
                text = item.text or item.line,
                file = item.filename,
                lnum = item.lnum,
                col = item.col,
                value = item,
            }
        end
        Snacks.picker {
            title = "TODOs",
            items = items,
            format = "file",
            confirm = function(picker, selection)
                if not selection then return end
                picker:close()
                vim.schedule(function()
                    vim.cmd(("edit %s"):format(vim.fn.fnameescape(selection.value.filename)))
                    vim.api.nvim_win_set_cursor(0, { selection.value.lnum, math.max(selection.value.col - 1, 0) })
                end)
            end,
        }
    end, { disable_not_found_warnings = true })
end

local function toggle_inlay_hints()
    if not vim.lsp.inlay_hint then
        vim.notify("Inlay hints not supported", vim.log.levels.WARN)
        return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
end

local function rust_codelens_run()
    if not vim.lsp.codelens then
        vim.notify("CodeLens not supported", vim.log.levels.WARN)
        return
    end
    vim.lsp.codelens.run()
end

local function rust_codelens_refresh()
    if not vim.lsp.codelens then return end
    vim.lsp.codelens.refresh()
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
map("n", "<leader>c", "<cmd>bp | sp | bn | bd<CR>", { desc = "Close current buffer" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ui
map("n", "<leader>u", "", { desc = "UI" })
map("n", "<leader>uh", toggle_inlay_hints, { desc = "Toggle Inlay Hints" })

-- pickers
map({ "n" }, "<leader>f", "", { desc = "Find" })
map({ "n" }, "<leader>fa", require("actions-preview").code_actions)
map({ "n" }, "<leader>fB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
map({ "n" }, "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Find Buffer" })
map({ "n" }, "<leader>fc", function() Snacks.picker.git_log_file() end, { desc = "File Commits" })
map({ "n" }, "<leader>fd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
map({ "n" }, "<leader>fe", env_picker, { desc = "Environment Variables" })
map({ "n" }, "<leader>ff", function() Snacks.picker.files() end, { desc = "Files" })
map({ "n" }, "<leader>fg", git_files, { desc = "Project Files (All)" })
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
map({ "n" }, "<leader>q", "<cmd>:q<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })

-- neotree
map({ "n" }, "<leader>e", "<Cmd>:Neotree toggle<CR>", { desc = "Toggle Neotree" })
map({ "n" }, "<leader>o", "<Cmd>:Neotree focus<CR>", { desc = "Focus Neotree" })

-- markdown
map({ "n" }, "<Leader>gm", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown Preview" })

-- rust
map({ "n" }, "<Leader>r", "", { desc = "Rust" })
map({ "n" }, "<Leader>ra", "<cmd>RustLsp codeAction<CR>", { desc = "Code Action" })
map({ "n" }, "<Leader>rC", "<cmd>RustLsp openCargo<CR>", { desc = "Open Cargo.toml" })
map({ "n" }, "<Leader>rd", "<cmd>RustLsp debuggables<CR>", { desc = "Debug" })
map({ "n" }, "<Leader>rm", "<cmd>RustLsp expandMacro<CR>", { desc = "Expand Macro" })
map({ "n" }, "<Leader>rr", rust_codelens_run, { desc = "Run Rust test (CodeLens)" })
map({ "n" }, "<Leader>rR", rust_codelens_refresh, { desc = "Refresh Rust CodeLens" })

-- packages
map({ "n" }, "<leader>p", "", { desc = "Packages" })
map({ "n" }, "<leader>pa", "<cmd>Lazy update<CR>", { desc = "Update" })
map({ "n" }, "<leader>pm", "<cmd>Mason<CR>", { desc = "Mason" })

-- git
map("n", "<leader>g", "", { desc = "Git" })
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "LazyGit" })
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git Blame" })

-- notifications
map("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })

-- LSP
map({ "n" }, "<Leader>l", "", { desc = "LSP" })
map({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
map({ "n", "v", "x" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
map({ "n" }, "<Leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
map({ "n" }, "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Definition" })
map({ "n" }, "gi", function() Snacks.picker.lsp_implementations() end, { desc = "Implementations" })
map({ "n" }, "gr", function() Snacks.picker.lsp_references() end, { desc = "References" })

-- todo
map({ "n" }, "<leader>T", "", { desc = "TODOs" })
map({ "n" }, "<leader>Tt", todo_picker, { desc = "TODO Picker" })
map({ "n" }, "<leader>Tx", "<cmd>TodoTrouble<CR>", { desc = "TODO Trouble" })
map({ "n" }, "<leader>Tq", "<cmd>TodoQuickFix<CR>", { desc = "TODO QuickFix" })

-- Build
map({ "n" }, "<leader>b", "", { desc = "Build" })
map({ "n" }, "<leader>bt", "<cmd>LspTexlabBuild<CR>", { desc = "Build LaTeX Document" })
map({ "n" }, "<leader>bc", "<cmd>!cargo build<CR>", { desc = "Cargo Build" })

-- save
map({ "n", "i", "v" }, "<C-s>", "<esc><cmd>w<CR>", { silent = true })

-- term
map({ "n", "t" }, "<F7>", "<cmd>ToggleTerm<CR>", { desc = "Open Terminal" })

-- debug (DAP)
map({ "n" }, "<leader>d", "", { desc = "Debug" })
map({ "n" }, "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map({ "n" }, "<leader>dB", function()
    require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "Conditional Breakpoint" })
map({ "n" }, "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
map({ "n" }, "<leader>dC", function() require("dap").run_to_cursor() end, { desc = "Run to Cursor" })
map({ "n" }, "<leader>dg", function() require("dap").goto_() end, { desc = "Go to Line (No Execute)" })
map({ "n" }, "<F5>", function() require("dap").step_into() end, { desc = "Step Into" })
map({ "n" }, "<F6>", function() require("dap").step_over() end, { desc = "Step Over" })
map({ "n" }, "<F8>", function() require("dap").step_out() end, { desc = "Step Out" })
map({ "n" }, "<leader>dj", function() require("dap").down() end, { desc = "Down" })
map({ "n" }, "<leader>dk", function() require("dap").up() end, { desc = "Up" })
map({ "n" }, "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last" })
map({ "n" }, "<leader>dp", function() require("dap").pause() end, { desc = "Pause" })
map({ "n" }, "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle REPL" })
map({ "n" }, "<leader>ds", function() require("dap").session() end, { desc = "Session" })
map({ "n" }, "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate" })
map({ "n" }, "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })
map({ "n" }, "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })

-- aerial
map({ "n" }, "<leader>lS", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })

-- session
map({ "n" }, "<leader>S", "", { desc = "Session" })
map({ "n" }, "<leader>Ss", function() require("resession").save() end, { desc = "Save Session" })
map({ "n" }, "<leader>Sl", function() require("resession").load(nil, { reset = false }) end, { desc = "Load Session" })
map({ "n" }, "<leader>S.",
    function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession", reset = false }) end,
    { desc = "Load Dir Session" })
