---
name: pyfiglet
description: "pyfiglet transforms standard text into large, artistic ASCII banners using various font styles. Use when user asks to generate ASCII art text, render banners in the terminal, or create decorative text in Python scripts."
homepage: https://github.com/pwaller/pyfiglet
---


# pyfiglet

## Overview

pyfiglet is a pure Python implementation of the classic FIGlet utility, designed to transform standard text into large, artistic ASCII banners. It supports various font styles, including standard FIGlet (.flf) and TOILET (.tlf) formats. This tool is essential for developers who want to add visual flair to command-line interfaces or generate decorative text without relying on external C-based binaries.

## CLI Usage Patterns

The pyfiglet command-line interface allows for quick rendering of text directly from the terminal.

### Basic Rendering
Render text using the default 'standard' font:
```bash
pyfiglet "Your Text Here"
```

### Changing Fonts
Use the `-f` or `--font` flag to specify a different style (e.g., 'slant', 'block', 'bubble'):
```bash
pyfiglet -f slant "Slanted Text"
```

### Installing New Fonts
You can install additional fonts or ZIP collections of fonts using the `-L` flag. This may require elevated privileges depending on your installation:
```bash
pyfiglet -L my_new_font.flf
sudo pyfiglet -L fonts_collection.zip
```

## Python Library Integration

For dynamic rendering within Python scripts, pyfiglet provides both a class-based and a functional interface.

### Using the Figlet Class
The `Figlet` class is useful when you need to reuse the same font settings multiple times:
```python
from pyfiglet import Figlet

f = Figlet(font='slant')
print(f.renderText('text to render'))
```

### Using the Functional Interface
For one-off rendering tasks, use the `figlet_format` shortcut:
```python
import pyfiglet

output = pyfiglet.figlet_format("text to render", font="slant")
print(output)
```

## Expert Tips

- **Font Discovery**: If a specific font is missing from your distribution due to licensing, you can find a wide variety of compatible fonts at `http://www.jave.de/figlet/fonts.html`.
- **Output Consistency**: pyfiglet is designed to be a full port of FIGlet; its kerning and smushing logic should produce output identical to the original C implementation.
- **Zip Support**: Unlike the original FIGlet, pyfiglet allows your font collection to live inside a single ZIP file, which is convenient for distribution.

## Reference documentation

- [pwaller/pyfiglet README](./references/github_com_pwaller_pyfiglet.md)