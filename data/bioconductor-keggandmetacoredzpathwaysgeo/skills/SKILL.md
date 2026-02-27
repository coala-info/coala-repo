---
name: bioconductor-keggandmetacoredzpathwaysgeo
description: This package provides curated disease-related gene expression datasets from GEO mapped to specific KEGG and Metacore pathways. Use when user asks to retrieve gold-standard datasets for benchmarking gene set analysis, access disease-specific ExpressionSets, or evaluate pathway enrichment methods.
homepage: https://bioconductor.org/packages/release/data/experiment/html/KEGGandMetacoreDzPathwaysGEO.html
---


# bioconductor-keggandmetacoredzpathwaysgeo

name: bioconductor-keggandmetacoredzpathwaysgeo
description: Access and use the KEGGandMetacoreDzPathwaysGEO Bioconductor data package. This skill should be used when a user needs to retrieve gold-standard disease-related gene expression datasets (ExpressionSets) from GEO that are mapped to specific KEGG or Metacore pathways for benchmarking gene set analysis (GSA) or pathway analysis methods.

# bioconductor-keggandmetacoredzpathwaysgeo

## Overview
The `KEGGandMetacoreDzPathwaysGEO` package is a specialized data collection containing 18 curated datasets from the Gene Expression Omnibus (GEO). Each dataset represents a disease phenotype with a corresponding known pathway in either the KEGG or Metacore databases. These datasets are stored as `ExpressionSet` objects, making them compatible with standard Bioconductor workflows for differential expression and pathway enrichment analysis.

## Loading and Exploring Data

To use this package, first load the library and list the available datasets:

```r
library(KEGGandMetacoreDzPathwaysGEO)

# List all available dataset names in the package
mysets <- data(package="KEGGandMetacoreDzPathwaysGEO")$results[, "Item"]
print(mysets)
```

To load a specific dataset (e.g., GSE1145) and inspect its structure:

```r
data(GSE1145)
show(GSE1145)

# Access expression data
exp_data <- exprs(GSE1145)

# Access phenotype/sample metadata
sample_metadata <- pData(GSE1145)
head(sample_metadata)

# Check the platform annotation used
annotation(GSE1145)
```

## Typical Workflow

1.  **Identify Target Dataset**: Use `?KEGGandMetacoreDzPathwaysGEO` to view the metadata table, which includes the GEO ID, the target disease, and the associated KEGG/Metacore pathway.
2.  **Load ExpressionSet**: Use `data(GSEXXXX)` to load the desired experiment.
3.  **Pre-processing**: Since these are stored as `ExpressionSet` objects, you can subset them or use them directly as input for Bioconductor tools like `limma` for differential expression or `PADOG` for pathway analysis.
4.  **Benchmarking**: These datasets are primarily used to evaluate the sensitivity and specificity of Gene Set Analysis (GSA) methods by checking if the method correctly prioritizes the "target" pathway associated with the disease.

## Tips
- **Phenotype Labels**: Always check `pData(dataset)$Group` or similar columns to identify the case vs. control samples for differential analysis.
- **Comparison with KEGGDzPathwaysGEO**: This package is a companion to `KEGGDzPathwaysGEO` (which contains 24 additional datasets). Together, they provide a robust framework for testing novel pathway analysis algorithms.
- **Feature IDs**: Features are typically identified by Probe IDs (e.g., Affymetrix). Use the string in `annotation(dataset)` to load the appropriate chip-specific annotation library (e.g., `hgu133plus2.db`) if you need to map probes to Entrez Gene IDs or Symbols.

## Reference documentation
- [KEGGandMetacoreDzPathwaysGEO](./references/KEGGandMetacoreDzPathwaysGEO.md)