local companion = require("codecompanion")

companion.setup({
	strategies = {
		chat = {
			adapter = "gemini",
		},
		inline = {
			adapter = "gemini",
		},
	},
})

