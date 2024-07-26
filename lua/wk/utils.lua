-- Third Party
local curl = require("plenary.curl")

-- Local
local config = require("wk.config")

local M = {}

--- Set keys for normal mode, mainly a convenience
--- @param lhs string
--- @param rhs function | string
--- @param desc string
M._nmap = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, {
    silent = true,
    noremap = true,
    desc = desc,
  })
end

--- Parse the body of a response (usually has all we need and is json)
--- @param response table
M.parse = function(response)
  return vim.json.decode(response.body, {})
end

--- Debug a response body by printing it
--- @param response table
M.debug = function(response)
  vim.notify(vim.inspect(vim.json.decode(response.body, {})))
end

--- Turn a path to a full URL
--- @param path string
M.url = function(path)
  return config.values.base_url .. path
end

--- Make a request fetcher function
--- @param endpoint string
M.fetch = function(endpoint, method)
  method = method or "get"

  return M.parse(curl[method]({
    url = M.url(endpoint),
    raw = { "-H", "Authorization: Bearer " .. config.values.api_key },
  }))
end

return M
