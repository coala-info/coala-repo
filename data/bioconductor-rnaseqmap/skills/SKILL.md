---
name: bioconductor-rnaseqmap
description: The rnaSeqMap package provides a middleware API for RNA-seq secondary analysis, coverage calculation, and genomic region mining. Use when user asks to calculate coverage measures from BAM files, find expressed genomic regions using the Aumann-Lindell algorithm, or perform nucleotide-level splicing analysis.
homepage: https://bioconductor.org/packages/3.5/bioc/html/rnaSeqMap.html
---

# bioconductor-rnaseqmap

name: bioconductor-rnaseqmap
description: Expert guidance for the rnaSeqMap R package used for RNA-seq secondary analysis, coverage calculation, and genomic region mining. Use this skill when performing nucleotide-level splicing analysis, finding expressed genomic regions using the Aumann-Lindell algorithm, or calculating coverage measures (camel measures) from BAM files.

# bioconductor-rnaseqmap

## Overview
The `rnaSeqMap` package serves as a middleware API for RNA-seq secondary analysis. It is designed to handle sequencing reads and annotations, providing high-speed access to read data based on genomic coordinates. Key capabilities include calculating coverage, identifying irreducible regions of expression, performing nucleotide-level splicing analysis, and providing connectors for differential expression tools like `edgeR` and `DESeq`.

## Core Workflows

### 1. Data Loading and Coverage
The package uses `SeqReads` and `NucleotideDistr` objects to manage read data and coverage distributions.

```r
library(rnaSeqMap)

# Define coordinates: chromosome, start, end, strand
rs <- newSeqReads(ch, st, en, str)

# Load data from BAM files using a sample description (covdesc)
# idx.both refers to indices of samples to load
rs <- getBamData(rs, idx.both, cvd = cvd)

# Convert reads to a coverage distribution object
nd <- getCoverageFromRS(rs, idx.both)
```

### 2. Finding Expressed Regions (Aumann-Lindell)
Use the two-sliding-window algorithm to find irreducible regions of genomic expression.

```r
# nd: NucleotideDistr object
# 15: mindiff (minimal difference)
# minsup: minimal length of the region
nd.AL <- findRegionsAsND(nd, 15, minsup = 5)
```

### 3. Coverage Difference Measures (Camel Wrapper)
To compare coverage between two groups (e.g., Treatment vs. Control), use the "camel" measures workflow.

```r
# 1. Identify sample indices from your sample description
idxT <- which(samples$condition == "T")
idxC <- which(samples$condition == "C")

# 2. Prepare genomic regions as a GRanges object
regions.gR <- rnaSeqMap:::.fiveCol2GRanges(tmp_table)

# 3. Calculate camel measures (KS test, area differences, etc.)
regionsCamelMeasures <- gRanges2CamelMeasures(regions.gR, samples, idxT, idxC, sums = sums)

# 4. Filter by coverage density
idx <- which(regionsCamelMeasures[,"covDensC1"] > 10 | regionsCamelMeasures[,"covDensC2"] > 10)
filtered_measures <- regionsCamelMeasures[idx, ]

# 5. Rank regions by a specific measure (e.g., QQ-plot maximum)
ordered_regions <- filtered_measures[order(filtered_measures[,"QQ.mm"], decreasing = TRUE), ]
```

## Data Modification and Normalization
The package provides several generators and normalization routines for coverage data:
- **Normalizations**: `standarizationNormalize()`, `densityNormalize()`, `minMaxNormalize()`.
- **Difference Measures**: `ks_test()`, `diff_area()`, `diff_derivative_area()`, `hump_diff1()`.
- **Generators**: `generatorAddSquare()`, `generatorMultiply()`, `generatorPeak()`, `generatorSynth()`.

## Tips for Efficient Usage
- **Memory Management**: While the package can read data into memory, using it with an extended XMAP database is recommended for large datasets to overcome memory limitations.
- **GFF3 Parsing**: Use `parseGff3()` to import genomic annotations.
- **Speed**: Core routines for coverage and region mining are implemented in C for performance.

## Reference documentation
- [rnaSeqMap](./references/rnaSeqMap.md)