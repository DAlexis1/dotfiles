local config = function()
	require("neoconf").setup({})
	local lspconfig = require("lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	local signs = { Error = " ", Warn = " ", Hint = "-", Info = "" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true, buffer = bufnr }

		vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
		vim.keymap.set("n", "gD", "<cmd>Lua vim.lsp.buf.implementation<CR>", opts)
		vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
		vim.keymap.set("n", "gi", "<cmd>Lua vim.lsp.buf.implementation<CR>", opts)
		vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
		vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
		vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostic<CR>", opts)
		vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostic<CR>", opts)
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) --get the manual entry for the function
		vim.keymap.set("n", "<leader>lo", "<cmd>LSoutlineToggle<CR>", opts)
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	lspconfig.clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		},
	})

	lspconfig.bashls.setup({})

	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	-- local flake8 = require("efmls-configs.linters.flake8")
	-- local black = require("efmls-configs.formatters.black")
	local pylint = require("efmls-configs.linters.pylint")
	local autopep8 = require("efmls-configs.formatters.autopep8")
	local cpplint = require("efmls-configs.linters.cpplint")
	local clangformat = require("efmls-configs.formatters.clang_format")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"python",
			"c",
			"cpp",
			"sh",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { pylint, autopep8 },
				c = { clangformat, cpplint },
				cpp = { clangformat, cpplint },
				sh = { shfmt, shellcheck },
			},
		},
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
