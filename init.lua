require "floaterminal"
require "enable-lsp"
require "autocmds"
require "options"
require "remap"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

require ('telescope').setup   {
    defaults = {
        file_ignore_patterns = { "node_modules", ".git", "vendor" },
    },
    border = false,
    winblend = 50
}

require "colorscheme"
require "textobjects"
require "git"


