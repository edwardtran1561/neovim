return {
	"sontungexpt/better-diagnostic-virtual-text",
	event = "LspAttach",
	config = function()
		require("better-diagnostic-virtual-text").setup({
			enabled = true,
			spacing = 2,
			virtual_text = {
				spacing = 4,
			},
		})
	end,
}
