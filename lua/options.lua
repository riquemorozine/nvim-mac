local options = {
  termguicolors=true,

  tabstop=4,
  shiftwidth=4,
  softtabstop=4,
  expandtab=true,

  number=true,
  relativenumber=true,

  laststatus=1,
  showtabline=2,

  cursorline=true,

  signcolumn="yes",

  path=".,**",

  list=false,

  guicursor="",

  wrap=false,

  swapfile=false,
  backup=false,

  smartindent=true,

  hlsearch=false,
  incsearch=true,

  undodir=os.getenv("HOME") .. "/.vim/undodir",
  undofile=true,

  scrolloff = 8,

  -- Clipboard support - use system clipboard
  clipboard = "unnamedplus",
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

-- vim.g.copilot_no_tab_map = false
-- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
