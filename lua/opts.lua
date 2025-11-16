vim.opt.winborder = "rounded"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.number = true
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
-- Remap 0 to go to first non-blank character
vim.cmd([[nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\\S')+1 ? '0' : '^']])
