---
name: bioconductor-anvilpublish
description: the package (e.g., select information from the package DESCRIPTION file and from vignette YAML headings) are used to populate the 'DASHBOARD'. Vignettes are translated to python notebooks ready for evaluation in AnVIL.
homepage: https://bioconductor.org/packages/release/bioc/html/AnVILPublish.html
---

# bioconductor-anvilpublish

name: bioconductor-anvilpublish
description: Create and update AnVIL workspaces from R/Bioconductor packages or collections of Rmarkdown files. Use this skill when you need to publish R resources to the AnVIL platform, convert vignettes into Jupyter notebooks for the AnVIL environment, or manage workspace permissions for Bioconductor users.

# bioconductor-anvilpublish

## Overview

The `AnVILPublish` package automates the process of transforming R packages and Rmarkdown documents into functional AnVIL workspaces. It uses the package `DESCRIPTION` file and vignette `YAML` headers to populate the workspace 'DASHBOARD' and converts vignettes into Jupyter notebooks (.ipynb) accessible via the 'NOTEBOOKS' tab.

## Prerequisites

Before using `AnVILPublish`, ensure the following environment requirements are met:

1.  **Google Cloud SDK**: Required for copying files to the workspace bucket.
    ```r
    GCPtools::gcloud_exists()
    GCPtools::gcloud_account()
    GCPtools::gcloud_project()
    ```
2.  **Quarto**: Required for converting `.Rmd` or `.Qmd` files to Jupyter notebooks.
    ```r
    system2("quarto", "--version")
    ```
3.  **Platform**: Currently, this package only supports Google Cloud Platform (GCP) workspaces.

## Core Workflows

### 1. Publishing an R Package to AnVIL

To create a workspace from a local package source (e.g., a GitHub clone), use `as_workspace()`. This function automatically handles notebook conversion and dashboard population.

```r
AnVILPublish::as_workspace(
    "path/to/package",
    "your-billing-project",
    create = TRUE  # Use update = TRUE for existing workspaces
)
```

*   **Workspace Name**: By default, it creates a workspace named `Bioconductor-Package-<pkgname>`.
*   **Metadata**: Ensure the `DESCRIPTION` file has accurate Title, Version, Authors@R, Description, and License fields.

### 2. Publishing Collections of Rmd Files

For resources like bookdown sites that are not structured as packages:

1.  Add a standard `DESCRIPTION` file to the directory.
2.  Include `Package: <Identifier>` and `Type: Workshop` fields.
3.  Ensure each `.Rmd` file has a YAML header with `title` and `author`.
4.  Run the publishing command:

```r
AnVILPublish::as_workspace(
    "path/to/directory",
    "your-billing-project",
    create = TRUE
)
```

### 3. Updating Notebooks Separately

If you only need to update the notebooks without modifying the dashboard:

```r
AnVILPublish::as_notebook(
    "paths/to/files.Rmd",
    "your-billing-project",
    "Workspace-Name",
    update = TRUE
)
```

### 4. Managing Permissions

To share the workspace with the standard Bioconductor user group on AnVIL:

```r
AnVILPublish::add_access(
    "your-billing-project",
    "Workspace-Name"
)
```

## Best Practices for Vignettes

*   **Code Chunks**: All code chunks (even those with `eval=FALSE`) are converted to visible, evaluated cells in Jupyter. To prevent evaluation in the notebook, wrap code in HTML `<pre></pre>` tags instead of R chunks.
*   **Ordering**: Use a numeric prefix in both filenames (e.g., `01-intro.Rmd`) and YAML titles (e.g., `title: "01 Introduction"`) to ensure correct ordering in the AnVIL interface.
*   **Language**: While Rmd supports multiple languages, the conversion process currently treats all cells as R code.
*   **Data Tables**: Place CSV files in `inst/tables`. You can use `{{ bucket }}` as a placeholder in these CSVs to dynamically reference the workspace bucket path.

## Reference documentation

- [AnVILPublish Introduction](./references/AnVILPublishIntro.md)