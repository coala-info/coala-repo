---
name: bioconductor-a4preproc
description: This tool adds standardized gene annotation and metadata to ExpressionSet objects within the Automated Affymetrix Array Analysis suite. Use when user asks to add gene information to an ExpressionSet, map probe IDs to standardized identifiers, or pre-process data for the a4 pipeline.
homepage: https://bioconductor.org/packages/release/bioc/html/a4Preproc.html
---

# bioconductor-a4preproc

name: bioconductor-a4preproc
description: Utility functions for pre-processing data within the Automated Affymetrix Array Analysis (a4) suite. Use this skill to add standardized feature annotation (Entrez ID, Ensembl ID, Gene Symbol, and Gene Name) to ExpressionSet objects, ensuring compatibility with the a4 pipeline.

# bioconductor-a4preproc

## Overview

The `a4Preproc` package is a specialized utility component of the Automated Affymetrix Array Analysis (a4) suite. Its primary role is to handle the "pre-processing" step of data preparation—specifically the enrichment of `ExpressionSet` objects with comprehensive gene metadata. By automating the mapping of probe IDs to standardized identifiers like Entrez and Ensembl, it ensures that downstream analysis and visualization packages in the a4 suite function correctly.

## Core Workflow

The package's functionality is centered around a single high-level function: `addGeneInfo`.

### Adding Gene Annotation

To prepare an `ExpressionSet` for the a4 pipeline, use `addGeneInfo`. This function looks at the annotation slot of the `ExpressionSet`, loads the corresponding metadata package (e.g., `hgu95av2.db`), and populates the `featureData` slot with standardized columns.

```r
library(a4Preproc)
library(ALL) # Example dataset
data(ALL)

# Add standardized annotation (ENTREZID, ENSEMBLID, SYMBOL, GENENAME)
a4ALL <- addGeneInfo(eset = ALL)

# Verify the new feature data
head(fData(a4ALL))
```

### Key Outputs

After running `addGeneInfo`, the resulting object will contain an `AnnotatedDataFrame` in the `featureData` slot with the following standardized labels:
- `ENTREZID`: The Entrez Gene identifier.
- `ENSEMBLID`: The Ensembl Gene identifier.
- `SYMBOL`: The official Gene Symbol.
- `GENENAME`: The full descriptive name of the gene.

## Usage Tips

- **Annotation Packages**: Ensure the appropriate Bioconductor annotation package for your microarray platform (e.g., `hgu95av2.db` for Affymetrix HG-U95Av2) is installed. `addGeneInfo` relies on these `.db` packages to perform the mapping.
- **Pipeline Integration**: This step should be performed immediately after data loading and normalization, before passing the data to `a4Classif`, `a4Reporting`, or `a4Base`.
- **Data Inspection**: Use `featureData(eset)` or `fData(eset)` to inspect the results. The a4 suite expects these specific column names for its automated plotting and reporting functions.

## Reference documentation

- [Vignette of the a4Preproc package](./references/a4Preproc-vignette.md)