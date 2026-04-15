---
name: bioconductor-fdb.infiniummethylation.hg18
description: This package provides annotation data for Illumina Infinium 27k and 450k DNA methylation probes mapped to the hg18 genome assembly. Use when user asks to retrieve probe coordinates, find nearest genes or transcription start sites for methylation sites, and overlap methylation data with hg18 genomic features like CpG islands.
homepage: https://bioconductor.org/packages/release/data/annotation/html/FDb.InfiniumMethylation.hg18.html
---

# bioconductor-fdb.infiniummethylation.hg18

name: bioconductor-fdb.infiniummethylation.hg18
description: Provides annotation data for Illumina Infinium DNA methylation probes (27k and 450k) specifically for the hg18 (Build 36) genome assembly. Use this skill when an AI agent needs to retrieve probe coordinates, find nearest genes/TSS/transcripts for methylation sites, or overlap methylation data with hg18 genomic features like CpG islands.

# bioconductor-fdb.infiniummethylation.hg18

## Overview

The `FDb.InfiniumMethylation.hg18` package is a FeatureDb-based annotation resource for Illumina's HumanMethylation27 (27k) and HumanMethylation450 (450k) platforms. It allows users to work with methylation probe data as `GenomicRanges` objects, facilitating integration with other Bioconductor tools for genomic analysis.

## Core Workflows

### Loading the Package and Data
To begin using the annotations, load the library and the primary FeatureDb object.

```r
library(FDb.InfiniumMethylation.hg18)

# View the database object
FDb.InfiniumMethylation.hg18

# Extract all features as a GRanges object
InfiniumMethylation <- features(FDb.InfiniumMethylation.hg18)

# Set probe IDs as names for easier subsetting
names(InfiniumMethylation) <- values(InfiniumMethylation)$name
```

### Retrieving Platform-Specific Annotations
Use helper functions to get compact `GenomicRanges` for specific chips.

```r
# Get 450k probe annotations
hm450 <- get450k()
# Or explicitly specify genome
hm450.hg18 <- getPlatform(platform='HM450', genome='hg18')

# Get 27k probe annotations
hm27 <- get27k()
```

### Finding Nearest Genomic Features
The package provides utilities to annotate probes based on their proximity to genes, transcripts, or Transcription Start Sites (TSS).

```r
# Example probe IDs
probenames <- c("cg16392865", "cg00395291")
probes <- hm450[probenames]

# Find nearest TSS
getNearestTSS(probes)

# Find nearest Transcript
getNearestTranscript(probes)

# Find nearest Gene
getNearestGene(probes)
```

### Working with CpG Islands and Shores
The package includes built-in CpG island data for hg18.

```r
data(hg18.islands)

# Find probes overlapping CpG islands
CGI.probes <- subsetByOverlaps(InfiniumMethylation, hg18.islands)

# Define and find probes in "shores" (2kb flanking islands)
hg18.shores <- c(flank(hg18.islands, 2000, start=TRUE),
                 flank(hg18.islands, 2000, start=FALSE))
shore.probes <- subsetByOverlaps(InfiniumMethylation, hg18.shores)
```

## Tips and Best Practices
- **Genome Assembly**: Ensure your experimental data is aligned to hg18 before using this package. If your data is in hg19, use `FDb.InfiniumMethylation.hg19` or `rtracklayer::liftOver()`.
- **Sorting**: It is often useful to sort probes in genomic order using `sort(InfiniumMethylation)` before performing overlap operations.
- **Metadata**: Use `metadata(FDb.InfiniumMethylation.hg18)` to check the source and versioning of the underlying database.

## Reference documentation
- [FDb.InfiniumMethylation.hg18 Reference Manual](./references/reference_manual.md)