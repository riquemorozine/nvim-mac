return {
  {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "mistricky/codesnap.nvim", tag = "v2.0.0-beta.17" },
    {
        "stevearc/overseer.nvim",
        config = true
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    { "tpope/vim-commentary" },

    {
        "jwalton512/vim-blade",
        ft = "blade"
    },
    {
        "pantharshit00/vim-prisma", -- ✅ highlight extra para .prisma
    },
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'mbbill/undotree',
    'folke/zen-mode.nvim',
     {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
            }
        end
    }, 
}
