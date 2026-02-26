---
name: illuminate
description: The illuminate skill provides instructions for managing the vim-illuminate plugin to automatically highlight and navigate occurrences of the word under the cursor. Use when user asks to configure highlighting providers, toggle the plugin on specific buffers, customize visual styles, or set up keymaps for jumping between references.
homepage: https://github.com/RRethy/vim-illuminate
---


# illuminate

## Overview
The illuminate skill provides procedural knowledge for managing the vim-illuminate plugin, which automatically highlights all occurrences of the word under the cursor. It leverages a prioritized provider system—starting with LSP, falling back to Tree-sitter, and finally using regex—to ensure accurate symbol identification. This skill guides users through optimizing performance for large files, configuring buffer-local behavior, and styling the visual feedback to match their editor theme.

## Configuration Patterns
The plugin is primarily configured via Lua in Neovim. Use the `configure` function to define global behavior.

```lua
require('illuminate').configure({
    -- Priority-ordered list of providers
    providers = { 'lsp', 'treesitter', 'regex' },
    -- Delay in milliseconds before highlighting
    delay = 100,
    -- Disable for specific filetypes
    filetypes_denylist = { 'dirbuf', 'dirvish', 'fugitive' },
    -- Disable for files exceeding a specific line count
    large_file_cutoff = 10000,
    -- Disable highlighting for the word directly under the cursor
    under_cursor = true,
})
```

## Commands and Buffer Management
Use these commands to control the plugin's state without restarting the editor.

| Command | Scope | Action |
| :--- | :--- | :--- |
| `:IlluminateToggle` | Global | Enable/Disable highlighting globally |
| `:IlluminateToggleBuf` | Buffer | Enable/Disable highlighting for current buffer |
| `:IlluminatePause` | Global | Pause the highlighting engine |
| `:IlluminateResume` | Global | Resume the highlighting engine |

## Navigation and Text Objects
By default, the plugin provides keymaps for jumping between references. If `disable_keymaps` is set to true, use the following Lua functions for custom bindings:

- **Next Reference**: `require('illuminate').goto_next_reference(wrap)`
- **Previous Reference**: `require('illuminate').goto_prev_reference(wrap) `
- **Text Object**: `require('illuminate').textobj_select()` (Used to select the illuminated word for operations like `ciw`)

## Customizing Visuals
Illuminate uses specific highlight groups. Define these in your `init.lua` or `init.vim` to change the appearance of references.

- `IlluminatedWordText`: Default highlight for references.
- `IlluminatedWordRead`: Highlight for references with "read" access (LSP-specific).
- `IlluminatedWordWrite`: Highlight for references with "write" access (LSP-specific).

Example (Vimscript):
```vim
hi def IlluminatedWordText gui=underline cterm=underline
hi def IlluminatedWordWrite gubg=#3b4252
```

## Expert Tips
- **Performance**: For very large files, set `large_file_overrides = nil` in the config to completely disable the plugin when the `large_file_cutoff` is reached.
- **Visibility**: Use `require('illuminate').invisible_buf()` to hide highlights in a specific buffer while keeping the navigation engine (`<a-n>`/`<a-p>`) active.
- **Regex Syntax**: If using the regex provider, you can denylist specific syntax groups using `providers_regex_syntax_denylist` to prevent highlighting inside comments or strings.

## Reference documentation
- [vim-illuminate README](./references/github_com_RRethy_vim-illuminate.md)