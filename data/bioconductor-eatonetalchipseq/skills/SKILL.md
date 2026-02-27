---
name: bioconductor-eatonetalchipseq
description: This package provides access to ChIP-seq alignments and peak calls for the Origin Recognition Complex in yeast from the Eaton et al. (2010) study. Use when user asks to load ORC-binding data for Saccharomyces cerevisiae, analyze ChIP-seq alignments for yeast chromosome XIV, or visualize experimental peak calls.
homepage: https://bioconductor.org/packages/release/data/experiment/html/EatonEtAlChIPseq.html
---


# bioconductor-eatonetalchipseq

name: bioconductor-eatonetalchipseq
description: Access and use ChIP-seq data of ORC-binding sites in Saccharomyces cerevisiae (yeast) from the Eaton et al. (2010) study. Use this skill when you need to load, analyze, or visualize experimental ChIP-seq alignments and peak calls for yeast chromosome XIV.

# bioconductor-eatonetalchipseq

## Overview
The `EatonEtAlChIPseq` package is an ExperimentData package providing a subset of ChIP-seq data from the study "Conserved nucleosome positioning defines replication origins" (Eaton et al. 2010). It contains MAQ alignments and peak calls for the Origin Recognition Complex (ORC) binding to chromosome XIV of *Saccharomyces cerevisiae*. This data is useful for demonstrating ChIP-seq analysis workflows, nucleosome positioning studies, or replication origin mapping in yeast.

## Data Loading and Usage
The package provides four primary datasets representing two biological replicates of ORC binding.

### Loading Alignments
Alignments are stored as `GRanges` objects (via `GenomicRanges`) containing MAQ-aligned reads.

```r
library(EatonEtAlChIPseq)

# Load alignment replicates
data(orcAlignsRep1)
data(orcAlignsRep2)

# Inspect the alignments
print(orcAlignsRep1)
```

### Loading Peaks
Peak calls are stored as `GRanges` objects representing identified ORC binding sites.

```r
# Load peak replicates
data(orcPeaksRep1)
data(orcPeaksRep2)

# Inspect the peaks
print(orcPeaksRep1)
```

## Typical Workflows

### Comparing Replicates
You can use `GenomicRanges` functions to find overlapping peaks between the two replicates to identify high-confidence binding sites.

```r
library(GenomicRanges)

# Find overlaps between replicate 1 and replicate 2 peaks
commonPeaks <- subsetByOverlaps(orcPeaksRep1, orcPeaksRep2)
```

### Visualizing Coverage
Since the alignments are `GRanges` objects, you can easily calculate and plot coverage for chromosome XIV.

```r
# Calculate coverage
cov1 <- coverage(orcAlignsRep1)

# Plot a specific region on chromosome XIV
plot(as.numeric(cov1$chrXIV[100000:110000]), type="l", 
     main="ORC ChIP-seq Coverage (Rep 1)", xlab="Position", ylab="Depth")
```

## Data Details
- **Organism**: *Saccharomyces cerevisiae*
- **Genomic Region**: Chromosome XIV (subset)
- **Alignment Tool**: MAQ (max 3 mismatches, min Phred score 35)
- **Experiment Type**: ChIP-seq (Origin Recognition Complex)

## Reference documentation
- [EatonEtAlChIPseq Reference Manual](./references/reference_manual.md)