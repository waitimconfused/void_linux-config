-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

vim.opt.relativenumber = false

vim.opt.foldlevel = 99
vim.opt.foldmethod = "indent"
vim.opt.linebreak = false
vim.g.autoformat = true
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
