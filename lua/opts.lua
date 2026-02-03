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
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.writebackup = false
vim.opt.showmode = true
vim.opt.mouse = "a"
vim.opt.clipboard:append { "unnamed", "unnamedplus" }

-- Configure diagnostic display
vim.diagnostic.config {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
}

vim.cmd [[set completeopt+=fuzzy,noinsert]]

local format_grp = vim.api.nvim_create_augroup("AutoFormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_grp,
    callback = function(args)
        -- Skip if no attached LSP client supports formatting
        local clients = vim.lsp.get_active_clients { bufnr = args.buf }
        for _, client in ipairs(clients) do
            if client.supports_method "textDocument/formatting" then
                vim.lsp.buf.format { bufnr = args.buf, async = false }
                break
            end
        end
    end,
})

if vim.lsp.inlay_hint then
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspInlayHints", { clear = true }),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
        end,
    })
end
