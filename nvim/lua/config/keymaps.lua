local noremap = { noremap = true }

vim.keymap.set({"n", "i"}, "<C-c>", "<Esc>", noremap)
vim.keymap.set("", "<C-z>", "<Nop>", noremap)

vim.keymap.set("", "<C-j>", "4j", noremap)
vim.keymap.set("", "<C-k>", "4k", noremap)

vim.keymap.set("n", "<C-a>", "ggVG", noremap)

vim.keymap.set("n", "<C-A-j>", "ddjP==", noremap)
vim.keymap.set("n", "<C-A-k>", "ddkP==", noremap)

vim.keymap.set("n", "g{", "f{V%", noremap)

vim.keymap.set("n", "<A-z>", ":set wrap!<CR>", { noremap = true, silent = true })

vim.keymap.set("i", "(", "()<left>", noremap)
vim.keymap.set("i", "[", "[]<left>", noremap)
vim.keymap.set("i", "{", "{}<left>", noremap)
vim.keymap.set("i", "<", "<><left>", noremap)

vim.keymap.set("i", "(<CR>", "(\n)<ESC>O", noremap)
vim.keymap.set("i", "[<CR>", "[\n]<ESC>O", noremap)
vim.keymap.set("i", "{<CR>", "{\n}<ESC>O", noremap)
vim.keymap.set("i", "<<CR>", "<\n><ESC>O", noremap)

vim.keymap.set("i", "\"", "\"\"<left>", noremap)
vim.keymap.set("i", "'", "''<left>", noremap)
vim.keymap.set("i", "`", "``<left>", noremap)

vim.keymap.set("i", "<C-BS>", "<C-w>", noremap)

vim.keymap.set("v", "<C-c>", '"+y', noremap)
vim.keymap.set("v", "<C-x>", '"+d', noremap)
vim.keymap.set("v", "<C-v>", '"+p', noremap)

vim.keymap.set("c", "<C-j>", "<C-n>", noremap)
vim.keymap.set("c", "<C-k>", "<C-p>", noremap)
