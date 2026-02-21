---
name: bioconductor-fdb.infiniummethylation.hg19
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/FDb.InfiniumMethylation.hg19.html
---

# bioconductor-fdb.infiniummethylation.hg19

name: bioconductor-fdb.infiniummethylation.hg19
description: Access and use Illumina Infinium DNA methylation probe annotations (HM27 and HM450) for the hg19 genome build. Use this skill when you need to retrieve probe coordinates, annotate methylation data with genomic features (TSS, transcripts, CpG islands), or lift over legacy HM27 data from hg18 to hg19.

# bioconductor-fdb.infiniummethylation.hg19

## Overview

The `FDb.InfiniumMethylation.hg19` package is a FeatureDb-based annotation resource for Illumina's HumanMethylation27 (27k) and HumanMethylation450 (450k) platforms. It provides a unified interface to retrieve probe locations as `GenomicRanges` objects and facilitates the spatial annotation of methylation sites relative to genes, transcripts, and CpG islands.

## Core Workflows

### Loading the Package and Data
The package automatically loads the `FDb.InfiniumMethylation.hg19` object upon library call.

```r
library(FDb.InfiniumMethylation.hg19)

# View the FeatureDb object
FDb.InfiniumMethylation.hg19

# Extract all features as a GRanges object
InfiniumMethylation <- features(FDb.InfiniumMethylation.hg19)
```

### Retrieving Platform-Specific Probes
Use helper functions to get compact `GenomicRanges` for specific chips.

```r
# Get 450k annotations
hm450 <- get450k()
# Or explicitly
hm450 <- getPlatform(platform='HM450', genome='hg19')

# Get 27k annotations
hm27 <- get27k()
```

### Finding Nearest Genomic Features
The package provides utilities to find the closest gene-related features for a set of probes.

```r
# Example: Find nearest TSS for specific probes
probenames <- c("cg16392865", "cg00395291")
probes <- hm450[probenames]

getNearestTSS(probes)
getNearestTranscript(probes)
getNearestGene(probes)
```

### Working with CpG Islands and Shores
The package includes HMM-based CpG island definitions (Wu et al.).

```r
data(hg19.islands)

# Find probes overlapping islands
CGI.probes <- subsetByOverlaps(hm450, hg19.islands)

# Define and find probes in "shores" (2kb flanking islands)
hg19.shores <- c(flank(hg19.islands, 2000, start=TRUE),
                 flank(hg19.islands, 2000, start=FALSE))
shore.probes <- subsetByOverlaps(hm450, hg19.shores)
```

### Lifting 27k Data to hg19
If working with legacy 27k data (often in hg18), use `lift27kToHg19` to update coordinates.

```r
# Assuming 'my_27k_data' is a GenomicRatioSet or similar
my_27k_hg19 <- lift27kToHg19(my_27k_data)
```

## Tips and Best Practices
- **Genome Metadata**: Always ensure the genome metadata is set on your GRanges objects to prevent accidental comparisons across different assemblies (e.g., hg18 vs hg19).
- **Sorting**: Use `sort(InfiniumMethylation)` to order probes genomically, which is often required for downstream visualization or overlap analysis.
- **Sequence Info**: Use `seqinfo.hg19` to quickly assign sequence lengths and names without loading a full `BSgenome` package.

## Reference documentation
- [FDb.InfiniumMethylation.hg19 Reference Manual](./references/reference_manual.md)