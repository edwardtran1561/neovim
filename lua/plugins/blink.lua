return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- ⌨️ Keymap tối ưu: Tab để chọn/nhảy snippet, Enter để chấp nhận
		keymap = {
			preset = "none",
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = {
				function(cmp)
					if cmp.is_snippet_active() then
						return cmp.snippet_forward()
					else
						return cmp.select_next()
					end
				end,
				"fallback",
			},
			["<S-Tab>"] = {
				function(cmp)
					if cmp.is_snippet_active() then
						return cmp.snippet_backward()
					else
						return cmp.select_prev()
					end
				end,
				"fallback",
			},
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = true, -- Giúp đồng bộ icon với nvim-cmp cũ
			nerd_font_variant = "mono",
		},

		completion = {
			-- Hiển thị menu hoàn thiện đẹp hơn (Bo góc chuẩn VS Code)
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
				},
			},
			-- Tự động hiện tài liệu (documentation) khi chọn item
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = { border = "rounded" },
			},
			-- Hiển thị gợi ý mờ (ghost text) khi đang gõ giống VS Code/Copilot
			ghost_text = { enabled = true },
		},

		-- 🛠️ Nguồn gợi ý (Sources) - Đã FIX lỗi min_length
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					score_offset = 100, -- Ưu tiên gợi ý từ LSP
				},
				snippets = {
					score_offset = 80,
				},
				buffer = {
					score_offset = 0,
					min_keyword_length = 3, -- Sửa từ min_length để fix lỗi nvim báo đỏ
				},
			},
		},

		-- Engine tìm kiếm tối ưu bằng Rust
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
