vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")

local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.window or math.floor(vim.o.columns * 0.92)
    local height = opts.height or math.floor(vim.o.lines * 0.92)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = nil

    if vim.api.nvim_buf_is_valid(state.floating.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = {
            { ' ', 'FloatBorder' },
            { ' ', 'FloatBorder' },
            { ' ', 'FloatBorder' },
            { ' ', 'FloatBorder' },
            { ' ', 'FloatBorder' },
            { ' ', 'FloatBorder' },
            { ' ', 'FloatBorder' },
            { ' ', 'FloatBorder' }
        }
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

vim.api.nvim_create_user_command("Floaterminal", function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then

        vim.opt_local.cursorline = false

        state.floating = create_floating_window({ buf = state.floating.buf })
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.term()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
        vim.opt_local.cursorline = true
    end
end, {})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

vim.api.nvim_create_autocmd("TermEnter", {
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

vim.api.nvim_create_autocmd("TermLeave", {
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
