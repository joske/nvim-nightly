return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
	"antosha417/nvim-lsp-file-operations"
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
  },
  lazy = false,
  config = function()
    require("neo-tree").setup({})

    local function should_quit_on_neo_tree()
      local normal_wins = 0
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local cfg = vim.api.nvim_win_get_config(win)
        if cfg.relative == "" then
          normal_wins = normal_wins + 1
        end
      end
      if normal_wins ~= 1 then
        return false
      end
      local buf = vim.api.nvim_get_current_buf()
      return vim.bo[buf].filetype == "neo-tree"
    end

    local group = vim.api.nvim_create_augroup("NeoTreeAutoQuit", { clear = true })
    vim.api.nvim_create_autocmd("BufEnter", {
      group = group,
      callback = function()
        if should_quit_on_neo_tree() then
          vim.cmd("quit")
        end
      end,
    })
  end,
}
