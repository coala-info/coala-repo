---
name: bioconductor-pepdat
description: This package provides standardized peptide collections and physicochemical properties for HIV and SIV analysis. Use when user asks to access HIV or SIV peptide reference alignments, retrieve peptide z-scales, or load peptide data as GRanges objects for microarray analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/pepDat.html
---


# bioconductor-pepdat

name: bioconductor-pepdat
description: Access and use peptide collections for HIV and SIV analysis. Use this skill when working with peptide microarray data, specifically for retrieving reference alignments (HXB2, MAC239), physicochemical properties (z-scales), and clade-specific peptide information stored as GRanges objects.

# bioconductor-pepdat

## Overview

The `pepDat` package is a data-experiment package for Bioconductor that provides standardized peptide collections. It is primarily designed to support peptide analysis and visualization workflows in conjunction with `pepStat` and `Pviz`. The data is structured as `GRanges` objects, containing peptide sequences, their positions relative to reference genomes, alignments, and physicochemical properties (z-scales).

## Loading Peptide Collections

The package contains several pre-defined datasets for HIV and SIV. These are loaded using the standard R `data()` function.

```r
library(pepDat)

# Load HIV reference collection (HXB2)
data(pep_hxb2)

# Load SIV reference collection (MAC239)
data(pep_mac239)
```

## Available Datasets

- `pep_hxb2`: Based on HIV reference HXB2 and clades A, B, C, D, M, CRF01, and CRF02.
- `pep_hxb2JPT`: Extended HIV collection including clades CM244, CON 01 AE, LAI A04321, and MN DD328842.
- `pep_mac239`: SIV collection for clades mac239 and E660.
- `pep_m239smE543`: SIV collection for clades mac239 and E543.

## Working with Peptide GRanges

Since the collections are `GRanges` objects, you can use standard `GenomicRanges` accessors to explore the data.

### Inspecting Metadata
The metadata columns (`mcols`) contain the core peptide information:
- `names`: The peptide amino acid sequence.
- `aligned`: The sequence aligned to the reference.
- `trimmed`: The trimmed alignment.
- `clade`: The specific clade the peptide belongs to.
- `z1` through `z5`: z-scale sums representing physicochemical properties (hydrophobicity, size, etc.).

```r
# View the first few entries
head(pep_hxb2)

# Access specific metadata
peptide_sequences <- mcols(pep_hxb2)$names
clade_info <- mcols(pep_hxb2)$clade

# Filter for a specific clade
pep_clade_B <- pep_hxb2[mcols(pep_hxb2)$clade == "B"]
```

## Integration with Other Packages

- **pepStat**: Use `pepDat` collections as the underlying database for statistical analysis of peptide microarrays.
- **Pviz**: Use these objects to visualize peptide binding data against genomic coordinates.
- **Custom Collections**: To create new collections for other organisms, use the `create_db` function from the `pepStat` package.

## Reference documentation

- [pepDat User Guide](./references/pepDat.md)