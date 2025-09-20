require "remap"
require "options"
require "autocmds"
require "plugins"
require "git"
require "textobjects"
require "colorscheme"

require('telescope').setup {
    defaults = {
        file_ignore_patterns = { "node_modules", ".git", "vendor" },
    },
    border = false,
    winblend = 50,
}

-- Load custom config file if it exists in the current working directory
-- Useful for project-specific configurations
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local config = vim.fn.getcwd() .. "/.nvim.lua"
    if vim.fn.filereadable(config) == 1 then
      dofile(config)
    end
  end,
})
