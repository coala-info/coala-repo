---
name: bioconductor-svanumt
description: This tool detects nuclear-mitochondrial DNA fusions from structural variant calls in VCF format. Use when user asks to identify mitochondrial DNA insertions into the nuclear genome, process breakend-centric GRanges objects for NUMT detection, or visualize mitochondrial fusion events.
homepage: https://bioconductor.org/packages/release/bioc/html/svaNUMT.html
---

# bioconductor-svanumt

name: bioconductor-svanumt
description: Detects nuclear-mitochondrial DNA fusions (NUMTs) from structural variant calls in VCF format. Use this skill when analyzing genomic data for mitochondrial insertions into the nuclear genome, specifically for processing breakend-centric GRanges objects to identify and visualize NUMT events.

# bioconductor-svanumt

## Overview
The `svaNUMT` package provides specialized tools for detecting Nuclear-mitochondrial DNA (NUMT) fusion events. It operates on structural variant (SV) calls, typically parsed from VCF files, and uses a breakend-centric data structure. The package identifies insertions of mitochondrial sequences into nuclear chromosomes by cross-referencing SV breakpoints with known mitochondrial sequences and reference NUMT sites.

## Workflow and Core Functions

### 1. Data Preparation
The package relies on `StructuralVariantAnnotation` to convert VCF data into a breakend-centric `GRanges` object.

```r
library(VariantAnnotation)
library(StructuralVariantAnnotation)
library(svaNUMT)

# Load VCF and convert to breakend-centric GRanges
vcf <- readVcf("path/to/your.vcf")
gr <- breakpointRanges(vcf)
```

### 2. Identifying NUMT Events
The primary function is `numtDetect()`. It requires the SV GRanges, a reference set of known NUMTs, and the mitochondrial genome sequence.

```r
# Load reference NUMT sites (e.g., from a text file or BED)
# Ensure seqlevelsStyle matches your genome (e.g., "NCBI" or "UCSC")
numtS <- GRanges(read.table("numt_reference.txt", header=TRUE))

# Load mitochondrial sequence from a BSgenome object
library(BSgenome.Hsapiens.UCSC.hg19)
genomeMT <- BSgenome.Hsapiens.UCSC.hg19$chrMT

# Detect NUMTs
# max_ins_dist: maximum distance for grouping insertion sites
NUMT <- numtDetect(gr, numtS, genomeMT, max_ins_dist = 20)
```

### 3. Interpreting Results
The output of `numtDetect` is a nested list structure. The most relevant components are:
- `NUMT$MT$NU`: Breakends on the nuclear genome supporting the insertion.
- `NUMT$MT$MT`: Breakends on the mitochondrial genome supporting the insertion.

To view a specific detected event:
```r
# View the first detected event for chromosome 1
event_idx <- 1
GRangesList(NU = NUMT$MT$NU$`1`[[event_idx]], 
            MT = NUMT$MT$MT$`1`[[event_idx]])
```

### 4. Visualization
You can visualize the fusion events using circos plots via the `circlize` package.

```r
library(circlize)

# Prepare pairs for plotting
numt_ranges <- c(NUMT$MT$NU$`1`[[1]], NUMT$MT$MT$`1`[[1]])
pairs <- breakpointgr2pairs(numt_ranges)

# Initialize and plot
circos.initializeWithIdeogram(plotType = c("ideogram", "labels"))
circos.genomicLink(as.data.frame(S4Vectors::first(pairs)), 
                   as.data.frame(S4Vectors::second(pairs)))
circos.clear()
```

## Tips and Best Practices
- **Coordinate Consistency**: Ensure that the `seqlevelsStyle` (e.g., "UCSC" vs "NCBI") is consistent across your SV GRanges, the reference NUMT list, and the BSgenome object.
- **Breakpoint Validity**: `numtDetect` expects a `GRanges` object composed of valid breakpoints. Use `StructuralVariantAnnotation` utilities to ensure consistency if the VCF parsing is complex.
- **Filtering**: If the output is too noisy, consider filtering the input VCF for high-quality (PASS) variants or specific quality score thresholds before running the detection.

## Reference documentation
- [svaNUMT Quick Overview](./references/svaNUMT.md)
- [svaNUMT RMarkdown Source](./references/svaNUMT.Rmd)