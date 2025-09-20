-- Highlight yanked text for a couple of milleseconds
vim.cmd [[
  augroup user_yank_highlight
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
  augroup end
]]

-- Enable cursorline for current buffer only

-- vim.cmd [[
--  augroup user_cursorline
--    au!
--    au BufEnter * silent! set cursorline
--    au BufLeave * silent! set nocursorline
--  augroup end
-- ]]

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    au!
    au BufWritePost plugins.lua source <afile> | Lazy
  augroup end
]]

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    au!
    au TermOpen * :set nonumber | set norelativenumber | set showtabline=1 | norm i
    au TermClose * :set number | set relativenumber | set showtabline=2
  augroup end
]]

-- Autocommand that adds highlights to trailing whitespaces after colorscheme changed
-- And also makes background transparent
vim.cmd [[
  augroup highlight_colorscheme
    au!
    au ColorScheme * silent! execute matchadd("ErrorMsg", "\\s\\+$")
    au ColorScheme * silent! execute "hi Normal guibg=NONE ctermbg=NONE"
    au ColorScheme * silent! execute "hi NormalNC guibg=NONE ctermbg=NONE"
    au ColorScheme * silent! execute "hi TabLineFill guibg=NONE ctermbg=NONE"
    au ColorScheme * silent! execute "hi TabLine guibg=NONE ctermbg=NONE"
    au ColorScheme * silent! execute "hi TabLineSel guibg=NONE ctermbg=NONE"
    au ColorScheme * silent! execute "hi NotifyBackground guibg=NONE ctermbg=NONE"
    au ColorScheme * silent! execute "hi clear NotifyINFOBorder guibg=NONE ctermbg=NONE"
  augroup end
]]

local timer = nil

local function enable_hlsearch_with_timer()
  vim.opt.hlsearch = true

  if timer then
    timer:stop()
    timer:close()
  end

  timer = vim.loop.new_timer()
  timer:start(1000, 0, function()
    vim.schedule(function()
      vim.opt.hlsearch = false
    end)
  end)
end

for _, key in ipairs({ "*", "#", "g*", "g#", "n", "N" }) do
  vim.keymap.set("n", key, function()
    vim.cmd("normal! " .. key)
    enable_hlsearch_with_timer()
  end, { noremap = true, silent = true })
end

vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = { "/", "?" },
  callback = function()
    enable_hlsearch_with_timer()
  end,
})

-- Automatically reload init.lua when saved
local reload_group = vim.api.nvim_create_augroup("ReloadInit", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = reload_group,
  pattern = "init.lua",
  callback = function()
    vim.cmd("source %")
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.json" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
