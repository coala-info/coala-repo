---
name: bioconductor-rmat
description: This tool analyzes Affymetrix tiling array data from ChIP-chip experiments to identify protein-DNA interaction sites. Use when user asks to parse BPMAP and CEL files, perform sequence-specific normalization, compute MATScores, or identify enriched genomic regions.
homepage: https://bioconductor.org/packages/3.5/bioc/html/rMAT.html
---

# bioconductor-rmat

name: bioconductor-rmat
description: Analysis of Affymetrix tiling array data (ChIP-chip) using the rMAT package. Use this skill to parse BPMAP and CEL files, perform sequence-specific normalization (MAT or PairBinned models), compute MATScores, and identify enriched genomic regions (peaks).

# bioconductor-rmat

## Overview
The `rMAT` package provides a comprehensive pipeline for analyzing ChIP-chip experiments conducted on Affymetrix tiling arrays. It utilizes a C++ based Fusion SDK for efficient data parsing and implements the Model-based Analysis of Tiling-arrays (MAT) algorithm. This algorithm accounts for probe-specific effects—such as GC content and position-dependent base effects—to normalize signal intensities and identify protein-DNA interaction sites.

## Typical Workflow

### 1. Data Loading and Parsing
The package requires a `.BPMAP` file (array design) and one or more `.CEL` files (intensity data).

```R
library(rMAT)

# Define paths to files
bpmapFile <- "path/to/your.bpmap"
celFiles <- c("sample1.CEL", "sample2.CEL")

# Optional: Check BPMAP header to identify sequences (chromosomes)
seqHeader <- ReadBPMAPAllSeqHeader(bpmapFile)

# Parse files into a tilingSet object
# Use groupName to filter for specific genomes (e.g., "Sc" for S. cerevisiae)
ScSet <- BPMAPCelParser(bpmapFile, celFiles, verbose = FALSE, groupName = "Sc")
summary(ScSet)
```

### 2. Normalization
Normalization transforms raw intensities into comparable values using sequence-specific models.

```R
# method can be "MAT" or "PairBinned"
# "MAT" is the standard model; "PairBinned" accounts for adjacent base interactions
ScSetNorm <- NormalizeProbes(ScSet, method = "MAT", robust = FALSE, standard = TRUE)
```

### 3. Scoring and Peak Calling
After normalization, compute enrichment scores (MATScores) and define regions of interest.

```R
# 1. Compute MATScores (returns a RangedData object)
# dMax: Maximum DNA fragment size (e.g., 600bp)
RD <- computeMATScore(ScSetNorm, cName = NULL, dMax = 600)

# 2. Call Enriched Regions
# threshold: MATScore or FDR threshold depending on 'method'
Enrich <- callEnrichedRegions(RD, dMax = 600, dMerge = 300, nProbesMin = 8, 
                              method = "score", threshold = 1)
```

### 4. Visualization
Results can be visualized using `rtracklayer` (for UCSC Genome Browser) or `GenomeGraphs`.

```R
library(rtracklayer)
library(GenomeGraphs)

# Export to UCSC
genome(Enrich) <- "sacCer2" # Example genome build
session <- browserSession("UCSC")
track(session, "rMAT_Results") <- Enrich
```

## Key Functions
- `BPMAPCelParser`: Main entry point for reading Affymetrix binary files.
- `NormalizeProbes`: Implements the MAT normalization algorithm.
- `computeMATScore`: Calculates the enrichment score for each probe window.
- `callEnrichedRegions`: Identifies peaks based on score, p-value, or FDR.

## Tips and Requirements
- **System Dependencies**: Ensure the GNU Scientific Library (GSL) and BLAS are installed on the system.
- **Memory**: Parsing large tiling arrays can be memory-intensive; use the `groupName` argument in `BPMAPCelParser` to load only relevant chromosomes if memory is limited.
- **Normalization**: The current implementation of `NormalizeProbes` is optimized for 25-mer probes.

## Reference documentation
- [rMAT](./references/rMAT.md)