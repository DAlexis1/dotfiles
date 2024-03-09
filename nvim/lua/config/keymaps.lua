local keymap = vim.keymap

-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts) -- Navigate left
keymap.set("n", "<C-j>", "<C-w>j", opts) -- Navigate down
keymap.set("n", "<C-k>", "<C-w>k", opts) -- Navigate up
keymap.set("n", "<C-l>", "<C-w>l", opts) -- Navigate right

-- Directory Navigation
keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split vertically
keymap.set("n", "<leader>sh", ":split<CR>", opts) -- Split horizontally

-- Trouble keymaps
keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end)

-- Moving lines
keymap.set("n", "<A-j>", ":move .+1<CR>")
keymap.set("n", "<A-k>", ":move .-2<CR>")
keymap.set("x", "<A-j>", ":move '>+1<CR>gv")
keymap.set("x", "<A-k>", ":move '<-2<CR>gv")

-- Using vim as terminal
keymap.set("n", "<leader>t", ":split<CR>:term<CR>")
keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Snippets moving
keymap.set("i", "<C-l>", function()
	local ls = require("luasnip")
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)


