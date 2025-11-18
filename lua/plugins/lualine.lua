return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        local function lsp_clients()
            local clients = vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }
            if #clients == 0 then return "" end
            local seen, names = {}, {}
            for _, c in ipairs(clients) do
                if not seen[c.name] then
                    seen[c.name] = true
                    table.insert(names, c.name)
                end
            end
            return " " .. table.concat(names, ", ")
        end
        vim.opt.laststatus = 3
        require("lualine").setup {
            options = {
                globalstatus = true,
                theme = "auto",
                disabled_filetypes = { statusline = {}, winbar = {} },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = { "filename" },
                lualine_x = { lsp_clients, "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            extensions = { "neo-tree" },
        }
    end,
}
