vim.o.termguicolors = true

if vim.g.color_loaded == nil then
  vim.cmd [[ color rose-pine ]]
  vim.g.color_loaded = true
end
