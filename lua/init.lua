local M = {}

local default_config = {
  cmd = nil,
  filetypes = { 'openfga' },
  root_markers = { '.git' },
}

local global_config = vim.deepcopy(default_config)

local function server_from_vscode()
  if vim.fn.executable('node') ~= 1 then
    return nil
  end

  local extensions = {}
  if vim.fn.executable('code') == 1 then
    local extension = vim.fn.trim(vim.fn.system({ 'code', '--locate-extension', 'openfga.openfga-vscode' }))
    if vim.v.shell_error == 0 and extension ~= '' then
      table.insert(extensions, extension)
    end
  end

  vim.list_extend(extensions, vim.fn.glob(vim.fn.expand('~/.vscode-server/extensions/openfga.openfga-vscode-*'), true, true))
  vim.list_extend(extensions, vim.fn.glob(vim.fn.expand('~/.vscode/extensions/openfga.openfga-vscode-*'), true, true))

  for _, extension in ipairs(extensions) do
    for _, filename in ipairs({ 'server.node.js', 'server.js' }) do
      local server = extension .. '/server/out/' .. filename
      if vim.fn.filereadable(server) == 1 then
        return { 'node', server, '--stdio' }
      end
    end
  end

  return nil
end

local function resolve_cmd()
  if global_config.cmd then
    if type(global_config.cmd) == 'string' then
      return vim.split(global_config.cmd, '%s+', { trimempty = true })
    end
    return global_config.cmd
  end

  local configured = vim.env.OPENFGA_LANGUAGE_SERVER
  if configured and configured ~= '' then
    return vim.split(configured, '%s+', { trimempty = true })
  end

  for _, executable in ipairs({ 'openfga-lsp', 'openfga-language-server', 'fga-language-server' }) do
    if vim.fn.executable(executable) == 1 then
      return { executable }
    end
  end

  return server_from_vscode()
end

function M.setup(opts)
  global_config = vim.tbl_deep_extend('force', default_config, opts or {})

  local cmd = resolve_cmd()
  if not cmd then
    vim.notify('OpenFGA language server was not found. Set setup({ cmd = ... }) or OPENFGA_LANGUAGE_SERVER.', vim.log.levels.WARN)
    return
  end

  local lsp_config = vim.deepcopy(global_config)
  lsp_config.cmd = cmd
  vim.lsp.config('openfga', lsp_config)
  vim.lsp.enable('openfga')
end

return M
