vim.opt.guicursor = "a:ver1-blinkon10"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.opt.wrap = false

vim.opt.fillchars = { eob = " " }
vim.opt.listchars = { tab = "│  " }
vim.opt.list = true

require("config.lazy")
require("neo-tree")
require("mini.pairs").setup()
require('gitsigns').setup()

vim.cmd("Neotree show")
