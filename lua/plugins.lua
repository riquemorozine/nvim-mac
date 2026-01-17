

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


    'tpope/vim-dispatch',

    "lewis6991/gitsigns.nvim",
    install={   install = { colorscheme = { "tokyonight", "catppuccin" } },},
    ui={
        border = "rounded",
    },
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
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        opts = {
            transparent_background = true,
            no_italic = true,
            no_bold = false,
            integrations = {
                harpoon = true,
                fidget = true,
                cmp = true,
                flash = true,
                gitsigns = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                lsp_trouble = true,
                mason = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                noice = true,
                notify = true,
                neotree = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                which_key = true,
            },
            highlight_overrides = {
                all = function(colors)
                    return {
                        DiagnosticVirtualTextError = { bg = colors.none },
                        DiagnosticVirtualTextWarn = { bg = colors.none },
                        DiagnosticVirtualTextHint = { bg = colors.none },
                        DiagnosticVirtualTextInfo = { bg = colors.none },
                    }
                end,
            },
            color_overrides = {
                mocha = {
                    -- I don't think these colours are pastel enough by default!
                    peach = "#fcc6a7",
                    green = "#d2fac5",
                },
            },
        },
    }, 
    
    {
        {
            "rachartier/tiny-inline-diagnostic.nvim",
            event = "VeryLazy",
            priority = 1000,
            opts = {},
        },
        {
            "neovim/nvim-lspconfig",
            opts = { diagnostics = { virtual_text = false } },
        },
    },
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<S-Tab>",
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

    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
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
            virtual_text_column = 200, -- virtual text start column, check Start virtual text at column section for more options
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
        auto_install = true,
        opts = {
            ensure_installed = {
                "lua",
                "typescript",
                "javascript",
                "json",
                "go",
                "css",
                "prisma", 
                "html"
            },
            highlight = { enable = true },
            autotag = { enable = true },
        },
    },
    {
        "windwp/nvim-ts-autotag",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
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
{
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        local util = require("lspconfig.util")

        local function has_any_file_in_root(root, filenames)
            if not root then
                return false
            end
            for _, filename in ipairs(filenames) do
                if vim.fn.filereadable(root .. "/" .. filename) == 1 then
                    return true
                end
            end
            return false
        end

        local function has_eslintrc(ctx)
            if not ctx or not ctx.filename then return false end
            local root = util.root_pattern(
                "eslint.config.js", ".eslintrc", ".eslintrc.js", ".eslintrc.json"
            )(ctx.filename)
            return has_any_file_in_root(root, {
                "eslint.config.js", ".eslintrc", ".eslintrc.js", ".eslintrc.json"
            })
        end

        local function has_biomerc(ctx)
            if not ctx or not ctx.filename then return false end
            local root = util.root_pattern("biome.json", "biome.yaml", "biome.yml")(ctx.filename)
            -- roda mesmo sem arquivo de config
            return root ~= nil
        end

        local function has_prettierrc(ctx)
            if not ctx or not ctx.filename then return false end
            local root = util.root_pattern(
                ".prettierrc", ".prettierrc.json", ".prettierrc.js", ".prettierrc.cjs",
                "prettier.config.js", "prettier.config.cjs"
            )(ctx.filename)
            -- roda mesmo sem arquivo de config
            return root ~= nil
        end

        conform.setup({
            formatters_by_ft = {
                javascript = { "eslint", "biome", "prettier" },
                javascriptreact = { "eslint", "biome", "prettier" },
                typescript = { "eslint", "biome", "prettier" },
                typescriptreact = { "eslint", "biome", "prettier" },
                javascriptvue = { "eslint", "biome", "prettier" },
                typescriptvue = { "eslint", "biome", "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                json = { "prettier" },
                markdown = { "prettier" },
                lua = { "stylua" },
            },
            formatters = {
                eslint = {
                    condition = function(_, ctx)
                        return has_eslintrc(ctx) -- só roda se houver .eslintrc
                    end,
                    command = vim.fn.executable("./node_modules/.bin/eslint") == 1
                        and "./node_modules/.bin/eslint"
                        or "eslint",
                    args = { "--fix", "--stdin", "--stdin-filename", "$FILENAME" },
                    stdin = true,
                    timeout_ms = 10000,
                },
                biome = {
                    condition = function(_, ctx)
                        return not has_eslintrc(ctx)  -- roda sempre que não tiver ESLint
                    end,
                    command = vim.fn.executable("./node_modules/.bin/biome") == 1
                        and "./node_modules/.bin/biome"
                        or "biome",
                    timeout_ms = 10000,
                },
                prettier = {
                    condition = function(_, ctx)
                        return not has_eslintrc(ctx) and not has_biomerc(ctx) -- fallback final
                    end,
                    command = vim.fn.executable("./node_modules/.bin/prettier") == 1
                        and "./node_modules/.bin/prettier"
                        or "prettier",
                    args = { "--stdin-filepath", "$FILENAME" },
                    timeout_ms = 10000,
                },
            },
        })
    end,
},
{
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},

		config = function()
			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			require("fidget").setup({})
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"cssls",
					"volar",
					"intelephense",
					"ts_ls",
					"html",
					"jsonls",
					"eslint",
					--"biome"
				},
        auto_update = false,
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,

					["lua_ls"] = function()
						local lspconfig = require("lspconfig")

                        lspconfig.tailwindcss.setup({
                            settings = {
                                tailwindCSS = {
                                    classFunctions = { "cva", "cx" },
                                },
                            },                       
                        })

						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "Lua 5.1" },
									diagnostics = {
										globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
									},
								},
							},
						})
					end,

					["ts_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.ts_ls.setup({
							capabilities = capabilities,
							workingDirectory = { mode = "auto" },
							on_attach = function(client, bufnr)
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentRangeFormattingProvider = false
							end,
						})
					end,

					["biome"] = function()
						require("lspconfig").biome.setup({
							capabilities = capabilities,
							workingDirectory = { mode = "auto" },
							on_attach = function(client, bufnr)
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentRangeFormattingProvider = false
							end,
						})
					end,

					["eslint"] = function()
						require("lspconfig").eslint.setup({
							capabilities = capabilities,
							on_attach = function(client, bufnr)
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentRangeFormattingProvider = false
							end,
						})
					end,
				},
			})

			vim.diagnostic.config({
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
	},
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
           local lspconfig = require('lspconfig')

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
                    { name = 'buffer' },
                },
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body) -- sua implementação atual
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
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

