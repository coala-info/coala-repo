---
name: bioconductor-bugphyzz
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/bugphyzz.html
---

# bioconductor-bugphyzz

name: bioconductor-bugphyzz
description: Use this skill to import harmonized microbial annotations, create microbial signatures (taxa lists with shared traits), and perform Bug Set Enrichment Analysis (BSEA) using the bugphyzz Bioconductor package. Ideal for linking microbiome taxonomic profiles to physiological traits like aerophilicity, growth temperature, or pathogenicity.

## Overview

The `bugphyzz` package provides access to a massive, harmonized database of microbial traits (physiologies) for Bacteria and Archaea. It maps NCBI Taxonomy IDs to specific attributes (e.g., "gram stain", "optimal ph", "habitat") derived from diverse sources like BacDive, PATRIC, and Bergey's Manual. A key feature is the inclusion of extended annotations via Ancestral State Reconstruction (ASR), allowing for trait inference even for taxa without direct experimental data.

## Core Workflow

### 1. Data Import
The primary entry point is `importBugphyzz()`, which downloads and loads the full suite of trait data frames.

```r
library(bugphyzz)
library(dplyr)

# Import all available trait data
bp <- importBugphyzz()

# List available attributes (e.g., "aerophilicity", "genome size", "habitat")
names(bp)
```

### 2. Creating Microbial Signatures
Signatures are lists of taxa that share a specific trait value. Use `makeSignatures()` to convert the raw data frames into named lists suitable for enrichment analysis.

```r
# Create genus-level signatures for aerophilicity
aer_sigs <- makeSignatures(
    dat = bp[["aerophilicity"]], 
    taxIdType = "Taxon_name", 
    taxLevel = "genus"
)

# Create species-level signatures for numeric traits (e.g., growth temperature)
# Numeric traits are automatically binned (e.g., mesophile, thermophile)
temp_sigs <- makeSignatures(
    dat = bp[["growth temperature"]], 
    taxIdType = "NCBI_ID",
    taxLevel = "species"
)
```

### 3. Filtering and Quality Control
You can filter annotations based on evidence codes or confidence scores before creating signatures.

*   **Evidence Codes**: `exp` (experimental), `asr` (ancestral state reconstruction), `igc` (genomic context).
*   **Frequency**: `always`, `usually`, `sometimes`.

```r
# Filter for high-confidence experimental data only
pathogen_sigs <- makeSignatures(
    dat = bp[["animal pathogen"]],
    evidence = c("exp", "tas"),
    taxLevel = "mixed"
)
```

### 4. Bug Set Enrichment Analysis (BSEA)
`bugphyzz` signatures are designed to work with the `EnrichmentBrowser` package. The workflow typically involves:
1. Performing Differential Abundance (DA) analysis (e.g., using `edgeR` or `DESeq2`).
2. Running `sbea()` (Set-Based Enrichment Analysis) using the signatures as the gene sets (`gs`).

```r
library(EnrichmentBrowser)

# Assuming 'se' is a SummarizedExperiment with DA results
# and 'aer_sigs' is the list of signatures created above
gsea_results <- sbea(
    method = "gsea", 
    se = se, 
    gs = aer_sigs, 
    perm = 1000
)
```

### 5. Taxon Lookup
To find all traits associated with a specific microbe:

```r
# Lookup by NCBI ID (e.g., 562 for E. coli)
ecoli_traits <- getTaxonSignatures(tax = "562", bp = bp)
```

## Tips for Success
*   **Taxon IDs vs Names**: Use `taxIdType = "NCBI_ID"` whenever possible to avoid issues with synonyms or spelling variations in taxonomic names.
*   **Mixed Ranks**: Setting `taxLevel = "mixed"` is useful when your dataset contains a variety of taxonomic resolutions (e.g., some species, some genera).
*   **Normalization**: When running GSEA, ensure your microbiome counts are normalized (e.g., using `limma::voom`) before passing them to `sbea`.

## Reference documentation
- [bugphyzz](./references/bugphyzz.md)
- [sources](./references/sources.md)