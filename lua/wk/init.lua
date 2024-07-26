-- Local
local utils = require("wk.utils")
local types = require("wk.types")
local Canvas = require("wk.Canvas")
local config = require("wk.config")

local M = {}

--- Sets some basic useful keymaps
M.set_default_keymaps = function()
  utils._nmap("<leader><leader>w", function()
    local user = types.User:get()
    local summary = types.Summary:get()
    local canvas = Canvas:new()

    P(summary:repr())
    -- canvas:write(user)
    -- canvas:render_buffer(0)
  end, "Get User")
end

--- Setup is the public method to setup your plugin
--- @param opts table
M.setup = function(opts)
  config.set(opts or {})

  -- Set keymaps if not stopped
  if config.values.default_keymap then
    M.set_default_keymaps()
  end
end

return M
