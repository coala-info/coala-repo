---
name: r-r2html
description: This tool exports R objects, console output, and plots into formatted HTML reports and files. Use when user asks to generate HTML-based statistical reports, redirect R console output to HTML in real-time, create sortable data tables, or embed R plots and LaTeX equations into HTML documents.
homepage: https://cloud.r-project.org/web/packages/R2HTML/index.html
---

# r-r2html

name: r-r2html
description: Export R objects to HTML reports and files. Use this skill when you need to generate HTML-based statistical reports, redirect R console output to an HTML file in real-time, create sortable HTML data tables, or embed R plots and LaTeX equations into HTML documents.

# r-r2html

## Overview
The `R2HTML` package provides a versatile suite of functions to export R objects (data frames, matrices, summaries, etc.) into HTML format. It supports both "batch" report generation (initializing a file and appending objects) and "real-time" redirection where all console output is mirrored to an HTML file.

## Installation
```R
install.packages("R2HTML")
library(R2HTML)
```

## Core Workflows

### 1. Manual Report Generation
This is the standard workflow for building a structured report.
1. **Initialize**: Create the file and set up CSS/headers.
2. **Append**: Add titles, text, tables, and graphs.
3. **Close**: Finalize the HTML tags.

```R
# 1. Setup
target <- HTMLInitFile(outdir = tempdir(), filename = "my_report", Title = "Analysis Results")

# 2. Add Content
HTML.title("Summary Statistics", HR = 1, file = target)
HTML(summary(iris), file = target)

# Add a plot
plot(iris$Sepal.Length, iris$Sepal.Width)
HTMLplot(Caption = "Iris Sepal Dimensions", file = target)

# 3. Finalize
HTMLEndFile(file = target)
```

### 2. Automatic Redirection (Teaching/Logging Mode)
Use `HTMLStart()` to redirect all subsequent console output to an HTML file automatically.
```R
HTMLStart(outdir = tempdir(), filename = "interactive_log", echo = TRUE)
# All output from these commands goes to the HTML file
as.title("Step 1: Data Loading")
data(mtcars)
head(mtcars)
HTMLStop() # Stop redirection
```

## Key Functions

### Tables and Data
- `HTML(x, ...)`: Generic method to export objects.
- `HTML.data.frame(x, ...)`: Highly customizable table export. Supports `sortableDF = TRUE` (requires `tablesort.htc` in the same directory).
- `HTML.cormat(x, ...)`: Specifically for correlation matrices; includes "traffic highlighting" (color-coding correlations).

### Formatting and Layout
- `HTML.title(text, HR = 1)`: Adds `<H1>` through `<H6>` tags.
- `HTMLbr(n)`: Inserts `n` line breaks.
- `HTMLhr()`: Inserts a horizontal rule.
- `as.latex(string)`: Converts LaTeX strings to MathML (requires `useLaTeX = TRUE` in `HTMLInitFile`).

### Graphics
- `HTMLplot()`: Captures the current active R device and saves it as a PNG/JPG, then inserts the link into the HTML.
- `HTMLInsertGraph(FileName)`: Inserts a link to an existing image file.

## Tips and Best Practices
- **CSS Customization**: Use `HTMLChangeCSS(newCSS = "Pastel")` to change the visual style of the report.
- **File Management**: `HTMLInitFile` returns the path to the target file. Store this in a variable (e.g., `target`) to avoid re-typing the path in every `HTML()` call.
- **Clipboard**: On Windows, `HTML2clip(x)` quickly copies an R object as an HTML table to the clipboard for pasting into Word or Excel.
- **Interactive Use**: When using `HTMLStart()`, setting `autobrowse = TRUE` will refresh your web browser every time a new command is executed.

## Reference documentation
- [R2HTML Reference Manual](./references/reference_manual.md)