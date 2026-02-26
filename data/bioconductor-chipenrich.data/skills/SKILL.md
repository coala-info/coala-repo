---
name: bioconductor-chipenrich.data
description: This package provides genomic annotations and data structures required for gene set enrichment analysis of ChIP-seq data. Use when user asks to access locus definitions, retrieve gene sets, obtain transcription start site locations, or load mappability data for genomic enrichment workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/chipenrich.data.html
---


# bioconductor-chipenrich.data

name: bioconductor-chipenrich.data
description: Data package for the chipenrich R package. Use this skill when performing gene set enrichment analysis on ChIP-seq or other genomic regions to access locus definitions, gene sets, TSS data, and mappability data for various organisms and genome builds.

# bioconductor-chipenrich.data

## Overview

The `chipenrich.data` package is a companion data package for the `chipenrich` Bioconductor package. It provides the essential genomic annotations and data structures required to perform gene set enrichment analysis that accounts for the varying lengths of gene loci and mappability. It contains locus definitions (mapping genomic regions to genes), gene sets (GO, KEGG, etc.), Transcription Start Site (TSS) locations, and mappability data.

## Core Data Structures

The package utilizes several S4 classes to organize genomic data:

- **LocusDefinition**: Defines how genomic regions are assigned to genes (e.g., nearest TSS, within 1kb, etc.).
- **GeneSet**: Stores mappings between gene set IDs (like GO terms) and Entrez Gene IDs.
- **TSS Data**: `GRanges` objects containing gene IDs and symbols used for QC plotting.
- **Mappability Data**: Data frames containing `geneid` and `mappa` scores to adjust for sequence uniqueness.

## Usage in R

While `chipenrich.data` is primarily used internally by the `chipenrich` function, you can explore the available data manually.

### Exploring Supported Data

Use functions from the main `chipenrich` package to see what data is available within `chipenrich.data`:

```r
library(chipenrich)
library(chipenrich.data)

# List all available locus definitions for supported genomes
supported_locusdefs()

# List all available gene sets (e.g., GO, KEGG, Reactome)
supported_genesets()

# List available read lengths for mappability data
supported_read_lengths()
```

### Locus Definitions

Locus definitions determine how a peak is assigned to a gene. Common definitions include:
- `nearest_tss`: Region spanning midpoints between TSSs of adjacent genes.
- `nearest_gene`: Region spanning midpoints between boundaries of each gene.
- `1kb` / `5kb` / `10kb`: Regions within a specific distance of any TSS of a gene.
- `exon` / `intron`: Loci corresponding specifically to exons or introns.

### Example Data

The package includes example peak sets for testing workflows:

```r
# Load example E2F4 peaks (hg19)
data(peaks_E2F4)

# Load example H3K4me3 peaks (hg19)
data(peaks_H3K4me3_GM12878)

# View the data (typically a data frame with chrom, start, end)
head(peaks_E2F4)
```

## Workflow Integration

When calling `chipenrich()`, the `locusdef` and `genesets` arguments refer to data stored in this package:

```r
# Example enrichment call using data from chipenrich.data
results = chipenrich(
  peaks = peaks_E2F4,
  genome = 'hg19',
  genesets = 'GOBP',
  locusdef = 'nearest_tss',
  method = 'chipenrich'
)
```

## Reference documentation

- [chipenrich.data Vignette](./references/chipenrich.data-vignette.md)