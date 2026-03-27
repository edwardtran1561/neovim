local alpha_group = vim.api.nvim_create_augroup("AlphaOnEmpty", { clear = true })

vim.api.nvim_create_autocmd("BufDelete", {
  group = alpha_group,
  callback = function()
    -- KIỂM TRA: Nếu đang mở nvim với một đường dẫn thư mục, thoát luôn
    if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
      return
    end

    vim.schedule(function()
      local bufs = vim.fn.getbufinfo({ buflisted = 1 })

      -- Kiểm tra nếu thực sự không còn buffer nào hữu dụng
      local is_empty = #bufs == 0 or (#bufs == 1 and bufs[1].name == "" and vim.bo[bufs[1].bufnr].buftype == "")

      if is_empty then
        -- Chỉ gọi Alpha nếu hiện tại không phải là Alpha và không phải là NvimTree
        local ft = vim.bo.filetype
        if ft ~= "alpha" and ft ~= "NvimTree" then
          -- Dùng lock để chặn mọi render trung gian gây nháy
          vim.opt.eventignore:add("all")
          vim.cmd("silent! Alpha")
          vim.opt.eventignore:remove("all")

          -- Ép vẽ lại UI Alpha ngay lập tức
          vim.cmd("redraw")
        end
      end
    end)
  end,
})

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime",
})

local config_path = vim.fn.stdpath("config")
local last_mtimes = {}
local last_content = {}

local function check_config_changes()
  local files = vim.fn.globpath(config_path, "**/*.lua", false, true)
  for _, filepath in ipairs(files) do
    local stat = vim.uv.fs_stat(filepath)
    if stat then
      local mtime = stat.mtime.sec
      if not last_mtimes[filepath] then
        last_content[filepath] = vim.fn.readfile(filepath)
      elseif last_mtimes[filepath] < mtime then
        local old_lines = last_content[filepath] or {}
        local new_lines = vim.fn.readfile(filepath)
        local bufnr = vim.fn.bufadd(filepath)
        vim.fn.bufload(bufnr)
        vim.bo[bufnr].buflisted = true
        vim.cmd("silent! checktime " .. vim.fn.fnameescape(filepath))
        vim.api.nvim_set_current_buf(bufnr)
        local changed_line = #new_lines
        for i = 1, math.max(#old_lines, #new_lines) do
          if old_lines[i] ~= new_lines[i] then
            changed_line = i
            break
          end
        end
        pcall(vim.api.nvim_win_set_cursor, 0, { changed_line, 0 })
        vim.cmd("normal! zz")
        last_content[filepath] = new_lines
      end
      last_mtimes[filepath] = mtime
    end
  end
end

check_config_changes()
local timer = vim.uv.new_timer()
timer:start(1000, 1000, vim.schedule_wrap(check_config_changes))
