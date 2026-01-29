# Neovim Configuration (ss-nvim)

A professional Neovim configuration optimized for Java and Lua development. This setup provides an IDE-like experience with a clean, modern interface using Lua for configuration.

## Features

- **Java IDE Capabilities**: Comprehensive Java support via `nvim-jdtls`, including unit testing, debugging, and refactoring.
- **Modern UI**: Enhanced interface with floating windows, a customized statusline, and a sophisticated colorscheme.
- **LSP Support**: Out-of-the-box configuration for multiple languages with auto-installation for servers and tools.
- **Fuzzy Finding**: Powerful search capabilities for files, buffers, and symbols.
- **Integrated Debugging**: Full Debug Adapter Protocol (DAP) integration.
- **File Exploration**: Sidebar file management with git status integration.

## Installation

### Prerequisites

- **Neovim**: Version 0.10 or higher.
- **Nerd Font**: Required for icons (e.g., JetBrainsMono Nerd Font).
- **Java**: **JDK 21 or higher is required** to run the Java Language Server (JDTLS). 
  - **Important**: Before launching Neovim for the first time, ensure you have JDK 21+ installed. If you are not on Linux or your JDK is installed in a non-standard path, you **must** update the `home` and `runtimes` paths in `ftplugin/java.lua`.
- **External Dependencies**:
  - `git`, `make`, `unzip`, `gcc`, `ripgrep`, `fd-find`.
  - **Node.js**: Required for some LSP servers.

### Quick Start

1. Backup your existing configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this repository:
   ```bash
   git clone https://github.com/santanusinha/neovim-config ~/.config/nvim
   ```

3. Launch Neovim:
   ```bash
   nvim
   ```
   `lazy.nvim` will automatically bootstrap itself and install all configured plugins.

## Project Structure

- `init.lua`: The main entry point that initializes the package manager and core modules.
- `lua/core/`: Contains fundamental settings.
  - `options.lua`: Vim options (indentation, search behavior, etc.).
  - `keymaps.lua`: Global key bindings.
- `lua/plugins/`: Individual plugin specifications and configurations.
- `ftplugin/`: Filetype-specific configurations (e.g., `java.lua` for specialized Java LSP setup).

## Plugin Overview

### Interface and Aesthetics
| Plugin | Description |
| :--- | :--- |
| kanagawa.nvim | A sophisticated color scheme inspired by Japanese art. |
| lualine.nvim | A fast and customizable statusline. |
| noice.nvim | Enhanced UI for messages, cmdline, and popupmenu. |
| barbecue | A VS Code-like winbar showing context/breadcrumbs. |
| fidget.nvim | Standalone UI for LSP progress notifications. |
| nvim-notify | A fancy, configurable notification manager. |

### Navigation and Search
| Plugin | Description |
| :--- | :--- |
| neo-tree.nvim | Sidebar file explorer with git integration. |
| telescope.nvim | Highly extendable fuzzy finder over lists (files, grep, etc.). |
| trouble.nvim | A pretty list for showing diagnostics and LSP results. |
| snacks.nvim | A collection of small, high-quality QoL utilities. |

### LSP and Development
| Plugin | Description |
| :--- | :--- |
| nvim-lspconfig | Quickstart configurations for the Nvim LSP client. |
| mason.nvim | Portable package manager for LSP servers, DAP servers, linters, and formatters. |
| none-ls.nvim | Use Neovim as a language server to inject LSP diagnostics, code actions, and more. |
| nvim-jdtls | Extensions for the built-in LSP support for Eclipse JDT.LS. |
| nvim-cmp | A modular completion engine for Neovim. |
| nvim-treesitter | Treesitter configurations and abstraction layer for advanced highlighting. |

### Debugging (DAP)
| Plugin | Description |
| :--- | :--- |
| nvim-dap | Debug Adapter Protocol (DAP) client implementation. |
| nvim-dap-ui | A UI for nvim-dap. |
| nvim-dap-virtual-text | Virtual text support for nvim-dap. |

## Key Bindings

The leader key is set to `Space`.

### Navigation
- `<S-t>`: Toggle Neo-tree file explorer.
- `<leader>ff`: Find files.
- `<leader>fg`: Live grep.
- `<leader>bl`: List open buffers.

### LSP / Code Intelligence
- `<leader>ch`: Show documentation (Hover).
- `<leader>ca`: Code actions.
- `<leader>rr`: Rename symbol.
- `<leader>cd`: Go to definition.
- `<leader>gl`: Toggle diagnostic list (Trouble).

### Debugging
- `<F9>`: Continue execution.
- `<S-F8>`: Step over.
- `<F7>`: Step into.
- `<leader>bb`: Toggle breakpoint.

### Java Specific
- `<leader>jo`: Organize imports.
- `<leader>jt`: Run test class.
- `<leader>tc`: Run nearest test method.
- `<leader>jv`: Extract variable.
