return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	event = "BufReadPre",
  lazy = false,
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
}
