return {
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
}
