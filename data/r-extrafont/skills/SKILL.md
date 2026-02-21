---
name: r-extrafont
description: "Tools to using fonts other than the standard PostScript fonts.     This package makes it easy to use system TrueType fonts and with PDF or     PostScript output files, and with bitmap output files in Windows. extrafont     can also be used with fonts packaged specifically to be used with, such as     the fontcm package, which has Computer Modern PostScript fonts with math     symbols.</p>"
homepage: https://cloud.r-project.org/web/packages/extrafont/index.html
---

# r-extrafont

## Overview
The `extrafont` package facilitates the use of system fonts (TrueType) and specialized font packages in R. It solves two primary hurdles: making R aware of font metrics for character placement and embedding font glyphs into PDF/PostScript files so they render correctly on other devices.

## Installation
```R
install.packages("extrafont")
library(extrafont)
```
Note: This automatically installs `extrafontdb` (the database) and `Rttf2pt1` (the font manipulation engine). Ghostscript must be installed on the system to embed fonts.

## Workflow

### 1. Initial Setup (One-time)
Import system fonts into the `extrafont` database. This scans for TrueType fonts and creates font metrics (.afm files).
```R
font_import()
# Confirm with 'y' when prompted to scan system directories
```

### 2. Session Initialization
Register the imported fonts with R's graphics devices.
```R
loadfonts(device = "pdf")      # For PDF output
loadfonts(device = "postscript") # For PostScript output
loadfonts(device = "win")       # For Windows bitmap/on-screen output
```
*Note: In versions > 0.13, `library(extrafont)` handles registration automatically after the initial import.*

### 3. Creating Graphics
Use the `family` argument in base R or `theme(text = element_text(family = "..."))` in ggplot2.

**Base R Example:**
```R
pdf("plot.pdf", family = "Arial Black")
plot(mtcars$mpg, mtcars$wt, main = "Title in Arial Black")
dev.off()
```

**ggplot2 Example:**
```R
library(ggplot2)
p <- ggplot(mtcars, aes(wt, mpg)) + 
  geom_point() +
  theme(text = element_text(family = "Impact", size = 14))
ggsave("ggplot.pdf", plot = p)
```

### 4. Embedding Fonts
Crucial for PDF portability. Without embedding, the PDF may not display correctly on devices lacking the specific font.

**Windows Ghostscript Setup:**
```R
# Required once per session on Windows
Sys.setenv(R_GSCMD = "C:/Program Files/gs/gs9.XX/bin/gswin32c.exe")
```

**Embedding Command:**
```R
embed_fonts("plot.pdf", outfile = "plot_embedded.pdf")
```

## Utility Functions
- `fonts()`: Returns a vector of available font family names.
- `fonttable()`: Returns a detailed data frame of all registered fonts, including FontName, family, and file paths.
- `font_import(paths = "/custom/path")`: Import fonts from a specific directory.

## Troubleshooting
- **Missing Fonts**: If `fonts()` doesn't show a font you just installed, run `font_import()` again.
- **Ghostscript Errors**: Ensure the path to the Ghostscript executable is correctly set in `R_GSCMD`.
- **Warnings**: "Unknown characters" warnings during PDF creation are usually harmless.
- **Reset Database**: If the font database becomes corrupted, run `install.packages("extrafontdb")`.

## Reference documentation
- [extrafont README](./references/README.md)