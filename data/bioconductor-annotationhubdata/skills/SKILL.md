---
name: bioconductor-annotationhubdata
description: AnnotationHubData provides the infrastructure for processing, annotating, and generating metadata for large-scale genomic data distributed via AnnotationHub. Use when user asks to create metadata objects for new resources, write data processing recipes, or validate genomic data for Bioconductor hub submission.
homepage: https://bioconductor.org/packages/release/bioc/html/AnnotationHubData.html
---

# bioconductor-annotationhubdata

## Overview

The `AnnotationHubData` package provides the infrastructure for the Bioconductor Core Team and advanced developers to process, annotate, and store large-scale genomic data for distribution via `AnnotationHub`. While most users consume data through the `AnnotationHub` client, this package is used for the "backend" work: writing recipes that download raw files (from NCBI, UCSC, Ensembl, etc.), processing them into R-friendly formats, and generating the required metadata for the Hub database.

## Core Workflows

### 1. Understanding the Metadata Schema
Every resource in AnnotationHub requires a `Metadata` object. Key fields include:
- `Title`, `Description`, `BiocVersion`
- `Genome`, `Species`, `TaxonomyId`
- `SourceUrl`, `SourceType`, `SourceVersion`
- `DataProvider`, `Maintainer`
- `RDataClass` (e.g., GRanges, TxDb, EnsDb)
- `DispatchClass` (how the hub client should load the data)

### 2. Creating Metadata for New Resources
The primary entry point for adding data is creating a metadata CSV file or a function that returns a `AnnotationHubMetadata` object.

```r
library(AnnotationHubData)

# Example of manual metadata construction (usually automated via recipes)
meta <- AnnotationHubMetadata(
    Title = "Example Resource",
    Description = "Description of the genomic data",
    BiocVersion = biocVersion(),
    Genome = "hg38",
    Species = "Homo sapiens",
    TaxonomyId = 9606,
    SourceUrl = "https://example.com/rawdata.bed",
    SourceType = "BED",
    SourceVersion = "v1",
    DataProvider = "ExampleProvider",
    Maintainer = "User <user@example.com>",
    RDataClass = "GRanges",
    DispatchClass = "GRanges",
    ResourceName = "example_resource.Rda"
)
```

### 3. Data Recipes
Recipes are R scripts that automate the transformation of raw source files into R objects.
- Recipes typically reside in the `inst/scripts` directory of a data provider package.
- They use `AnnotationHubData` functions to validate that the resulting object matches the metadata description.

### 4. Validation
Before submitting data to the Bioconductor team, use validation checks to ensure the metadata is formatted correctly.
- Ensure `TaxonomyId` matches official NCBI identifiers.
- Ensure `Genome` strings match standard conventions (e.g., "hg38" vs "GRCh38").
- Verify that `SourceUrl` is reachable.

## Usage Tips
- **Transition to HubPub**: For modern development of AnnotationHub packages, much of the high-level workflow has moved to the `HubPub` package. Use `AnnotationHubData` specifically for low-level metadata object manipulation and historical recipe reference.
- **Historical Recipes**: If you are tasked with updating an existing resource (like UCSC chain files or Ensembl GTFs), look in `system.file("scripts", package="AnnotationHubData")` for the original processing logic.
- **DispatchClass**: This is critical. It tells the `AnnotationHub` client which method to use to load the file (e.g., `FilePath` for raw files, `Rda` for R objects, `GRanges` for specific genomic intervals).

## Reference documentation

- [Introduction to AnnotationHubData](./references/IntroductionToAnnotationHubData.md)