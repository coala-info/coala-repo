---
name: bioconductor-dvddata
description: This package provides reference datasets of curated gene expression profiles for drugs and diseases required by the Drug versus Disease analysis tool. Use when user asks to access drug-disease signatures, load connectivity map data, or retrieve gene expression profiles for drug repurposing and side effect analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/DvDdata.html
---

# bioconductor-dvddata

## Overview

The `DvDdata` package is a specialized data experiment package for Bioconductor. It provides the essential reference datasets required by the `DvD` (Drug versus Disease) package. These datasets include curated gene expression profiles for 1309 compounds (from Connectivity Map v2) and 45 distinct diseases (from GEO), along with clustering assignments and annotation mapping tools.

The core utility of this package is to provide the "gold standard" signatures used to calculate enrichment scores, allowing users to identify negatively correlated profiles (potential drug repurposing) or positively correlated profiles (potential side effects).

## Data Loading and Exploration

All data objects in `DvDdata` are accessed using the standard R `data()` function.

### Drug Signatures
The drug profiles are based on the HGU-133A platform, converted to gene symbols.
- `drugClusters`: Assignments of 1309 compounds into 103 clusters based on affinity propagation.
- `druglabels`: Compound names and search terms for external databases like DrugBank.
- `cytodrug`: Edge information (distance and Running sum Peak Statistic) for drug networks.

```r
library(DvDdata)
data(drugClusters)
data(druglabels)
head(druglabels)
```

### Disease Signatures
Disease profiles represent 85 microarray experiments across 45 diseases.
- `diseaseRL`: The ranked expression profiles for the diseases.
- `diseaseClusters`: Classification of disease profiles into 12 clusters.
- `cytodisease`: Network edge attributes for disease connections.

```r
data(diseaseRL)
data(diseaseClusters)
# View the ranked list for a specific disease
head(diseaseRL[[1]])
```

### Annotation and Metadata
These objects facilitate the automatic mapping of Affymetrix probes to HUGO gene symbols.
- `annotationlist`: Mapping between Affymetrix platforms and BiomaRt references.
- `genelist`: The intersection of genes across the three supported Affymetrix platforms.
- `GEOfactorvalues`: Factor values from GEO used for identifying explanatory factors in regression models.

```r
data(genelist)
data(annotationlist)
```

## Typical Workflow

1. **Initialize Environment**: Load `DvDdata` alongside the main `DvD` analysis package.
2. **Select Reference Set**: Use `diseaseRL` or `drugClusters` to provide the background context for your own expression data.
3. **Map Identifiers**: Use `genelist` to ensure your input data matches the feature space of the reference signatures.
4. **Network Visualization**: Use `cytodrug` or `cytodisease` data frames to generate SIF files for Cytoscape if network analysis of the results is required.

## Tips
- **Gene Symbols**: The reference profiles use HUGO gene symbols. Ensure your input data is converted to symbols (using `biomaRt` or `org.Hs.eg.db`) before comparison.
- **RPS Interpretation**: In the `cytodrug/disease` objects, a Running sum Peak Statistic (RPS) of `1` indicates positive correlation (similar profiles), while `-1` indicates negative correlation (inverse profiles).
- **Integration**: This package is a dependency; most functions in the `DvD` package will call these data objects automatically if the package is loaded.

## Reference documentation
- [Drug versus Disease data package](./references/DvDdata.md)