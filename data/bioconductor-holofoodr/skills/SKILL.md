---
name: bioconductor-holofoodr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/HoloFoodR.html
---

# bioconductor-holofoodr

name: bioconductor-holofoodr
description: Interface to the HoloFood database for searching and retrieving multi-omics data (animals, samples, catalogues). Use when Claude needs to access EBI HoloFood resources, integrate targeted metabolomics with MGnify metagenomics data, or fetch untargeted metabolomics from MetaboLights within an R environment.

# bioconductor-holofoodr

## Overview
`HoloFoodR` provides an R interface to the [HoloFood](https://www.holofooddata.org/) database, a resource focused on holobiont data (host-microbiome interactions). It allows users to query animal metadata, sample information, and viral/genome catalogues, returning data in standard Bioconductor formats like `MultiAssayExperiment` (MAE) and `TreeSummarizedExperiment` (TreeSE).

## Core Functions

### Searching and Querying
- `doQuery(resource, ...)`: Optimized for searching specific data types. Returns a `data.frame`.
  - Resources: `"animals"`, `"samples"`, `"genome-catalogues"`, `"viral-catalogues"`.
  - Example: `animals <- doQuery("animals", max.hits = 100)`
- `getData(accession.type, accession, flatten = TRUE)`: Retrieves detailed metadata for specific accessions.
  - Example: `animal_info <- getData(accession.type = "animals", accession = "SAMEA12345")`

### Retrieving Results
- `getResult(accession)`: Fetches the actual omics data (e.g., biogenic amines, fatty acids, histology) for given sample accessions.
  - Returns: A `MultiAssayExperiment` object.
  - Example: `mae <- getResult(sample_ids)`

### Metabolomics Integration
- `getMetaboLights(url)`: Retrieves untargeted metabolomics data from MetaboLights using URLs found in HoloFood sample metadata.
- `getMetaboLightsFile(url)`: Downloads specific spectra files.

## Typical Workflow

1.  **Search for Animals/Samples**: Use `doQuery` to find subjects based on criteria (e.g., presence of histological data).
2.  **Extract Sample IDs**: Use `getData` on the animal accessions to find associated sample accessions.
3.  **Fetch Multi-Omics Data**: Pass sample IDs to `getResult` to create a `MultiAssayExperiment`.
4.  **Downstream Analysis**: Access individual experiments using `mae[[i]]` or `experiments(mae)`. These are typically `TreeSummarizedExperiment` objects compatible with the `mia` (miaverse) package.

## Integration with MGnify
Since HoloFood focuses on host and targeted data, metagenomics data is often stored in MGnify.
1.  Identify metagenomic samples in HoloFood metadata.
2.  Use `MGnifyR` to search for analyses: `analysis_ids <- MGnifyR::searchAnalysis(client, type = "samples", sample_ids)`.
3.  Fetch data: `mae_mg <- MGnifyR::getResult(client, analysis_ids)`.
4.  Merge: Align sample names and combine using `c(experiments(mae_holofood), experiments(mae_mgnify))`.

## Reference documentation
- [HoloFoodR: interface to HoloFoodR database](./references/HoloFoodR.md)