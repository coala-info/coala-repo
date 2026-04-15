---
name: r-rttf2pt1
description: This package provides the ttf2pt1 utility to convert TrueType fonts into PostScript Type 1 format for use in R graphics. Use when user asks to convert fonts for the extrafont package, embed fonts in PDF or PostScript files, or manage system fonts for R graphics devices.
homepage: https://cloud.r-project.org/web/packages/Rttf2pt1/index.html
---

# r-rttf2pt1

name: r-rttf2pt1
description: Provides the 'ttf2pt1' utility for R, primarily used as a dependency for the 'extrafont' package to convert TrueType fonts to PostScript Type 1 format. Use this skill when users need to manage system fonts in R, specifically for embedding fonts in PDF or PostScript graphics devices.

# r-rttf2pt1

## Overview
The `r-rttf2pt1` package is a specialized utility package that contains the `ttf2pt1` program. Its primary purpose is to support the `extrafont` package by providing the necessary tools to convert TrueType fonts (.ttf) into PostScript Type 1 (.afm) files. This conversion is a critical step for R users who wish to use non-standard fonts in PDF or PostScript output.

## Installation
To install the package from CRAN:
```R
install.packages("Rttf2pt1")
```
*Note: This package compiles C code upon installation. Ensure a proper build environment (like Rtools on Windows or Xcode/build-essential on macOS/Linux) is available.*

## Usage and Workflow
This package is rarely called directly by users. Instead, it functions as a backend provider for the `extrafont` workflow.

### Integration with extrafont
The typical workflow involving `Rttf2pt1` is as follows:

1. **Import Fonts**: When you run `extrafont::font_import()`, the `extrafont` package utilizes the `ttf2pt1` executable provided by `Rttf2pt1` to process the font files.
2. **Register Fonts**: Use `extrafont::loadfonts()` to make the converted fonts available to R's graphics devices.
3. **Embed Fonts**: When saving plots, `extrafont::embed_fonts()` ensures the PostScript Type 1 versions are correctly embedded in the PDF.

### Locating the Executable
If you need to verify the location of the `ttf2pt1` binary within the R library:
```R
system.file("exec", "ttf2pt1", package = "Rttf2pt1")
```

## Troubleshooting
- **Compilation Errors**: If installation fails, check for missing compilers. On Windows, install Rtools. On macOS, install the Command Line Tools.
- **Maintenance Note**: The underlying `ttf2pt1` software is legacy code (last updated 2003). If conversion fails for modern Variable Fonts or OpenType fonts (.otf), consider using the `showtext` package as a modern alternative that does not require font conversion.

## Reference documentation
- [README](./references/README.md)