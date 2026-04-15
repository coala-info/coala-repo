---
name: r-markdown
description: This tool renders Markdown strings or files into HTML, LaTeX, and other formats in R using the commonmark engine. Use when user asks to convert Markdown to HTML or LaTeX, customize rendering options like Table of Contents or MathJax, or create lightweight documents without the overhead of R Markdown.
homepage: https://cloud.r-project.org/web/packages/markdown/index.html
---

# r-markdown

name: r-markdown
description: Render Markdown to HTML, LaTeX, and other formats in R using the 'commonmark' engine. Use this skill when you need to convert Markdown strings or files into documents, customize rendering options (like mathjax, syntax highlighting, or TOC), or create lightweight HTML outputs without the full overhead of R Markdown/Knitr.

# r-markdown

## Overview
The `markdown` package is a wrapper for the `commonmark` R package, providing a high-level interface to render Markdown into various output formats, primarily HTML and LaTeX. While it has been superseded by the `litedown` package for new development, it remains a standard tool for simple Markdown-to-HTML conversions in R.

## Installation
Install the package from CRAN:
```r
install.packages("markdown")
```

## Core Functions

### Rendering Markdown
The primary function is `mark()`, which converts Markdown to HTML or LaTeX.

```r
library(markdown)

# Render a string to HTML
html_output <- mark(text = "# Hello\nThis is **markdown**.")

# Render a file
mark("input.md", output = "output.html")

# Render to LaTeX
mark("input.md", format = "latex", output = "output.tex")
```

### Rendering to Files
Use `mark_html()` or `mark_latex()` as convenient wrappers for specific formats.

```r
# Create a full HTML document with a default stylesheet
mark_html("input.md", output = "document.html")
```

## Workflows and Options

### Customizing HTML Output
You can control the appearance and features of the output using the `options` argument or by passing a template.

```r
# Add a Table of Contents and MathJax support
mark_html(
  text = "# Header\n$e = mc^2$",
  options = list(toc = TRUE, mathjax = TRUE)
)
```

### Common Options
- `toc`: Logical; generate a Table of Contents.
- `number_sections`: Logical; add numbers to section headers.
- `section_divs`: Logical; wrap sections in `<div>` tags.
- `embed_resources`: Logical; embed images and CSS as base64 data URIs for a standalone file.
- `js_highlight`: Name of a JavaScript syntax highlighter (e.g., "highlight.js").

### Using Templates
For full control over the document structure, provide a custom HTML template.
```r
mark_html("input.md", template = "path/to/template.html")
```

## Tips
- **Superseded Status**: For new projects requiring advanced R Markdown features or active maintenance, consider using the `litedown` package.
- **Fragment vs. Full Document**: `mark()` returns an HTML fragment by default. Use `mark_html()` to produce a complete HTML document with `<head>` and `<body>` tags.
- **SmartyPants**: The package automatically handles "smart" punctuation (quotes, dashes) via the underlying commonmark engine.

## Reference documentation
- [Markdown rendering for R](./references/README.md)