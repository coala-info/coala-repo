---
name: bioconductor-biocthis
description: This tool automates the creation and maintenance of Bioconductor-friendly R packages by providing standardized templates and infrastructure. Use when user asks to initialize a new Bioconductor package, add Bioconductor-specific GitHub Actions and badges, style R code according to Bioconductor standards, or create compliant vignettes and documentation.
homepage: https://bioconductor.org/packages/release/bioc/html/biocthis.html
---

# bioconductor-biocthis

name: bioconductor-biocthis
description: Automate the creation and maintenance of Bioconductor-friendly R packages. Use this skill when a user needs to: (1) Initialize a new Bioconductor package with standard infrastructure, (2) Add Bioconductor-specific templates (GitHub Actions, badges, NEWS, README) to an existing project, (3) Style R code according to Bioconductor standards, or (4) Create Bioconductor-compliant vignettes and documentation.

# bioconductor-biocthis

## Overview

The `biocthis` package extends the `usethis` workflow to provide templates and functions specifically tailored for Bioconductor package development. It automates the creation of "developer scripts" that guide you through package initialization, Git/GitHub setup, core file creation (DESCRIPTION, README, NEWS), and continuous integration using Bioconductor-friendly GitHub Actions.

## Core Workflow: Initializing a Bioconductor Package

To start a new Bioconductor-compliant package, follow this sequence:

1.  **Create the base package**:
    Use `usethis::create_package("PackageName")` to initialize the directory structure.

2.  **Generate developer templates**:
    Run `biocthis::use_bioc_pkg_templates()` to create a `dev/` directory containing four guided R scripts:
    *   `01_create_pkg.R`: Initial setup and name checking.
    *   `02_git_github_setup.R`: Git initialization and GitHub repository creation.
    *   `03_core_files.R`: Creation of Bioconductor-friendly README, NEWS, CITATION, and GitHub Actions.
    *   `04_update.R`: Code styling and documentation updates.

## Key Functions and Usage

### Infrastructure and Metadata
*   **Bioconductor Badges**: Use `use_bioc_badges()` to add status, download, and support badges to your `README.Rmd`.
*   **Description**: Use `use_bioc_description()` to create a `DESCRIPTION` file pre-populated with `biocViews` and Bioconductor support links.
*   **News and Support**: Use `use_bioc_news_md()` and `use_bioc_support()` to create standard files that point users to the Bioconductor support site.

### Continuous Integration (GitHub Actions)
Use `use_bioc_github_action()` to set up a workflow that:
*   Runs `R CMD check` on Linux (using Bioconductor Docker), macOS, and Windows.
*   Runs `BiocCheck::BiocCheck()`.
*   Calculates test coverage via `covr`.
*   Deploys a `pkgdown` site with Bioconductor-themed CSS.

### Code Styling
Apply Bioconductor-compliant styling (based on Tidyverse but adjusted for Bioconductor standards) using:
```R
styler::style_pkg(transformers = biocthis::bioc_style())
```

### Documentation and Vignettes
*   **Vignettes**: Use `use_bioc_vignette("pkgname", "Title")` to create a template that includes `BiocStyle` formatting, installation instructions, and reproducibility sections.
*   **Pkgdown**: Use `use_bioc_pkgdown_css()` to add Bioconductor's official color scheme to your documentation website.

## Tips for Success
*   **Run within RStudio**: Many functions automatically open the generated files for immediate editing when used in the RStudio IDE.
*   **Check biocViews**: After running `use_bioc_description()`, ensure you manually refine the `biocViews` field to accurately categorize your package.
*   **GitHub Actions Caching**: The GHA workflow includes caching. If you encounter installation errors that seem related to stale environments, use the `/nocache` keyword in your commit message to force a fresh build.

## Reference documentation
- [Introduction to biocthis](./references/biocthis.md)
- [biocthis developer notes](./references/biocthis_dev_notes.md)