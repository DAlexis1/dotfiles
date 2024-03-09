return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	event = "BufReadPre",
	lazy = false,
	config = function()
		local mason = require("mason")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"autopep8",
				"bash-language-server",
				"clangd",
				"codelldb",
				"cpplint",
				"efm",
				"lua-language-server",
				"luacheck",
				"texlab",
				"vale",
				--"pylint", if needed we can put it but it's not really useful as it have some bugs with imports
				"ruff",
				"pyright",
				"shellcheck",
				"shfmt",
				"stylua",
				-- "rust-analyzer", to reset if needed
			},
			auto_update = true,
		})
	end,
}
