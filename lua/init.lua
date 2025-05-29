local M = {}

local default_config = {}
local global_config = {}

function M.setup(opts)
  global_config = vim.tbl_deep_extend('force', default_config, opts or {})
end

return M
