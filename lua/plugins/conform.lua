return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- Format TRƯỚC khi lưu để tránh nháy màn hình (flicker)
	cmd = { "ConformInfo" },
	opts = {
		-- 🛠️ ĐỊNH DẠNG THEO NGÔN NGỮ (FULLSTACK)
		formatters_by_ft = {
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettier" },
			scss = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			lua = { "stylua" },
			-- Flutter/Dart sẽ tự format qua LSP (flutter-tools) nên không cần thêm ở đây
		},

		-- ⚡ CẤU HÌNH CHI TIẾT
		formatters = {
			prettier = {
				-- Tự động tìm file config (.prettierrc) trong dự án
				condition = function(_, ctx)
					return require("conform.util").root_file({
						".prettierrc",
						".prettierrc.json",
						"prettier.config.js",
						"package.json",
					})(ctx)
				end,
			},
			stylua = {
				-- Ép kiểu thụt lề 2 spaces cho code Lua đồng bộ với options.lua
				args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
			},
		},

		-- 💾 TỰ ĐỘNG FORMAT KHI LƯU
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback", -- Dùng LSP nếu không có formatter riêng
			async = false, -- Đợi format xong mới ghi file để an toàn dữ liệu
		},

		notify_on_error = false,
	},
	config = function(_, opts)
		require("conform").setup(opts)

		-- 🔥 PHÍM TẮT FORMAT THỦ CÔNG: <leader>mp
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			require("conform").format({
				lsp_format = "fallback",
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (Manual)" })

		-- 🧹 FIX LỖI: Đã sửa đúng chính tả 'schedule' (không còn lỗi nil value)
		vim.api.nvim_create_autocmd("BufWritePost", {
			callback = function()
				vim.schedule(function()
					vim.cmd("silent! nohlsearch")
				end)
			end,
		})
	end,
}
