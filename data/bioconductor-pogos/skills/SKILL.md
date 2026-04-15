---
name: bioconductor-pogos
description: This tool provides an interface to PharmacoDB for retrieving pharmacogenomics data and mapping cell lines and compounds to standardized ontologies. Use when user asks to access dose-response profiles, visualize drug sensitivity traces, or map pharmacogenomic entities to the Cell Line Ontology and ChEBI.
homepage: https://bioconductor.org/packages/release/bioc/html/pogos.html
---

# bioconductor-pogos

name: bioconductor-pogos
description: Interface to PharmacoDB for pharmacogenomics data retrieval and ontology mapping. Use this skill to access dose-response profiles for cell lines and compounds, work with the Cell Line Ontology (CLO) and ChEBI, and visualize drug sensitivity traces.

# bioconductor-pogos

## Overview

The `pogos` package (PharmacOGenomics Ontology Support) provides an R interface to the PharmacoDB REST API and tools for integrating pharmacogenomic data with standardized ontologies. It is primarily used to explore dose-response profiles across different datasets (like CCLE) and to map cell lines and compounds to formal ontological terms (CLO, ChEBI, EFO).

## Core Data Structures

The package utilizes two primary S4 classes for managing dose-response data:

- `DRTraceSet`: Manages dose-response profiles for multiple cell lines treated with a single compound under a specific dosage schedule.
- `DRProfSet`: Manages dose-response profiles for a single cell line across multiple compounds.

## Typical Workflows

### 1. Accessing Precomputed Reference Data
The package includes several `DataFrame` objects containing PharmacoDB identifiers:
```r
library(pogos)
data(cell_lines_v1)
data(compounds_v1)
data(datasets_v1)
data(tissues_v1)

# View available datasets
head(datasets_v1)
```

### 2. Retrieving Dose-Response Traces
To visualize how different cell lines respond to a specific drug (e.g., Irinotecan in CCLE):
```r
# Create a trace set (requires internet connection to PharmacoDB API)
iric <- iriCCLE() 
plot(iric)
```

### 3. Querying PharmacoDB API
You can retrieve intersections between cell lines and datasets using internal API wrappers. Note that these functions are dependent on the availability of `https://pharmacodb.pmgenomics.ca`.

```r
# Example of manual retrieval for MCF-7 (ID 895) in CCLE (ID 1)
library(httr)
library(rjson)
url <- "https://pharmacodb.pmgenomics.ca/api/v1/intersections/2/895/1?indent=true"
res <- GET(url)
if (status_code(res) == 200) {
  ans <- fromJSON(readBin(res$content, what="character"))
  # Process dose_responses list
}
```

### 4. Ontology Mapping
`pogos` works alongside `ontoProc` to map pharmacogenomic entities to ontologies.

**Cell Line Ontology (CLO) Mapping:**
```r
library(ontoProc)
clo <- getOnto("cellLineOnto")

# Find parent terms for specific cell lines
minds <- which(clo$name %in% c("143B cell", "1321N1 cell"))
tags <- clo$id[minds]
clo$name[unlist(clo$parent[tags])]
```

**ChEBI Mapping for Compounds:**
```r
chl <- getOnto("chebi_full")
# Match PharmacoDB compound names to ChEBI names
mm <- chl$name[match(tolower(compounds_v1[,2]), tolower(chl$name), nomatch=0)]
# Calculate coverage percentage
round(length(mm)/nrow(compounds_v1), 2)
```

## Visualization
The package provides `plot` methods for `DRTraceSet` and `DRProfSet` objects, typically generating ggplot2-based visualizations of dose-response curves.

```r
# Plotting a profile set for a specific cell line
# drp <- DRProfSet(...) 
# if (!inherits(drp, "try-error")) plot(drp)
```

## Usage Tips
- **API Fragility**: The PharmacoDB API can be unstable. Always wrap retrieval calls in `try()` or check status codes.
- **Identifier Matching**: Direct string matching between PharmacoDB and ChEBI/CLO is often low (approx 23% for compounds). Consider using `ontoProc` for more robust term searching.
- **Dependencies**: Ensure `ontoProc`, `ontologyIndex`, and `ontologyPlot` are installed for ontology-related workflows.

## Reference documentation
- [pogos – PharmacOGenomics Ontology Support](./references/pogos.md)