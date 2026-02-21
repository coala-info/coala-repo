---
name: bioconductor-biocstyle
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocStyle.html
---

# bioconductor-biocstyle

name: bioconductor-biocstyle
description: Provides specialized formatting and styling for Bioconductor R package vignettes and reports. Use this skill when creating or editing R Markdown (.Rmd) or Sweave (.Rnw) documents to ensure they adhere to Bioconductor's visual standards, including specific macros for linking to packages, handling figure layouts, and managing author affiliations.

## Overview

`BiocStyle` is the standard R package for styling Bioconductor vignettes. It provides output formats for HTML and PDF that extend `rmarkdown` and `bookdown`, ensuring consistent typography, margin notes, and cross-referencing. It also includes helper functions (macros) to link to Bioconductor, CRAN, and GitHub packages automatically.

## Typical Workflows

### 1. R Markdown (Modern Workflow)
To use `BiocStyle` in an `.Rmd` file, configure the YAML header to use `BiocStyle::html_document` or `BiocStyle::pdf_document`.

```yaml
---
title: "Vignette Title"
author: 
- name: Author Name
  affiliation: Institution
  email: author@example.com
package: YourPackageName
output:
  BiocStyle::html_document:
    toc_float: true
vignette: >
  %\VignetteIndexEntry{Vignette Title}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---
```

### 2. Sweave/knitr (.Rnw Workflow)
For PDF vignettes using LaTeX-based formats, call `BiocStyle::latex()` in the preamble.

```latex
<<style-knitr, eval=TRUE, echo=FALSE, results="asis">>=
BiocStyle::latex()
@
```

### 3. Package Configuration
Ensure your `DESCRIPTION` file includes the necessary dependencies:
```
VignetteBuilder: knitr
Suggests: BiocStyle, knitr, rmarkdown
```

## Key Functions and Macros

### Linking to Packages
Use these inline R expressions to create standardized links:
- `` `r BiocStyle::Biocpkg("IRanges")` ``: Links to a Bioconductor package landing page.
- `` `r BiocStyle::CRANpkg("data.table")` ``: Links to a CRAN package.
- `` `r BiocStyle::Githubpkg("rstudio/rmarkdown")` ``: Links to a GitHub repository.
- `` `r BiocStyle::Rpackage("MyPkg")` ``: Formats a package name not on major repositories.

### Figure and Table Handling
`BiocStyle` supports advanced layout options via `knitr` chunk options:
- `fig.wide = TRUE`: Extends the figure into the right margin.
- `fig.small = TRUE`: Creates a smaller, centered figure.
- `fig.cap`: Automatically generates labels (e.g., `fig:chunk-label`) for cross-referencing with `\@ref(fig:chunk-label)`.

### Cross-Referencing
Use `bookdown` syntax for consistent referencing across formats:
- Sections: `\@ref(section-id)`
- Figures: `\@ref(fig:chunk-label)`
- Tables: `\@ref(tab:chunk-label)`
- Equations: `\@ref(eq:label)` (requires `(\#eq:label)` inside the equation environment).

## Best Practices
- **Author Affiliations**: Use the YAML list format for multiple authors to ensure correct rendering of affiliations and emails.
- **Floating TOC**: In HTML, use `toc_float: true` within the `output` block for better navigation.
- **Margin Notes**: Use standard footnotes `^[This is a footnote]` in Rmd; `BiocStyle` will automatically render these as side notes in the wide right margin.
- **Avoid Manual Widths**: `BiocStyle` automatically sets `options(width = 80)` to fit the styled page; do not override this manually unless necessary.

## Reference documentation
- [Authoring R Markdown vignettes](./references/AuthoringRmdVignettes.md)
- [Bioconductor LaTeX Style 2.0](./references/LatexStyle2.md)