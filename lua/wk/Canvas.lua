local M = {}

---@class Canvas
---@field lines table
local Canvas = {}

function Canvas:new()
  local canvas = {
    lines = { "" },
  }
  setmetatable(canvas, self)
  self.__index = self
  return canvas
end

function Canvas:write(text, opts)
  if type(text) == "table" then
    for _, line in pairs(text) do
      if type(line) == "table" then
        self:write(line[1], line)
      else
        self:write(line)
      end
    end
    return
  end

  if type(text) ~= "string" then
    text = tostring(text)
  end

  opts = opts or {}

  local lines = vim.split(text, "[\r]?\n", { plain = false, trimempty = false })

  if #self.lines == 0 then
    self.lines = { "" }
  end

  for i, line in ipairs(lines) do
    local cur_line = self.lines[#self.lines]
    self.lines[#self.lines] = cur_line .. line
    if i < #lines then
      table.insert(self.lines, "")
    end
  end
end

function Canvas:line_width(line)
  line = line or self:length()
  return #(self.lines[line] or "")
end

--- Remove the last line from state
function Canvas:remove_line()
  self.lines[#self.lines] = nil
end

function Canvas:reset()
  self.lines = {}
end

---Get the number of lines in state
function Canvas:length()
  return #self.lines
end

---Get the length of the longest line in state
function Canvas:width()
  local width = 0
  for _, line in pairs(self.lines) do
    width = width < #line and #line or width
  end
  return width
end

---Apply a render.canvas to a buffer
---@param buffer number
function Canvas:render_buffer(buffer)
  local success, _ = pcall(vim.api.nvim_buf_set_option, buffer, "modifiable", true)
  if not success then
    return false
  end

  local lines = self.lines
  vim.api.nvim_buf_set_lines(buffer, 0, #lines, false, lines)
  local last_line = vim.fn.getbufinfo(buffer)[1].linecount
  if last_line > #lines then
    vim.api.nvim_buf_set_lines(buffer, #lines, last_line, false, {})
  end
  return true
end

function M.new()
  return Canvas:new()
end

return M
