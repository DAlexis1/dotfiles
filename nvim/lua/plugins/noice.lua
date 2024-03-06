return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		cmdline = {
			enabled = true,
			view = "cmdline",
		},
		messages = {
			enabled = true,
			view = "mini",
			view_error = "mini",
			view_warn = "mini",
			view_history = "messages",
			view_search = "virtualtext",
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- {
		-- 	"rcarriga/nvim-notify",
		-- 	config = function()
		-- 		require("notify").setup({
		-- 			background_colour = "#000000",
		-- 		})
		-- 	end,
		-- },
	},
}
