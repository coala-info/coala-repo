---
name: bioconductor-egseadata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/EGSEAdata.html
---

# bioconductor-egseadata

name: bioconductor-egseadata
description: Provides gene set collections and example datasets for the Ensemble of Gene Set Enrichment Analyses (EGSEA) package. Use when performing gene set enrichment analysis in R for Human, Mouse, or Rat, specifically when needing MSigDB, GeneSetDB, or KEGG pathway collections formatted for the EGSEA workflow.

# bioconductor-egseadata

## Overview
EGSEAdata is a specialized data package that provides the gene set collections required by the `EGSEA` package. It includes Human, Mouse, and Rat versions of MSigDB, GeneSetDB, and KEGG pathways. Additionally, it contains example RNA-seq datasets (voom-processed) and pre-calculated EGSEA results for demonstration and testing.

## Core Functions and Usage

### Exploring Available Data
The primary function to inspect available gene set collections is `egsea.data()`.

```r
library(EGSEAdata)

# Display available collections for human (default)
egsea.data(species = "human")

# Display collections for mouse with gene set counts
egsea.data(species = "mouse", simple = FALSE)

# Return information as a list for programmatic access
info <- egsea.data(species = "rat", returnInfo = TRUE)
```

### Accessing Gene Set Collections
Gene sets are stored as list objects or specialized collection objects.

*   **MSigDB (Human):** Access via the `msigdb` object.
*   **MSigDB (Mouse):** Access via `Mm.H`, `Mm.c2`, `Mm.c3`, `Mm.c4`, `Mm.c5`, `Mm.c6`, and `Mm.c7` (ortholog-mapped).
*   **GeneSetDB:** Access via `gsetdb.human`, `gsetdb.mouse`, or `gsetdb.rat`.
*   **KEGG:** Access via `kegg.pathways`, which contains lists for all three species.

```r
# Example: Accessing Human KEGG pathways
human_kegg <- kegg.pathways$human

# Example: Accessing Mouse MSigDB Hallmark collection
data(Mm.H)
print(names(Mm.H))
```

### Example Datasets for Workflows
The package includes processed RNA-seq data (as `voom` objects) and contrast matrices for testing the `EGSEA` pipeline.

*   **Human IL-13 Dataset:** `il13.data` (voom and contra) and `il13.data.cnt` (raw counts).
*   **Mouse Mammary Dataset:** `mam.data` (voom and contra).
*   **Pre-calculated Results:** `il13.gsa` contains an `EGSEAResults` object.

```r
# Load example human data
data(il13.data)
v <- il13.data$voom
contrast <- il13.data$contra

# Load pre-calculated results
data(il13.gsa)
show(il13.gsa)
```

## Typical Workflow with EGSEA
EGSEAdata is usually used to provide the `gs.annots` argument in the `egsea` function.

```r
# Conceptual workflow
library(EGSEA)
library(EGSEAdata)

# 1. Prepare your data (or use example)
data(il13.data)

# 2. Select gene sets from EGSEAdata
# Most EGSEA functions handle the loading of these collections internally 
# when you specify the collection name, but you can inspect them here.
egsea.data("human")

# 3. Run EGSEA (requires EGSEA package)
# res = egsea(voom.obj = il13.data$voom, contrasts = il13.data$contra, 
#             gs.annots = "kegg", symbolsMap = il13.data$genes)
```

## Reference documentation
- [EGSEAdata Reference Manual](./references/reference_manual.md)