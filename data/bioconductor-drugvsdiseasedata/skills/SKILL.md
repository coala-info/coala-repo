---
name: bioconductor-drugvsdiseasedata
description: This package provides curated gene expression profiles, disease clusters, and annotation maps for the DrugVsDisease pipeline. Use when user asks to access ranked disease signatures, map Affymetrix probes to gene symbols, or retrieve network attributes for drug-disease repurposing analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/DrugVsDiseasedata.html
---

# bioconductor-drugvsdiseasedata

## Overview
The `DrugVsDiseasedata` package serves as the data companion to the `DrugVsDisease` pipeline. It provides curated gene expression profiles for 45 distinct diseases derived from 85 GEO experiments (3766 microarrays). These profiles are ranked and clustered to facilitate the identification of negatively correlated (repurposing candidates) or positively correlated (potential side-effects) drug-disease pairs. It also contains essential annotation maps for Affymetrix platforms and Cytoscape network attributes.

## Data Loading and Exploration

The package primarily consists of data objects that are loaded into the R environment using the `data()` function.

### Disease Signatures and Clusters
To access the ranked gene expression profiles for diseases and their associated cluster classifications:

```r
library(DrugVsDiseasedata)

# Load ranked profiles (top/bottom 100 genes used for similarity)
data(diseaseRL, package="DrugVsDiseasedata")

# Load disease cluster assignments
data(diseaseClusters, package="DrugVsDiseasedata")
```

### Annotation and Gene Lists
The package provides mapping resources to convert Affymetrix probe sets to HUGO gene symbols, supporting automatic annotation in the main pipeline.

```r
# Get Affymetrix platform annotations and biomaRt references
data(annotationlist, package="DrugVsDiseasedata")

# Get the intersection of HUGO genes across supported Affymetrix platforms
data(genelist, package="DrugVsDiseasedata")
```

### GEO Metadata
For users performing regression modeling or experimental design analysis, the package includes factor values extracted from GEO.

```r
# Access available factor values for experimental design
data(GEOfactorvalues, package="DrugVsDiseasedata")
```

### Network and Cytoscape Data
To facilitate network visualization of drug-disease connections:

```r
# Load edge data, distances, and Running sum Peak Statistics (RPS)
data(cytodisease, package="DrugVsDiseasedata")

# Load compound/node names and search-compatible terms for MeSH
data(diseaselabels, package="DrugVsDiseasedata")
```

## Typical Workflow Integration
1. **Initialization**: Load `DrugVsDiseasedata` alongside `DrugVsDisease`.
2. **Profile Comparison**: Use `diseaseRL` as the reference set to compare against custom drug profiles.
3. **Annotation**: Use `annotationlist` to ensure probe sets are correctly mapped to HUGO symbols before enrichment analysis.
4. **Visualization**: Export `cytodisease` attributes to generate `.sif` files for Cytoscape to visualize the disease-drug network.

## Reference documentation
- [DrugVsDiseasedata](./references/DrugVsDiseasedata.md)