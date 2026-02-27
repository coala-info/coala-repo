---
name: bioconductor-sbgnview.data
description: This package provides supporting datasets and ID mapping tables required for the SBGNview visualization engine. Use when user asks to access demo RNA-seq datasets, map biological identifiers to SBGN-ML glyph IDs, or perform cross-species ortholog mapping for pathway visualization.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SBGNview.data.html
---


# bioconductor-sbgnview.data

## Overview

The `SBGNview.data` package is a specialized data experiment package that provides the necessary infrastructure for the `SBGNview` visualization engine. It contains pre-processed RNA-seq datasets and, more importantly, a comprehensive collection of ID mapping tables. These tables bridge the gap between biological identifiers (like Entrez IDs or ChEBI IDs) and the specific glyph IDs used in SBGN-ML (Systems Biology Graphical Notation Markup Language) files, particularly those derived from Pathway Commons and Reactome.

## Data Resources

### Demo Datasets
The package includes two primary `SummarizedExperiment` objects used for demonstrating pathway visualization workflows:

- **IFNg**: RNA-Seq abundance data from a mouse study comparing IFNG knockout vs. wild type mice.
- **cancer.ds**: A subset of the GSE16873 breast cancer dataset (DCIS samples) used for demonstrating human pathway overlays.

```r
library(SBGNview.data)
library(SummarizedExperiment)

# Load datasets
data("IFNg")
data("cancer.ds")

# Access expression data
head(assays(IFNg)$counts)
# Access metadata
IFNg$group
```

### ID Mapping Tables
These tables are critical for mapping user data to SBGN glyphs. They are typically loaded automatically by `SBGNview`, but can be accessed manually for custom mapping logic.

#### 1. Molecule IDs to Glyph IDs
Maps specific gene/protein IDs to the XML element IDs in SBGN-ML files.
```r
# Human Entrez ID to Pathway Commons Glyph ID
data(hsa_ENTREZID_pathwayCommons)
head(hsa_ENTREZID_pathwayCommons)
```

#### 2. Ortholog Mappings (KEGG)
Used to map IDs across species (e.g., mapping mouse data onto human reference pathways) via KEGG Orthology (KO).
```r
# Mouse Entrez ID to KEGG Ortholog
data(mmu_KO_ENTREZID)

# Human Entrez ID to KEGG Ortholog
data(hsa_KO_ENTREZID)
```

#### 3. Compound and Pathway Mappings
Maps chemical identifiers (ChEBI) to pathways and glyphs.
```r
# ChEBI to Pathway Commons
data(chebi_pathwayCommons)

# ChEBI to Pathway IDs
data(chebi_pathway.id)
```

## Typical Workflow

1. **Load Data**: Use `data()` to load the experiment data or mapping tables.
2. **Inspect Identifiers**: Check if your dataset's row names (IDs) match the types supported by the mapping tables (e.g., Entrez IDs).
3. **Cross-Species Mapping**: If working with non-human data, use the `KO` (KEGG Ortholog) tables to translate your IDs into a format compatible with the reference SBGN-ML pathways provided in the main `SBGNview` package.
4. **Visualization**: Pass these datasets directly to `SBGNview()` functions to render pathway maps.

## Reference documentation

- [Supporting Datasets for SBGNview Package](./references/SBGNview.data.vignette.md)