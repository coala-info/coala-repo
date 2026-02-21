---
name: argparse-tui
description: `argparse-tui` is a Python library that serves as a bridge between the standard `argparse` module and the Textual TUI framework.
homepage: https://github.com/fresh2dev/argparse-tui
---

# argparse-tui

## Overview

`argparse-tui` is a Python library that serves as a bridge between the standard `argparse` module and the Textual TUI framework. It allows developers to automatically generate a terminal-based graphical interface for their command-line tools without rewriting their logic. This is particularly useful for scripts with numerous arguments or nested subcommands, as it provides a visual tree and form-based input system that simplifies user interaction and command discovery.

## Implementation Patterns

### 1. Adding a TUI Flag to Existing CLIs
The most common pattern is adding a specific argument (typically `--tui`) that, when triggered, launches the interface instead of executing the standard logic.

```python
from argparse import ArgumentParser
from argparse_tui import add_tui_argument

parser = ArgumentParser(description="My CLI Tool")
parser.add_argument("--count", type=int, help="Number of iterations")

# Adds the --tui argument to the parser
add_tui_argument(parser)

args = parser.parse_args()
# Standard logic follows...
```

### 2. Direct TUI Invocation
Use this pattern when you want to use `argparse` purely as a declarative DSL to build a TUI for an external application or a dedicated interactive tool.

```python
from argparse import ArgumentParser
from argparse_tui import invoke_tui

parser = ArgumentParser()
parser.add_argument("--api-key", help="Your API key")

# Immediately launches the TUI
invoke_tui(parser)
```

## Expert Tips and Best Practices

### Handling Sensitive Data
To prevent sensitive information (like passwords or API keys) from being displayed in plain text within the TUI, include the string `<secret>` in the argument's help text. `argparse-tui` will automatically redact these values in the interface.

```python
parser.add_argument("-p", "--password", help="User password <secret>")
```

### Pre-populating the TUI
You can pass arguments via the command line to pre-fill the TUI forms. This is useful for "correcting" a command or finishing a complex setup visually.
`$ my-script --count 10 --tui`
The TUI will open with the "count" field already set to 10.

### Navigation Shortcuts
The TUI supports Vim-style navigation and terminal-optimized shortcuts:
- **j / k**: Move selection down and up.
- **/**: Focus the search bar to filter commands.
- **Enter**: Focus the selected command or field.
- **Escape**: Return focus to the command tree.
- **Ctrl+y**: Copy the generated command string to the clipboard.

### Nested Subcommands
`argparse-tui` excels at visualizing complex hierarchies. If your CLI uses `add_subparsers()`, the TUI will render a sidebar tree allowing users to navigate through different command branches intuitively.

## Reference documentation
- [argparse-tui GitHub Repository](./references/github_com_fresh2dev_argparse-tui.md)
- [argparse-tui Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_argparse-tui_overview.md)