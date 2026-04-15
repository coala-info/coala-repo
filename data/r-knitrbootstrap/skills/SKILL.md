---
name: r-knitrbootstrap
description: The knitrbootstrap package creates responsive, Bootstrap-styled HTML reports from R Markdown with features like dynamic theme switching and lightboxed images. Use when user asks to create Bootstrap-styled reports, render R Markdown documents with interactive style choosers, or add visibility toggles for code and output in HTML files.
homepage: https://cran.r-project.org/web/packages/knitrbootstrap/index.html
---

# r-knitrbootstrap

## Overview
The `knitrbootstrap` package provides a framework to create modern, responsive Bootstrap-styled HTML reports from R Markdown. It extends the standard `knitr` and `rmarkdown` capabilities by adding features such as lightboxed images, dynamic style choosers for both the document theme and code highlighting, and the ability to toggle the visibility of code, output, and plots.

## Installation
Install the package from CRAN:
```R
install.packages('knitrBootstrap')
```

## Usage

### YAML Front-matter
The most common way to use `knitrbootstrap` is by specifying it as the output format in your Rmd file's YAML header.

```yaml
---
title: "My Analysis Report"
output:
  knitrBootstrap::bootstrap_document:
    title: "Report Title"
    theme: amelia
    highlight: sunburst
    theme.chooser: TRUE
    highlight.chooser: TRUE
---
```

### Rendering via Function
You can programmatically render a document using the `rmarkdown::render` function:

```R
library(knitrBootstrap)
library(rmarkdown)
render('analysis.Rmd', 'knitrBootstrap::bootstrap_document')
```

## Options

### Package Options (YAML or Global)
These control the overall document behavior:
- `bootstrap.theme`: Set the default Bootswatch style (e.g., cerulean, cosmo, flatly, slate).
- `bootstrap.highlight`: Set the default code style (e.g., sunburst, zenburn, monokai).
- `bootstrap.theme.chooser`: (`TRUE`/`FALSE`) Adds a dropdown to change themes dynamically in the browser.
- `bootstrap.highlight.chooser`: (`TRUE`/`FALSE`) Adds a dropdown to change code highlighting dynamically.
- `bootstrap.menu`: (`TRUE`/`FALSE`) Whether to include the navigation menu.

### Chunk Options
These control specific R code chunks:
- `bootstrap.thumbnail`: (`TRUE`/`FALSE`) Automatically thumbnail and lightbox images.
- `bootstrap.thumbnail.size`: Bootstrap column size (e.g., `'col-md-6'`).
- `bootstrap.show.code`: (`TRUE`/`FALSE`) Whether code starts as visible.
- `bootstrap.show.output`: (`TRUE`/`FALSE`) Whether output starts as visible.
- `bootstrap.panel`: (`TRUE`/`FALSE`) Use panels instead of buttons for toggling.

## Features
- **Responsive Design**: Uses Bootstrap 3.0 for compatibility across screen sizes.
- **Automatic TOC**: Generates a table of contents from h1-h4 tags.
- **Image Handling**: Images are centered and use Magnific Popup for lightboxing.
- **Offline Support**: Can create completely self-contained reports (excluding MathJax).
- **Visibility Toggles**: Users can click to hide/show code or output globally or per chunk.

## Reference documentation
- [NEWS](./references/NEWS.md)
- [README](./references/README.md)
- [Articles](./references/articles.md)
- [CRAN Comments](./references/cran-comments.md)
- [Home Page](./references/home_page.md)
- [Wiki](./references/wiki.md)