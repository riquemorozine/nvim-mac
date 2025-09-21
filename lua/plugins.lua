

local fn = vim.fn

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

require("lazy").setup({

    'github/copilot.vim',

    'tpope/vim-dispatch',

    "lewis6991/gitsigns.nvim",

    {
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup({
                stages = "fade_in_slide_out",
                timeout = 1000,
                max_width = 80,
                max_height = 10,
                background_colour = "#000000",
            })
            vim.notify = require("notify")
        end
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

    {
        "axelvc/template-string.nvim",
        config = function()
            require("template-string").setup({
                filetypes = {
                    "html",
                    "typescript",
                    "javascript",
                    "typescriptreact",
                    "javascriptreact",
                    "vue",
                    "svelte",
                    "python",
                    "cs",
                }, -- filetypes where the plugin is active
                jsx_brackets = true, -- must add brackets to JSX attributes
                remove_template_string = false, -- remove backticks when there are no template strings
                restore_quotes = {
                    -- quotes used when "remove_template_string" option is enabled
                    normal = [[']],
                    jsx = [["]],
                },
            })
        end,
    },
    
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
        "f-person/git-blame.nvim",
        -- load the plugin at startup
        event = "VeryLazy",
        -- Because of the keys part, you will be lazy loading this plugin.
        -- The plugin wil only load once one of the keys is used.
        -- If you want to load the plugin at startup, add something like event = "VeryLazy",
        -- or lazy = false. One of both options will work.
        opts = {
            -- your configuration comes here
            -- for example
            enabled = true, -- if you want to enable the plugin
            message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
            date_format = "%d-%m-%Y %H:%M:%S", -- template for the date, check Date format section for more options
            virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
        },
    },
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
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
      },
      config = true
    },

    -- Colorschemes
    { 'rose-pine/neovim', as = 'rose-pine' },

    -- Trouble
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
            }
        end
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "lua",
                "typescript",
                "javascript",
                "json",
                "prisma", -- ✅ adiciona o prisma
            },
            highlight = { enable = true },
        },
    },
    {
        "pantharshit00/vim-prisma", -- ✅ highlight extra para .prisma
    },
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-textobjects',

    -- Undotree
    'mbbill/undotree',

    -- Telescope
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { {'nvim-lua/plenary.nvim'} },
        opts = {
            defaults = {
                file_ignore_patterns = { "vendor/", ".node_modules" }
            },
            windblend = 80,
            border = false,
            color_devicons = false,
        }
    },

    -- LSP Config
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        },
        config = function()
            require('lsp-zero').setup()

            -- plugin lspconfig
            local lspconfig = require("lspconfig")

            lspconfig.biome.setup({
                capabilities = capabilities,
                workingDirectory = { mode = "auto" },
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            })


            -- Configuração do servidor Prisma
            lspconfig.prismals.setup{
                on_attach = function(client, bufnr)
                    print("Prisma LSP ativo!")
                    -- Aqui você pode adicionar keymaps, etc
                end,
                settings = {
                    prisma = {
                        prismaFmtEnabled = true, -- habilita formatação
                    }
                }
            }

            -- Habilita o servidor do TypeScript
            lspconfig.ts_ls.setup {
                capabilities = capabilities,
                workingDirectory = { mode = "auto" },
                inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            }
          
      
           local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
              'force',
              lspconfig_defaults.capabilities,
              require('cmp_nvim_lsp').default_capabilities()
            )

            vim.api.nvim_create_autocmd('LspAttach', {
              desc = 'LSP actions',
              callback = function(event)

                local opts = {buffer = event.buf}

                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
              end,
            })
            local cmp = require('cmp')

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body) -- sua implementação atual
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- Mapeia Enter para confirmar autocomplete
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
            })
        end
    },
    'folke/zen-mode.nvim',

    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    {
        "tpope/vim-dadbod",
        lazy = true,
        cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    },

    {
        "kristijanhusak/vim-dadbod-ui",
        lazy = true,
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        dependencies = {
            "tpope/vim-dadbod",
            "kristijanhusak/vim-dadbod-completion",
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_help = 0
            vim.g.db_ui_win_position = "left"
        end,
    },

    {
        "kristijanhusak/vim-dadbod-completion",
        lazy = true,
        ft = { "sql", "mysql", "plsql" },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "sql", "mysql", "plsql" },
                callback = function()
                    require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
                end,
            })
        end,
    },
})

