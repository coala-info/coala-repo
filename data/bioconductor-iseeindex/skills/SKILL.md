---
name: bioconductor-iseeindex
description: This tool creates interactive landing pages for collections of Bioconductor datasets to facilitate data selection and visualization. Use when user asks to create a landing page for iSEE applications, manage dataset metadata with URI schemes, or configure custom branding for data portals.
homepage: https://bioconductor.org/packages/release/bioc/html/iSEEindex.html
---

# bioconductor-iseeindex

name: bioconductor-iseeindex
description: Create and customize interactive landing pages for collections of Bioconductor datasets using iSEEindex. Use this skill to configure iSEE applications that allow users to select from multiple datasets and initial configurations, manage remote or local data resources via URI schemes, and add custom branding to the app interface.

## Overview

The `iSEEindex` package extends the `iSEE` (Interactive SummarizedExperiment Explorer) ecosystem by providing a landing page interface. This allows maintainers to present users with a menu of available datasets and pre-defined visualization states. It uses `BiocFileCache` for efficient data handling and supports various resource locations (local, HTTPS, S3) through a unified URI scheme system.

## Installation

Install the package using `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("iSEEindex")
```

## Basic Workflow

To launch an `iSEEindex` application, you must provide a cache object and two functions that return metadata.

1.  **Initialize Cache**: Create a `BiocFileCache` object to manage downloaded datasets.
2.  **Define Dataset Function**: A function returning a list of metadata for available datasets.
3.  **Define Initial Configuration Function**: A function returning a list of metadata for initial app states.
4.  **Launch App**: Pass these to `iSEEindex()` and run with `shiny::runApp()`.

```r
library(iSEEindex)
library(BiocFileCache)

bfc <- BiocFileCache(cache = tempdir())

# Example metadata functions
dataset_fun <- function() {
    # Should return a list of dataset metadata
    list(
        dataset1 = list(URI = "https://example.com/data1.rds", ID = "ID1")
    )
}

initial_fun <- function() {
    # Should return a list of configuration metadata
    list(
        config1 = list(URI = "localhost://path/to/config.R", ID = "ID1")
    )
}

app <- iSEEindex(bfc, dataset_fun, initial_fun)

if (interactive()) {
    shiny::runApp(app)
}
```

## Resource URI Schemes

`iSEEindex` uses URIs to locate files. The prefix determines how the resource is accessed via the `precache()` method:

*   `https://`: Publicly accessible files online.
*   `localhost://`: Files present on the local filesystem (absolute or relative paths).
*   `rcall://`: Evaluates R code to find the file path (e.g., `rcall://system.file(...)`).
*   `s3://`: Files stored in Amazon S3 buckets (requires `paws.storage`).
*   `runr://`: Executes R code to generate the object directly in memory.

## Customizing the Landing Page

You can add custom UI elements above and below the dataset selection boxes using the `body.header` and `body.footer` arguments. It is recommended to wrap these in `shiny::fluidRow()`.

```r
library(shiny)
library(shinydashboard)

header <- fluidRow(
    box(width = 12, title = "Project Portal", "Welcome to the data index.")
)

footer <- fluidRow(
    box(width = 12, p("Copyright 2024", style = "text-align: center;"))
)

app <- iSEEindex(bfc, dataset_fun, initial_fun,
                 body.header = header,
                 body.footer = footer)
```

## Tips for Maintainers

*   **Caching**: `iSEEindex` automatically handles caching. On the first run, `precache()` downloads/processes the URI; subsequent runs fetch the file from `BiocFileCache`.
*   **Images**: If using images in headers/footers, use `shiny::addResourcePath()` to make the local directory accessible to the Shiny server.
*   **Metadata**: The functions passed to `iSEEindex` can perform complex logic, such as fetching metadata from a database or a remote YAML file.

## Reference documentation

- [Adding a custom header and footer to the landing page](./references/header.md)
- [Introduction to iSEEindex](./references/iSEEindex.md)
- [Implementing custom iSEEindex resources](./references/resources.md)