---
name: bioconductor-hubpub
description: The package provides the ability to create a skeleton of a Hub style package that the user can then populate with the necessary information. There are also functions to help add resources to the Hub package metadata files as well as publish data to the Bioconductor S3 bucket.
homepage: https://bioconductor.org/packages/release/bioc/html/HubPub.html
---

# bioconductor-hubpub

name: bioconductor-hubpub
description: Use this skill to create and manage Bioconductor Hub-style packages (AnnotationHub or ExperimentHub). It provides workflows for generating package skeletons, adding resource metadata to CSV files, and publishing data to Bioconductor S3 buckets. Use this when a user needs to develop a data-hosting package for Bioconductor or update existing Hub metadata.

## Overview

The `HubPub` package streamlines the creation and maintenance of Bioconductor Hub packages. Hub packages are lightweight R packages that do not contain large data files themselves; instead, they contain metadata and scripts that allow users to download curated data from remote storage (like AWS S3 or Azure) via the `AnnotationHub` or `ExperimentHub` clients.

## Core Workflows

### 1. Creating a New Hub Package Skeleton
Use `create_pkg()` to generate the directory structure and required files for a new Hub package.

```r
library(HubPub)
# Create an ExperimentHub package skeleton
create_pkg(path = "path/to/MyNewPackage", pkg_type = "ExperimentHub", use_git = TRUE)
```
This creates:
- `DESCRIPTION` & `NAMESPACE`: Pre-configured with Hub dependencies and biocViews.
- `inst/scripts/`: Contains `make-data.R` (data processing) and `make-metadata.R` (metadata generation).
- `inst/extdata/`: Directory for the `metadata.csv` file.
- `R/zzz.R`: (For ExperimentHub) Template for `.onLoad` accessors.

### 2. Defining Resource Metadata
Metadata must be formatted correctly for the Hub database. Use `hub_metadata()` to create a compliant list of attributes.

```r
meta_list <- hub_metadata(
    Title = "My_Dataset_V1",
    Description = "Description of the genomic resource",
    BiocVersion = "3.19",
    Genome = "hg38",
    SourceType = "RDA",
    SourceUrl = "https://original-data-source.org",
    SourceVersion = "1.0",
    Species = "Homo sapiens",
    TaxonomyId = 9606,
    Coordinate_1_based = TRUE,
    DataProvider = "University/Lab Name",
    Maintainer = "Your Name <your@email.com>",
    RDataClass = "SummarizedExperiment",
    DispatchClass = "Rda",
    RDataPath = "MyNewPackage/dataset_v1.rda",
    Tags = "RNASeq:Cancer:Spleen"
)
```

### 3. Adding Resources to the Package
Once the metadata list is created, append it to the package's `metadata.csv` file.

```r
add_resource("path/to/MyNewPackage", meta_list)
```

### 4. Publishing Data to Bioconductor S3
If you have been granted credentials by the Bioconductor team, you can upload files or directories directly to the S3 bucket.

```r
# Ensure AWS credentials are set in Sys.setenv() first
publish_resource("path/to/local/data_file.rda", "remote_folder_name")
```

## Key Package Components

- **inst/extdata/metadata.csv**: The heart of the Hub package. Each row is one resource.
- **DispatchClass**: Critical field. Use `Rda` for `save()`, `Rds` for `saveRDS()`, or `FilePath` to just return the raw path to the user.
- **Location_Prefix**: Only include this in metadata if hosting on your own server. If using Bioconductor's S3, leave it out; it is added automatically.

## Validation
Before submitting to Bioconductor, always validate the metadata using the appropriate HubData package:

```r
# For ExperimentHub
ExperimentHubData::makeExperimentHubMetadata("path/to/MyNewPackage")

# For AnnotationHub
AnnotationHubData::makeAnnotationHubMetadata("path/to/MyNewPackage")
```

## Reference documentation
- [Creating A Hub Package: ExperimentHub or AnnotationHub](./references/CreateAHubPackage.md)
- [HubPub: Help with publication of Hub packages](./references/HubPub.md)