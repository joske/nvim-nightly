local map = vim.keymap.set

vim.g.mapleader = " "

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
 Snacks.picker({
  title = "Environment Variables",
  items = items,
  format = "text",
  confirm = function(picker, item)
   if not item then return end
   picker:close()
   vim.fn.setreg("+", item.env_value)
   Snacks.notify(("Copied %s to clipboard"):format(item.name))
  end,
 })
end

local function git_files()
 Snacks.picker.files({ ignored = false })
end

local function todo_picker()
 local search = require("todo-comments.search")
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
  Snacks.picker({
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
  })
 end, { disable_not_found_warnings = true })
end

local function smart_quit()
 local function is_disposable(win)
  local cfg = vim.api.nvim_win_get_config(win)
  if cfg.relative ~= "" then return true end
  local buf = vim.api.nvim_win_get_buf(win)
  local ft = vim.bo[buf].filetype
  if ft == "neo-tree" then return true end
  if vim.bo[buf].buftype ~= "" then return true end
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" and not vim.bo[buf].modified then return true end
  return false
 end

 for _, win in ipairs(vim.api.nvim_list_wins()) do
  if not is_disposable(win) then
   vim.cmd("quit")
   return
  end
 end

 vim.cmd("qa")
end

local function toggle_inlay_hints()
 if not vim.lsp.inlay_hint then
        vim.notify("Inlay hints not supported", vim.log.levels.WARN)
        return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    if type(vim.lsp.inlay_hint) == "table" and vim.lsp.inlay_hint.enable then
        local enabled = true
        if vim.lsp.inlay_hint.is_enabled then enabled = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr } end
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
        pcall(vim.api.nvim_buf_set_var, bufnr, "inlay_hints_enabled", not enabled)
    else
        local ok, value = pcall(vim.api.nvim_buf_get_var, bufnr, "inlay_hints_enabled")
        local enabled
        if ok then
            enabled = value == nil and true or value
        else
            enabled = true
        end
        local next_state = not enabled
        vim.lsp.inlay_hint(bufnr, next_state)
        vim.b.inlay_hints_enabled = next_state
    end
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
map({ "n" }, "<leader>q", smart_quit, { desc = "Quit the current buffer." })
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

-- texlab
map({ "n" }, "<leader>mt", "<cmd>LspTexlabBuild<CR>", { desc = "Build LaTeX Document" })

-- save
map({ "n", "i", "v" }, "<C-s>", "<esc><cmd>w<CR>", { silent = true })

-- term
map({ "n", "t" }, "<F7>", "<cmd>ToggleTerm<CR>", { desc = "Open Terminal" })
