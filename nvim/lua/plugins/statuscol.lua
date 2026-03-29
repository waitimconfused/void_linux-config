return {
	"luukvbaal/statuscol.nvim",

	config = function()
		-- Custom function to show both absolute and relative line numbers
		local function lnum_both()
			local lnum = vim.v.lnum
			return string.format("%d", lnum)
		end

		local builtin = require("statuscol.builtin")

		require("statuscol").setup({
			setopt = true,
			segments = {
				{
					sign = {
						namespace = { "gitsigns.*" },
						name = { "gitsigns.*" },
					},
				},
				{
					sign = {
						namespace = { ".*" },
						name = { ".*" },
						auto = true,
					},
				},
				{
					text = { lnum_both, " " },
					condition = { true },
					click = "v:lua.ScLa",
				}
			},
		})
	end
}
