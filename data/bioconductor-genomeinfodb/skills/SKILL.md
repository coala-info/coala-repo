---
name: bioconductor-genomeinfodb
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomeInfoDb.html
---

# bioconductor-genomeinfodb

## Overview

GenomeInfoDb is a core Bioconductor package that provides a standardized interface for accessing and manipulating sequence name mappings (seqlevels) and styles across various organisms. It acts as a "Rosetta Stone" for genomic coordinates, allowing users to seamlessly convert between naming schemes like "chr1" (UCSC) and "1" (NCBI/Ensembl). It also provides metadata about chromosomes, such as whether they are circular, autosomes, or sex chromosomes.

## Core Workflows

### 1. Exploring Supported Organisms and Styles
Before performing conversions, identify the supported styles for your species of interest.

```r
library(GenomeInfoDb)

# List all supported organisms
names(genomeStyles())

# Check supported styles for a specific species
genomeStyles("Homo sapiens")

# Verify if a specific style exists
"UCSC" %in% names(genomeStyles("Homo_sapiens"))
```

### 2. Converting Seqlevel Styles
The most common task is renaming chromosomes in a `GRanges`, `TxDb`, or `Seqinfo` object to match a specific convention.

```r
# Map a vector of seqnames to a new style
new_names <- mapSeqlevels(c("chr1", "chr2", "chrM"), "NCBI")
# Result: c(chr1="1", chr2="2", chrM="MT")

# Rename seqlevels in a GRanges object
gr <- renameSeqlevels(gr, mapSeqlevels(seqlevels(gr), "Ensembl"))
```

### 3. Filtering and Pruning Seqlevels
Use these functions to keep only relevant chromosomes (e.g., removing "random" or "alt" contigs).

```r
# Keep only standard chromosomes (1-22, X, Y, M for human)
gr <- keepStandardChromosomes(gr, pruning.mode = "coarse")

# Keep/Drop specific levels
gr <- keepSeqlevels(gr, c("chr1", "chr2"), pruning.mode = "coarse")
gr <- dropSeqlevels(gr, "chrM", pruning.mode = "coarse")

# Extract levels by group (auto, sex, circular)
auto_chroms <- extractSeqlevelsByGroup(species="Homo sapiens", style="UCSC", group="auto")
gr <- keepSeqlevels(gr, auto_chroms, pruning.mode = "coarse")
```

### 4. Working with Seqinfo Objects
`Seqinfo` objects store the "skeleton" of a genome (names, lengths, circularity, and genome build).

```r
# Create a Seqinfo object
si <- Seqinfo(seqnames=c("chr1", "chrM"), seqlengths=c(249250621, 16569), 
              isCircular=c(FALSE, TRUE), genome="hg19")

# Merge two Seqinfo objects (useful for combining datasets)
combined_si <- merge(si1, si2)
```

## Best Practices

- **Pruning Mode**: When using `keepSeqlevels` or `dropSeqlevels` on objects with ranges (like `GRanges`), always specify `pruning.mode="coarse"` to remove ranges located on the sequences being dropped.
- **Species Naming**: Most functions accept species names in "Genus species" format (e.g., "Homo sapiens") or "Genus_species" (e.g., "Homo_sapiens").
- **Style Detection**: If you are unsure of the current style of a character vector, use `seqlevelsStyle(x)`.
- **Submitting New Organisms**: If an organism is missing, you can prepare a tab-delimited file with columns `circular`, `auto`, `sex`, and the various naming styles to submit to the package maintainer.

## Reference documentation

- [Submitting your organism to GenomeInfoDb](./references/Accept-organism-for-GenomeInfoDb.md)
- [An Introduction to GenomeInfoDb](./references/GenomeInfoDb.md)