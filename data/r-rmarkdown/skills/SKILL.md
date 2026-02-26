---
name: r-rmarkdown
description: The r-rmarkdown package converts R Markdown files into high-quality documents by combining code, results, and prose. Use when user asks to render documents to various formats, manage output configurations, or apply advanced customizations like Lua filters and LaTeX environments.
homepage: https://cloud.r-project.org/web/packages/rmarkdown/index.html
---


# r-rmarkdown

## Overview
The `rmarkdown` package is a powerful framework for data science that combines code, rendering results, and prose into high-quality documents. It leverages `knitr` for code execution and `pandoc` for document conversion. This skill provides workflows for rendering documents, managing output formats, and using advanced features like Lua filters for pagebreaks and custom LaTeX environments.

## Installation
To install the package from CRAN:
```R
install.packages("rmarkdown")
```

## Core Workflow: Rendering Documents
The primary function is `rmarkdown::render()`. It converts an input file (usually `.Rmd`) to an output format.

```R
# Render to the default format specified in the YAML header
rmarkdown::render("analysis.Rmd")

# Render to a specific format
rmarkdown::render("analysis.Rmd", output_format = "pdf_document")

# Render with parameters
rmarkdown::render("report.Rmd", params = list(region = "East"))
```

## Common Output Formats
- `html_document`: Standard web-based reports.
- `pdf_document`: Requires a LaTeX installation (e.g., TinyTeX).
- `word_document`: Microsoft Word (.docx).
- `md_document`: Markdown for GitHub or other platforms.
- `odt_document`: OpenDocument Text.

## Advanced Customization with Lua Filters
Lua filters allow for document transformations that work across different output formats.

### Cross-Format Pagebreaks
Use `\newpage` or `\pagebreak` on a new line. `rmarkdown` uses a Lua filter to translate these into the correct syntax for HTML, Word, and ODT.
- **HTML**: Converts to `<div style="page-break-after: always;"></div>`.
- **Word**: Converts to an OpenXML page break.
- **ODT**: Requires a reference document with a "Pagebreak" paragraph style.

### Section Numbering
Enable section numbering in the YAML header. For formats like Word or ODT where Pandoc doesn't natively support numbering, `rmarkdown` applies a Lua filter automatically.
```yaml
output:
  word_document:
    number_sections: true
```

### Custom LaTeX Environments (Fenced Divs)
Convert "Fenced Divs" into LaTeX environments for PDF output using the `data-latex` attribute:
```markdown
::: {.verbatim data-latex=""}
This will be wrapped in \begin{verbatim} and \end{verbatim} in LaTeX.
:::
```

## Programmatic Format Creation
You can extend or create new output formats by modifying the `pandoc` options or `lua_filters` list.

```R
# Prepending a custom Lua filter to an existing format
custom_format <- function(...) {
  base_format <- rmarkdown::html_document(...)
  base_format$pandoc$lua_filters <- c(
    "my_filter.lua", 
    base_format$pandoc$lua_filters
  )
  base_format
}
```

## Tips for Success
- **YAML Header**: Always ensure your YAML header is correctly indented.
- **Chunk Options**: Use `knitr::opts_chunk$set()` in a setup chunk to define global behavior (e.g., `echo = FALSE`, `warning = FALSE`).
- **Parameters**: Use the `params` field in YAML to create reusable report templates.
- **Reference Docs**: For Word and ODT, use the `reference_docx` or `reference_odt` argument to control styling via a template file.

## Reference documentation
- [Lua filters in R Markdown](./references/lua-filters.Rmd)
- [Learn R Markdown](./references/rmarkdown.Rmd)