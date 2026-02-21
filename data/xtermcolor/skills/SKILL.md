---
name: xtermcolor
description: xtermcolor is a Python library and command-line utility designed to simplify the process of styling terminal text.
homepage: https://github.com/broadinstitute/xtermcolor
---

# xtermcolor

## Overview

xtermcolor is a Python library and command-line utility designed to simplify the process of styling terminal text. It allows developers to apply foreground and background colors using either standard ANSI integer codes or hex RGB strings. The library is particularly useful for ensuring color compatibility across different terminal types (xterm and vt100) and provides a straightforward API for wrapping strings in the necessary escape sequences for colorized output.

## Command Line Usage

The `xtermcolor` command-line tool is primarily used for color conversion and palette visualization.

### Listing Colors
To view the full 256-color palette supported by the terminal:
```bash
xtermcolor list
```

### Converting RGB to ANSI
To find the closest ANSI color code or printf string for a specific hex color:
```bash
xtermcolor convert --color #FF5500
```

### Compatibility Modes
If working in a restricted environment, use the `--compat` flag to switch between `xterm` (default) and `vt100`:
```bash
xtermcolor convert --color #00FF00 --compat vt100
```

## Python API Integration

The core functionality is accessed via the `colorize` function.

### Basic Text Styling
Import the function and provide either an RGB string or an ANSI integer:
```python
from xtermcolor import colorize

# Using RGB hex values
print(colorize("Hello World", rgb='#ff0000'))

# Using ANSI codes
print(colorize("Hello World", ansi=196))
```

### Background Colors
Backgrounds can be set independently using `bg` (RGB) or `ansi_bg` (ANSI):
```python
# Red text on a blue background
print(colorize("Alert!", rgb='#FF0000', bg='#0000FF'))
```

### Best Practices and Constraints
- **Mutual Exclusivity**: You cannot provide both `rgb` and `ansi` for the same target (foreground or background). Similarly, `bg` and `ansi_bg` are mutually exclusive.
- **File Descriptors**: By default, `colorize` targets `stdout`. If you need to target `stderr` or a specific file, use the `fd` argument:
  ```python
  import sys
  print(colorize("Error occurred", rgb='#FF0000', fd=sys.stderr))
  ```
- **Input Types**: Ensure the first argument to `colorize` is a string. The library handles the insertion of reset codes automatically at the end of the string.

## Reference documentation
- [XTermColor: Easy Terminal Colors](./references/github_com_broadinstitute_xtermcolor.md)