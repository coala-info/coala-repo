---
name: r-knitr
description: The knitr package provides a general-purpose engine for dynamic report generation by integrating R code into various document formats. Use when user asks to generate reports from R Markdown, execute code chunks within documents, extract R code from source files, or customize how R objects are rendered in final outputs.
homepage: https://cloud.r-project.org/web/packages/knitr/index.html
---


# r-knitr

## Overview
The `knitr` package is a general-purpose tool for dynamic report generation in R. It integrates R code into various document formats (Markdown, LaTeX, HTML, etc.) and executes the code to produce a final document containing both the original text and the computed results (tables, plots, and text).

## Installation
To install the stable version from CRAN:
```r
install.packages("knitr")
```

## Core Workflow
The primary function is `knit()`, which processes a source file and produces an output file.

```r
library(knitr)
# Process an R Markdown file to Markdown
knit("input.Rmd", output = "output.md")
```

### Common Functions
- `knit()`: The main engine for transforming source documents to output.
- `purl()`: Extracts R code chunks from a literate programming document into a standalone R script.
- `knit_expand()`: A templating tool to replace `{{variable}}` placeholders with R values.
- `knit_print()`: An S3 generic function to customize how R objects are rendered in the final report.
- `asis_output()`: Marks a character string as "raw" output to be written directly into the document without further processing.

## Chunk Options
Chunk options control how code is executed and displayed. They are set globally via `opts_chunk$set()` or locally in the chunk header.

- `eval`: (TRUE/FALSE) Whether to evaluate the code chunk.
- `echo`: (TRUE/FALSE) Whether to display the source code in the output.
- `results`: ('markup', 'asis', 'hold', 'hide') How to display text results.
- `cache`: (TRUE/FALSE) Whether to cache results for future runs.
- `fig.width`, `fig.height`: Dimensions for R graphics.
- `include`: (TRUE/FALSE) Whether to include the chunk output in the final document (code still runs).

## Custom Printing
You can override the default printing behavior for specific classes by defining a `knit_print` method:

```r
knit_print.data.frame = function(x, ...) {
  res = paste(c('', '', kable(x)), collapse = '\n')
  asis_output(res)
}
registerS3method("knit_print", "data.frame", knit_print.data.frame)
```

## Templating with knit_expand
Use `knit_expand` for generating repetitive report sections:

```r
# Simple expansion
knit_expand(text = 'The value of pi is {{pi}}.')

# Loop through variables to create regression reports
src = lapply(names(mtcars)[2:3], function(i) {
  knit_expand(text = c("# Regression on {{i}}", "```{r}\nlm(mpg ~ {{i}}, data = mtcars)\n```"))
})
knit(text = unlist(src))
```

## Reference documentation
- [Display Tables with the JavaScript Library simple-datatables](./references/datatables.Rmd)
- [R Markdown with the Docco Classic Style](./references/docco-classic.Rmd)
- [R Markdown with the Docco Linear Style](./references/docco-linear.Rmd)
- [Templating with knit_expand()](./references/knit_expand.Rmd)
- [Custom Print Methods](./references/knit_print.Rmd)
- [Not An Introduction to knitr](./references/knitr-intro.Rmd)
- [R Markdown Vignettes with litedown](./references/knitr-markdown.Rmd)
- [knitr Reference Card](./references/knitr-refcard.Rmd)