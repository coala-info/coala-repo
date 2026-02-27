---
name: bioconductor-webbioc
description: This tool provides a web-based graphical interface for performing Bioconductor microarray analysis on Affymetrix data. Use when user asks to set up a web-based bioinformatics resource, upload and preprocess CEL files, perform differential expression analysis, or manage metadata annotation packages.
homepage: https://bioconductor.org/packages/release/bioc/html/webbioc.html
---


# bioconductor-webbioc

name: bioconductor-webbioc
description: Provides a web-based interface for Bioconductor microarray analysis, specifically for Affymetrix data. Use when the user needs to set up, configure, or understand the workflow of the webbioc system for processing CEL files, performing differential expression analysis, and annotating results without direct R command-line interaction.

# bioconductor-webbioc

## Overview

The `webbioc` package provides a graphical web interface for several Bioconductor microarray analysis packages. It is designed to act as a shared bioinformatics resource, allowing users to perform complex analyses—from raw CEL file uploads to biological metadata annotation—via a browser. While the package is primarily a Perl/CGI-based wrapper that generates R scripts in the background, it includes R functions for managing metadata packages.

## Typical Workflow

The `webbioc` system follows a linear pipeline for Affymetrix data analysis:

1.  **Upload Manager**: Users start a session, receive a session token, and upload CEL files.
2.  **Preprocessing (affy)**: Raw data is processed (typically using RMA) to produce an `ExpressionSet`.
3.  **Differential Expression (multtest)**: Statistical tests (e.g., t-tests) and multiple testing corrections (e.g., FDR) are applied to identify significant genes.
4.  **Annotation (annaffy)**: Significant probe sets are linked to biological metadata (LocusLink, Gene Ontology, PubMed, etc.).
5.  **Search**: Users can search biological metadata by keywords to find specific classes of genes.

## R Functions and Usage

While most interactions occur via the web interface, the R package provides essential administrative functions.

### Installing and Updating Metadata

To ensure the web interface has access to the latest chip annotations, use the `installReps` function. This downloads and installs/updates all metadata packages from the Bioconductor website.

```r
library(webbioc)
# Specify the path to your R library
installReps("/path/to/your/R/library")
```

### Data Interchange

`webbioc` uses standard R data files for passing information between modules.
- Files usually contain a single object.
- Files are named using the class of the stored object as the extension (e.g., `filename.ExpressionSet` or `filename.aafTable`).

## Configuration and Setup

The system is configured via a `Site.pm` Perl module. Key parameters include:
- `UPLOAD_DIR`: Path for uploaded CEL files.
- `RESULT_DIR`: Path for generated HTML and image results.
- `BATCH_SYSTEM`: Choice of execution method (`fork`, `sge`, or `pbs`).
- `R_BINARY`: Path to the R executable.

## Tips for Analysis

- **File Order**: Upload control samples before experimental samples in the Upload Manager to allow the interface to automatically assign class labels (0 for control, 1 for experimental).
- **Preprocessing**: RMA is recommended for demonstration and speed; custom methods can take significantly longer.
- **Annotation**: If an annotated HTML table returns no results, verify that the correct chip type was selected during the `annaffy` step.
- **Persistence**: Use the "Save Cookie" feature in the Upload Manager to store the session token in the browser for up to a week.

## Reference documentation

- [Written Script for Demonstrating webbioc](./references/demoscript.md)
- [Textual Description of webbioc](./references/webbioc.md)