return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,


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

					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = { query = "@class.inner", desc = "Select inner class" },
						["as"] = { query = "@scope", query_group = "locals", desc = "Select scope" },
					},

					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},

					include_surrounding_whitespace = true,
				},
			},
		},
	}
}

