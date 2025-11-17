vim.opt.winborder = "rounded"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.mouse = "a"
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
-- Remap 0 to go to first non-blank character
vim.cmd([[nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\\S')+1 ? '0' : '^']])
vim.cmd([[set completeopt+=fuzzy,noinsert]])

local format_grp = vim.api.nvim_create_augroup("AutoFormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_grp,
    callback = function(args)
        -- Skip if no attached LSP client supports formatting
        local clients = vim.lsp.get_active_clients({ bufnr = args.buf })
        for _, client in ipairs(clients) do
            if client.supports_method("textDocument/formatting") then
                vim.lsp.buf.format({ bufnr = args.buf, async = false })
                break
            end
        end
    end,
})

if vim.lsp.inlay_hint then
    local inlay_grp = vim.api.nvim_create_augroup("LspInlayHints", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = inlay_grp,
        callback = function(args)
            local client_id = args.data and args.data.client_id
            if not client_id then
                return
            end
            local client = vim.lsp.get_client_by_id(client_id)
            if client and client.server_capabilities.inlayHintProvider then
                if type(vim.lsp.inlay_hint) == "table" and vim.lsp.inlay_hint.enable then
                    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                elseif type(vim.lsp.inlay_hint) == "function" then
                    vim.lsp.inlay_hint(args.buf, true)
                end
                pcall(vim.api.nvim_buf_set_var, args.buf, "inlay_hints_enabled", true)
            end
        end,
    })
end
