local M = {}

M.values = {
  default_keymap = true,
  base_url = "https://api.wanikani.com/v2/",
  api_key = vim.env.WK_API_KEY or "",
}

--- Set user-defined configurations
--- @param opts table
--- @return table
M.set = function(opts)
  vim.validate({ opts = { opts, "table" } })

  M.values = vim.tbl_deep_extend("force", M.values, opts)
  return M.values
end

return M
