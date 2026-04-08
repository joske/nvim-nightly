require "opts"
require "config.lazy"
require "mappings"

vim.lsp.enable { "lua_ls", "bashls", "yamlls", "tombi", "texlab", "jsonls" }

vim.cmd "colorscheme vscode"

if vim.g.neovide then
  vim.o.guifont = "UbuntuMono Nerd Font:h12"
  vim.o.linespace = 0
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
  vim.g.neovide_progress_bar_enabled = true
  vim.g.neovide_progress_bar_height = 5.0
  vim.g.neovide_progress_bar_animation_speed = 200.0
  vim.g.neovide_progress_bar_hide_delay = 0.2
  vim.g.neovide_cursor_short_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0.0
end
