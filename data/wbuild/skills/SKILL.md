---
name: wbuild
description: wbuild is a specialized tool designed to streamline the creation of R-based report galleries.
homepage: https://github.com/gagneurlab/wBuild
---

# wbuild

## Overview
wbuild is a specialized tool designed to streamline the creation of R-based report galleries. It functions by scanning a project's directory for R-markdown files, parsing Snakemake rules embedded in their headers, and generating a master workflow to render them. This ensures that reports are only re-run when their specific dependencies change, and the final output is organized into a web-accessible format.

## Core CLI Usage
- **Initialize a new project**: Run `wbuild init` in your project root to set up the required directory structure and configuration files.
- **Explore features**: Run `wbuild demo` in an empty directory to generate a sample project. This is the most effective way to understand how headers and directory structures are interpreted.
- **Execute the build**: Run `snakemake` after initialization. Because wbuild generates the underlying Snakefile logic, you can use standard Snakemake flags such as `--cores` or `--dry-run`.

## Workflow Best Practices
- **Script Placement**: Store all R-markdown (.Rmd) or R scripts (.R) within the `Scripts/` folder. wbuild uses this directory hierarchy to automatically build the navigation menu in the resulting HTML output.
- **Embedded Rules**: Define Snakemake rules directly in the R script header. This keeps the data processing logic and the visualization code in a single, reproducible file.
- **Output Inspection**: After a successful run, the rendered reports and the interactive dependency graph are located at `Output/html/index.html`.
- **Environment Requirements**: Ensure `snakemake`, `pandoc`, and `graphviz` are available in your PATH, as wbuild relies on these for document rendering and rule-graph visualization.

## Reference documentation
- [wBuild GitHub Repository](./references/github_com_gagneurlab_wBuild.md)
- [wBuild Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_wbuild_overview.md)