require("fzf-lua").setup({
	defaults =  {
		git_icons = true,
		file_icons = false,
		color_icons = false,
	},
		fzf_opts = {
		["--no-info"] = "",
		["--info"] = "hidden",
		-- ["--padding"] = "13%,5%,13%,5%",
		["--header"] = " ",
	},
	previewers = {
		builtin = {
			syntax_limit_b = -102400
		}
	},
	buffers = {
		formatter = "path.filename_first",
		-- prompt = "> ",
		no_header = true,
		fzf_opts = { ["--delimiter"] = " ", ["--with-nth"] = "-1.." },
		winopts = {
			title = " buffers 📝 ",
			title_pos = "center",
		},
	},
	winopts = {
		border = "rounded",
		height = 0.85,
		width = 0.80,
	},
	keymap =  {
		builtin  = {
			["<C-j>"] = "down",
			["<C-k>"] = "up",
		}
	}

})
