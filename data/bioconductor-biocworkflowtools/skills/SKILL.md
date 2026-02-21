---
name: bioconductor-biocworkflowtools
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocWorkflowTools.html
---

# bioconductor-biocworkflowtools

name: bioconductor-biocworkflowtools
description: Tools for authoring Bioconductor workflows and converting R Markdown documents to F1000Research-compliant LaTeX and PDF formats. Use this skill when a user needs to create a new workflow article, use the F1000Research template, convert Rmd to LaTeX/PDF for journal submission, or upload a workflow project to Overleaf.

## Overview

The `BiocWorkflowTools` package streamlines the process of publishing Bioconductor workflows. It allows authors to maintain a single R Markdown (Rmd) source file that can be rendered into both Bioconductor-style HTML and journal-specific LaTeX/PDF formats (specifically for F1000Research). This eliminates the need to manually manage separate Rnw and Rmd files.

## Creating a New Workflow

To start a new project using the F1000Research software article template:

```r
# Create a new directory and template file
rmarkdown::draft(
  file = "MyArticle.Rmd",
  template = "f1000_article",
  package = "BiocWorkflowTools",
  edit = FALSE
)
```

This command creates a folder containing:
- `MyArticle.Rmd`: The main template file.
- `f1000_styles.sty` and `F1000header.png`: Required formatting files (do not delete).
- `frog.jpg` and `sample.bib`: Example assets for images and citations.

## Converting to LaTeX and PDF

The package uses the `rmarkdown::render` engine to produce journal-ready outputs.

```r
# Render the Rmd file to PDF and LaTeX
rmarkdown::render("MyArticle.Rmd")
```

- **Output**: This generates both a `.tex` file (source for submission) and a `.pdf` file (for previewing) in the same directory.
- **RStudio**: Users can also click the **Knit** button to achieve the same result.

## Uploading to Overleaf

F1000Research uses Overleaf for its submission process. You can programmatically upload your entire project directory.

```r
library(BiocWorkflowTools)

# Upload the directory containing the Rmd, tex, and assets
uploadToOverleaf(files = "path/to/MyArticle_directory")
```

**Note**: While Overleaf allows editing, it cannot re-run R code chunks to update the LaTeX from the Rmd. It is recommended to perform primary edits in R/RStudio and use Overleaf only for the final submission conduit.

## Workflow Tips

- **Citations**: Use the `sample.bib` file as a template for BibTeX references.
- **Images**: Ensure images are referenced correctly in the Rmd so they carry over to the LaTeX environment.
- **Dependencies**: Ensure `BiocStyle` is installed, as it is often a dependency for Bioconductor workflow formatting.

## Reference documentation

- [Converting Rmarkdown to F1000Research LaTeX Format](./references/Generate_F1000_Latex.md)