return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        "antosha417/nvim-lsp-file-operations",
    },
    lazy = false,
    config = function()
        require("neo-tree").setup {
            close_if_last_window = true,
            enable_git_status = true,
            git_status_async = false,
            filesystem = {
                follow_current_file = { enabled = true, leave_dirs_open = true },
                use_libuv_file_watcher = true,
            },
        }

        -- Refresh when any terminal closes (catches lazygit via Snacks)
        vim.api.nvim_create_autocmd("BufLeave", {
            pattern = "*lazygit*",
            callback = function()
                -- Add delay to ensure git finishes writing index
                vim.defer_fn(function()
                    local events = require "neo-tree.events"
                    events.fire_event(events.GIT_EVENT)
                end, 100)
            end,
        })
    end,
}
