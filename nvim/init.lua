vim.opt.guicursor = "i:ver1-blinkon10"
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.opt.wrap = false

local keymapModes = { "i", "x", "n", "s" };

vim.keymap.set(keymapModes, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set(keymapModes, "<C-w>", "<cmd>q<cr>", { desc = "Close current buffer" })
vim.keymap.set(keymapModes, "<C-q>", "<cmd>qa<cr>", { desc = "Close all buffers" })

vim.keymap.set(keymapModes, "<C-tab>", "]b", { desc = "Next tab" })

vim.keymap.set(keymapModes, "<A-Up>", "<cmd>m .-2<cr>", { desc = "Move line up" })
vim.keymap.set(keymapModes, "<A-Down>", "<cmd>m .+1<cr>", { desc = "Move line down" })

vim.opt.fillchars = {
	eob = " ",

	horiz     = '═',

	horizup   = '╩',
	
	horizdown = '╦',

	vert      = '║',

	vertright = '╠',

	vertleft  = '╣',

	verthoriz = '╬',
}
vim.opt.listchars = { tab = "│  " }
vim.opt.list = true

vim.opt.title = true
vim.opt.titlestring = vim.fs.basename(vim.fn.getcwd()) .. " — Neovim"

vim.opt.clipboard = "unnamedplus"
require("config.lazy")

local colours = {
	background = "#112717",
	foreground = "#AAE8B6",
	primary = "#4E7B31",
	alert = "#BB334C",
	disabled = "#2E462B",
}
require("bufferline").setup({
	options = {
		mode = "buffer",
		separator_style = "thick",
		offsets = {
			{
				filetype = "neo-tree",
				text = "neo-tree",
				text_align = "center",
				separator = true
			}
		},
	},
	highlights = {
		fill =	{ bg = "none" },

		background =		{ bg = colours.disabled, fg = colours.foreground },
		buffer_visible =	{ bg = colours.disabled, fg = colours.foreground },
		buffer_selected =	{ bg = colours.primary, fg = colours.background },
		
		separator_selected =	{ bg = "none", fg = "none" },
		separator_visible =	{ bg = "none", fg = "none" },
		separator =		{ bg = "none", fg = "none" },

		tab_separator_selected =	{ bg = "none", fg = "none" },
		tab_separator =			{ bg = "none", fg = "none" },


		close_button =		{ bg = colours.disabled, fg = colours.foreground },
		close_button_visible =	{ bg = colours.disabled, fg = colours.foreground },
		close_button_selected =	{ bg = colours.primary, fg = colours.background },

		modified =		{ bg = colours.disabled, fg = colours.foreground },
		modified_visible =	{ bg = colours.disabled, fg = colours.foreground },
		modified_selected =	{ bg = colours.primary, fg = colours.background },

	}
})
require("neo-tree")
vim.cmd("Neotree show")

require("mini.pairs").setup()
require('gitsigns').setup()

require("cyberdream").setup({
	variant = "dark",
	transparent = true,
	saturation = 0.5,
})
vim.cmd.colorscheme("cyberdream")

vim.api.nvim_create_autocmd("TabNew", {
	group = vim.api.nvim_create_augroup("NeotreeOnNewTab", { clear = true }),
	command = "Neotree",
})
