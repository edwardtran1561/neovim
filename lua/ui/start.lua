local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- ==== HEADER (minimal pixel style) ====
dashboard.section.header.val = {
	" ▄▄▄▄▄▄▄    ▄▄                        ▄▄   ▄▄▄▄▄▄▄▄▄                ",
	"███▀▀▀▀▀    ██                        ██   ▀▀▀███▀▀▀                ",
	"███▄▄    ▄████ ██   ██  ▀▀█▄ ████▄ ▄████      ███ ████▄  ▀▀█▄ ████▄ ",
	"███      ██ ██ ██ █ ██ ▄█▀██ ██ ▀▀ ██ ██      ███ ██ ▀▀ ▄█▀██ ██ ██ ",
	"▀███████ ▀████  ██▀██  ▀█▄██ ██    ▀████      ███ ██    ▀█▄██ ██ ██ ",
}

-- ==== INFO PANEL ====
local function footer()
	local stats = require("lazy").stats()
	local datetime = os.date(" %d-%m-%Y   %H:%M")

	return {
		"",
		datetime,
		"⚡ Plugins: " .. stats.count .. " | Startup: " .. math.floor(stats.startuptime) .. " ms",
	}
end

dashboard.section.footer.val = footer()

-- ==== BUTTONS ====
dashboard.section.buttons.val = {
	dashboard.button("e", "Explorer", "<cmd>NvimTreeToggle<CR>"),
	dashboard.button("f", "Find file", ":Telescope find_files<CR>"),
	dashboard.button("c", "Config", ":e ~/.config/nvim<CR>"),
	dashboard.button("q", "Quit", ":qa<CR>"),
}

-- ==== CENTER EVERYTHING ====
dashboard.opts.layout[1].val = 5

alpha.setup(dashboard.opts)
