---
name: bioconductor-experimenthubdata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ExperimentHubData.html
---

# bioconductor-experimenthubdata

name: bioconductor-experimenthubdata
description: Tools for adding, formatting, and validating metadata for Bioconductor ExperimentHub resources. Use this skill when preparing R/Bioconductor objects (GRanges, SummarizedExperiment, etc.) for submission to ExperimentHub, creating ExperimentHub-enabled packages, or validating metadata.csv files using makeExperimentHubMetadata.

# bioconductor-experimenthubdata

## Overview

The `ExperimentHubData` package is the administrative counterpart to `ExperimentHub`. While `ExperimentHub` is used by researchers to consume data, `ExperimentHubData` is used by developers to contribute data. It provides the infrastructure to transform raw metadata into the standardized formats required by the Bioconductor hub ecosystem.

The primary workflow involves taking curated data objects (typically saved as `.rda` or `.rds` files on a web server or AWS S3) and describing them in a `metadata.csv` file. `ExperimentHubData` then validates this metadata to ensure it can be correctly indexed and searched by users.

## Core Workflows

### Metadata Validation
The most critical function for developers is validating the `inst/extdata/metadata.csv` file required for an ExperimentHub package.

```r
library(ExperimentHubData)

# Validate a metadata.csv file
# This checks for required columns: Title, Description, BiocVersion, Genome, 
# SourceType, SourceUrl, SourceVersion, Species, TaxonomyId, Coordinate_1_based,
# DataProvider, Maintainer, RDataClass, DispatchClass, ResourceName
metadata <- makeExperimentHubMetadata("path/to/your/package/inst/extdata")

# If successful, 'metadata' will be a list of ExperimentHubMetadata objects.
# If it fails, the error messages will indicate which fields are missing or malformed.
```

### Key Metadata Fields
When creating the `metadata.csv`, ensure the following fields are correctly specified for `ExperimentHub`:
- **RDataClass**: The R class of the object (e.g., `SummarizedExperiment`, `GRanges`).
- **DispatchClass**: Determines how the file is loaded (e.g., `Rda` for .rda files, `Rds` for .rds files).
- **Location_Prefix**: The base URL where the data is hosted.
- **RDataPath**: The path to the file relative to the Location_Prefix.

### Creating a Hub Package
`ExperimentHubData` works in tandem with the `HubPub` package. To start a new ExperimentHub package:

1. Use `HubPub::createHubPackage()` to generate the directory structure.
2. Place your data objects in a publicly accessible location (S3, Zenodo, etc.).
3. Populate `inst/extdata/metadata.csv`.
4. Run `makeExperimentHubMetadata()` to verify the setup.

## Testing Environments
For advanced users needing to test database insertions, the `ExperimentHub_docker` container provides a local instance of the ExperimentHub database. However, for most contributors, passing the `makeExperimentHubMetadata()` check is sufficient for submission to Bioconductor.

## Reference documentation
- [Introduction to ExperimentHubData](./references/ExperimentHubData.md)