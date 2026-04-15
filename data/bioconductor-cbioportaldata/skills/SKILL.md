---
name: bioconductor-cbioportaldata
description: The cBioPortalData package provides a programmatic interface to download and import cancer genomics data from cBioPortal into Bioconductor MultiAssayExperiment objects. Use when user asks to identify available cancer studies, download bulk genomic data packs, or perform granular API queries for specific genes and molecular profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/cBioPortalData.html
---

# bioconductor-cbioportaldata

## Overview
The `cBioPortalData` package provides a programmatic interface to the cBioPortal for Cancer Genomics. It allows users to identify available cancer studies and download data in two primary ways: as bulk zipped tarballs (`cBioDataPack`) or via granular API queries (`cBioPortalData`). The package integrates seamlessly with the Bioconductor ecosystem, representing multi-omic data as `MultiAssayExperiment` objects, which coordinate clinical data with various experimental assays like `SummarizedExperiment` (expression) and `RaggedExperiment` (mutations).

## Basic Workflow

### 1. Initialization and Study Discovery
To begin, initialize the API object and list available studies.
```r
library(cBioPortalData)
library(AnVIL)

# Initialize the API client
cbio <- cBioPortal()

# List all available studies and check build status
studies <- getStudies(cbio, buildReport = TRUE)
head(studies[, c("studyId", "name", "api_build", "pack_build")])
```

### 2. Downloading Data
Choose a method based on whether you need the full study or a specific subset.

**Method A: Bulk Download (cBioDataPack)**
Best for obtaining the entire study as curated by the cBioPortal team.
```r
# Download a full study (e.g., Acute Myeloid Leukemia)
laml <- cBioDataPack("laml_tcga", ask = FALSE)
```

**Method B: Granular API Query (cBioPortalData)**
Best for specific genes, molecular profiles, or sample lists.
```r
# Query specific genes and profiles for Adrenocortical Carcinoma
acc <- cBioPortalData(
    api = cbio,
    studyId = "acc_tcga",
    genes = c("TP53", "CTNNB1", "ZNRF3"),
    by = "hugoGeneSymbol",
    molecularProfileIds = c("acc_tcga_linear_CNA", "acc_tcga_mutations")
)
```

### 3. Exploring the MultiAssayExperiment
Once downloaded, the data is structured for easy access.
```r
# View experiments
experiments(acc)

# Access clinical/phenotype data
colData(acc)

# Extract a specific assay (e.g., mutations)
assay(acc[["acc_tcga_mutations"]])
```

## Advanced API Usage
For developers needing specific endpoints not covered by high-level functions, use the `$` operator on the API object.

```r
# Search for specific operations (e.g., clinical)
searchOps(cbio, "clinical")

# Get specific gene info
resp <- cbio$getGeneUsingGET(geneId = "BRCA1")
httr::content(resp)

# List molecular profiles for a study
mols <- molecularProfiles(cbio, "acc_tcga")
```

## Data Migration (from cgdsr)
If migrating from the defunct `cgdsr` package, use these mappings:
- `getCancerStudies` -> `getStudies(cbio)`
- `getCaseLists` -> `sampleLists(cbio, studyId)`
- `getClinicalData` -> `clinicalData(cbio, studyId)`
- `getGeneticProfiles` -> `molecularProfiles(cbio, studyId)`
- `getProfileData` -> `getDataByGenes(cbio, ...)` or `cBioPortalData(...)`

## Maintenance and Troubleshooting
- **Cache Management**: If a download is interrupted, clear the cache.
  - Specific study: `removeCache("study_id")`
  - Entire cache: `unlink("~/.cache/cBioPortalData/", recursive = TRUE)`
- **Build Reports**: Some studies may fail to build into `MultiAssayExperiment` due to upstream data inconsistencies. Check `getStudies(cbio, buildReport = TRUE)` to see if `api_build` or `pack_build` is `FALSE`.
- **Manual Download**: If a study fails to build, use `downloadStudy()`, `untarStudy()`, and `loadStudy()` for manual curation.

## Reference documentation
- [cBioPortalData: User Guide](./references/cBioPortalData.md)
- [cBioPortalData: Data Build Errors](./references/cBioPortalDataErrors.md)
- [cBioPortalData: API Reference Guide for Devs](./references/cBioPortalRClient.md)
- [cgdsr to cBioPortalData: Migration Tutorial](./references/cgdsrMigration.md)