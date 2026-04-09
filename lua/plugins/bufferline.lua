return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup {
            options = {
                diagnostics = "nvim_lsp",
                separator_style = "slant",
                offsets = {
                    { filetype = "snacks_layout_box", text = "File Explorer", highlight = "Directory", separator = true },
                },
                always_show_bufferline = true,
            },
        }
    end,
}
