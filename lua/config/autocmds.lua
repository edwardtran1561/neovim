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
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  command = "silent! checktime",
})

-- Watch all files in CWD for external changes (e.g. Claude Code), auto-open and jump to changed line -- ping
local dir_mtimes = {}
local dir_content = {}
local dir_initialized = false

local skip_dirs = {
  [".git"] = true, ["node_modules"] = true, ["__pycache__"] = true,
  [".cache"] = true, ["dist"] = true, ["build"] = true, [".next"] = true,
}
local skip_exts = {
  [".png"]=true,[".jpg"]=true,[".jpeg"]=true,[".gif"]=true,[".ico"]=true,
  [".svg"]=true,[".woff"]=true,[".woff2"]=true,[".ttf"]=true,[".eot"]=true,
  [".pdf"]=true,[".zip"]=true,[".tar"]=true,[".gz"]=true,[".lock"]=true,
}

local function scan_files(dir, result)
  result = result or {}
  local handle = vim.uv.fs_scandir(dir)
  if not handle then return result end
  while true do
    local name, ftype = vim.uv.fs_scandir_next(handle)
    if not name then break end
    if name:sub(1, 1) ~= "." then
      local fullpath = dir .. "/" .. name
      if ftype == "directory" then
        if not skip_dirs[name] then scan_files(fullpath, result) end
      elseif ftype == "file" then
        local ext = name:match("(%.[^%.]+)$")
        if not (ext and skip_exts[ext]) then
          table.insert(result, fullpath)
        end
      end
    end
  end
  return result
end

local function open_and_jump(filepath, line, new_lines)
  local abs = vim.fn.fnamemodify(filepath, ":p")
  local bufnr = vim.fn.bufnr(abs)

  if bufnr ~= -1 and vim.api.nvim_buf_is_loaded(bufnr) then
    pcall(vim.api.nvim_buf_set_lines, bufnr, 0, -1, false, new_lines)
    vim.bo[bufnr].modified = false
  else
    vim.cmd("edit " .. vim.fn.fnameescape(abs))
    bufnr = vim.api.nvim_get_current_buf()
  end

  local wins = vim.fn.win_findbuf(bufnr)
  if #wins == 0 then
    vim.cmd("edit " .. vim.fn.fnameescape(abs))
    wins = { vim.api.nvim_get_current_win() }
  end

  local max_line = vim.api.nvim_buf_line_count(bufnr)
  pcall(vim.api.nvim_win_set_cursor, wins[1], { math.min(line, max_line), 0 })
  vim.api.nvim_win_call(wins[1], function() vim.cmd("normal! zz") end)
end

local function read_file(path)
  local ok, lines = pcall(vim.fn.readfile, path)
  return ok and lines or nil
end

local function get_watched_dir()
  local arg = vim.fn.argv(0)
  if arg and arg ~= "" then
    local expanded = vim.fn.expand(tostring(arg))
    if vim.fn.isdirectory(expanded) == 1 then
      return expanded
    else
      return vim.fn.fnamemodify(expanded, ":h")
    end
  end
  return vim.fn.getcwd()
end

local function watch_dir_changes()
  local watched_dir = get_watched_dir()
  local ok, err = pcall(function()
    local files = scan_files(watched_dir)
    for _, filepath in ipairs(files) do
      local stat = vim.uv.fs_stat(filepath)
      if stat then
        local mtime = stat.mtime.sec
        if not dir_mtimes[filepath] then
          local lines = read_file(filepath)
          if lines then
            dir_content[filepath] = lines
            dir_mtimes[filepath] = mtime
            if dir_initialized then
              open_and_jump(filepath, 1, lines)
            end
          end
        elseif dir_mtimes[filepath] < mtime then
          local old_lines = dir_content[filepath] or {}
          local new_lines = read_file(filepath)
          if new_lines then
            local changed_line = math.max(1, #new_lines)
            for i = 1, math.max(#old_lines, #new_lines) do
              if old_lines[i] ~= new_lines[i] then
                changed_line = i
                break
              end
            end
            open_and_jump(filepath, changed_line, new_lines)
            dir_content[filepath] = new_lines
            dir_mtimes[filepath] = mtime
          end
        end
      end
    end
    dir_initialized = true
  end)
  if not ok then
    vim.notify("watch_dir_changes error: " .. tostring(err), vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.defer_fn(function()
      -- Reset and re-baseline after all plugins have loaded and written their files
      dir_mtimes = {}
      dir_content = {}
      dir_initialized = false
      watch_dir_changes()
      local dir_watch_timer = vim.uv.new_timer()
      dir_watch_timer:start(1000, 1000, vim.schedule_wrap(watch_dir_changes))
    end, 3000)
  end,
})
