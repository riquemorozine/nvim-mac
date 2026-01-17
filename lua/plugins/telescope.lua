return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true
	},

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

}
