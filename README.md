# openfga.nvim

Neovim support for OpenFGA model files (`.fga` and `.openfga`). Syntax
highlighting is included, and the plugin can start an OpenFGA language server
for diagnostics and other LSP features.

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'goropikari/openfga.nvim',
  ft = { 'openfga' },
  opts = {},
}
```

The plugin supports `.fga` and `.openfga` files. The OpenFGA language server
must be available separately. The plugin first looks for the standalone
[`openfga-lsp`](https://github.com/goropikari/openfga-lsp) executable, then
other known server executable names, and finally the server bundled with the
OpenFGA VS Code extension under `~/.vscode-server/extensions` or
`~/.vscode/extensions`.

To install the standalone server:

```bash
go install github.com/goropikari/openfga-lsp/cmd/openfga-lsp@latest
```

Install the [OpenFGA VS Code extension](https://marketplace.visualstudio.com/items?itemName=openfga.openfga-vscode)
from the VS Code Extensions view, or install it from the command line:

```bash
code --install-extension openfga.openfga-vscode
```

After installation, verify that the language server bundle exists:

```bash
ls ~/.vscode-server/extensions/openfga.openfga-vscode-*/server/out/server.node.js
```

## LSP

The plugin uses Neovim 0.12's built-in LSP configuration and starts the server
when an OpenFGA file is opened. It looks for `openfga-lsp`,
`openfga-language-server`,
`fga-language-server`, or the server bundled with the OpenFGA VS Code
extension. You can also provide the command explicitly:

```lua
require('openfga').setup {
  cmd = { 'node', '/path/to/vscode-ext/server/out/server.node.js', '--stdio' },
}
```

Alternatively, set `OPENFGA_LANGUAGE_SERVER` to a whitespace-separated command
before starting Neovim. A custom command is useful when the language server is
installed through a package manager or when using a development checkout.

The default workspace root is the nearest directory containing `.git`. Override
it with any Neovim 0.12 LSP option, such as `root_dir`, `settings`, or
`on_attach`, when your workspace requires it.

## License

This project is licensed under the Apache-2.0 license. See [LICENSE](LICENSE)
for more information. The OpenFGA syntax highlighting is adapted from the
[OpenFGA VS Code extension](https://github.com/openfga/vscode-ext); see
[NOTICE](NOTICE) for attribution.
