local opts = { noremap = true }

local function no_border_telescope(picker_path)
  return function()
    require('telescope.builtin')[picker_path]({
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      winblend = 15,
    })
  end
end

keymap = vim.api.nvim_set_keymap

-- Set leader key
vim.g.mapleader=" "

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Center after certain commands
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Delete and paste without modifying the "deleted" register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Keep the cursor when append lines with J
keymap("n", "J", "mzJ`z", opts)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copiar seleção para clipboard" })
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = "Copiar até o fim da linha para clipboard" })
vim.keymap.set("n", "<leader>y", '"+yy', { desc = "Copiar linha atual para clipboard" })

-- Colar do clipboard
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Colar depois do cursor do clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Colar antes do cursor do clipboard" })


vim.keymap.set("n", "<leader>b", no_border_telescope("buffers"))
vim.keymap.set("n", "<leader>f", no_border_telescope("find_files"))
vim.keymap.set("n", "<leader>f", no_border_telescope("find_files"))
vim.keymap.set("n", "<leader>s", no_border_telescope("live_grep"))
vim.keymap.set("n", "<leader>g", no_border_telescope("git_status"))

vim.keymap.set("n", "<leader>l", "<cmd>Floaterminal<CR>")

vim.keymap.set("n", "]q", "<cmd>cnext<CR>")
vim.keymap.set("n", "[q", "<cmd>cprevious<CR>")

vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Formatar com Biome" })

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>")
