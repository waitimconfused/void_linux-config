return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},

	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			default_component_configs = {

				icon = {
					folder_closed = "󰉋",
					folder_open = "󰝰",
					folder_empty = "󰉖"
				},

				indent = {
					indent_size = 2,
					padding = 1,

					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",

					indent_marker = "│",
					last_indent_marker = "╰"
				},

				modified = {
					symbol = "",
					highlight = "NeoTreeModified",
				},

				file_size = {
					enabled = false,
					width = 12, -- width of the column
					required_width = 64, -- min width of window required to show this column
				},
				type = {
					enabled = false,
					width = 10, -- width of the column
					required_width = 122, -- min width of window required to show this column
				},
				last_modified = {
					enabled = false,
					width = 20, -- width of the column
					required_width = 88, -- min width of window required to show this column
				},
				created = {
					enabled = false,
					width = 20, -- width of the column
					required_width = 110, -- min width of window required to show this column
				},
				symlink_target = {
					enabled = false,
				},

				git_status = {
					symbols = {
						 -- Change type
						added = "",
						modified = "",
						deleted = "",
						renamed = "",
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = ""
					}
				}
			},

			filesystem = {
				filtered_items = {
					-- visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,

					never_show = {
						".git",
					},

				},
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--               -- the current file is changed while the tree is open.
					leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},

			}
		})
	end,
	
	lazy = false,
}
