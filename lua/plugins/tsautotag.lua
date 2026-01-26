return {
   {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = false,
                    enable_rename = true,
                    enable_close_on_slash = false
                },
            })
        end,
    },
	{
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,  -- habilita integração com treesitter
                fast_wrap = {},   -- permite "wrap" rápido de expressões
            })
        end,
    },
}
