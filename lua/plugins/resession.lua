return {
    'stevearc/resession.nvim',
    lazy = false,
    config = function()
        local resession = require('resession')
        resession.setup({})
        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                local save = require("resession").save
                -- Always save a special session named "last"
                save("last")
                -- Save directory session
                save(vim.fn.getcwd(), { dir = "dirsession" })
            end,
        })
    end,
}
