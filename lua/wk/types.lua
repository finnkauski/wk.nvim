-- Local
local utils = require("wk.utils")

local M = {}

--- @class User
--- @field data {}
M.User = {}

function M.User:get()
  local user = utils.fetch("user")
  setmetatable(user, self)
  self.__index = self
  return user
end

function M.User:repr()
  return { self.data.username, self.data.level, self }
end

--- @class Summary
M.Summary = {}

function M.Summary:get()
  local summary = utils.fetch("summary")
  setmetatable(summary, self)
  self.__index = self
  return summary
end

function M.Summary:repr()
  return { self }
end

return M
