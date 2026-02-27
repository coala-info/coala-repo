---
name: bioconductor-mtseekerdata
description: This package provides mitochondrial DNA experiment data and annotations for use with the MTseeker analysis ecosystem. Use when user asks to access MitoCarta protein inventories, load example mitochondrial sequencing alignments, or retrieve pre-called mitochondrial variants for benchmarking and demonstration.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/MTseekerData.html
---


# bioconductor-mtseekerdata

name: bioconductor-mtseekerdata
description: Access and utilize mitochondrial DNA (mtDNA) experiment data for the MTseeker package. Use this skill when you need example datasets for mitochondrial variant calling, including MitoCarta 2.0 annotations (hg19/mm10), Renal Oncocytoma and Normal Kidney Sample (RONKS) alignments, and pre-called mitochondrial variants.

## Overview

The `MTseekerData` package provides essential supporting data for the `MTseeker` ecosystem. It contains high-quality mitochondrial genomic resources, including protein inventories (MitoCarta) and real-world sequencing data (BAM-derived alignments and VCF-derived variants) from matched tumor/normal kidney samples. This data is primarily used for demonstrating mitochondrial analysis workflows, benchmarking variant callers, and annotating mitochondrial regions.

## Data Resources

The package provides four primary datasets accessible via the `data()` function:

### 1. MitoCarta 2.0 Annotations
MitoCarta is an inventory of mammalian mitochondrial proteins. These are provided as `GRanges` objects.
- `mitocarta2.hg19`: Human mitochondrial protein regions (hg19).
- `mitocarta2.mm10`: Mouse mitochondrial protein regions (mm10).

### 2. RONKS Sequencing Data
Data from Renal Oncocytoma (RO) and Normal Kidney Samples (NKS).
- `RONKSreads`: An `MAlignmentsList` object containing chrM reads from matched samples.
- `RONKSvariants`: An `MVRangesList` object containing mitochondrial variant calls derived from `RONKSreads`.

## Typical Workflows

### Loading and Inspecting Data
To use the datasets, you must load both the data package and the primary analysis package (`MTseeker`).

```r
library(MTseeker)
library(MTseekerData)

# Load MitoCarta for human
data(mitocarta2.hg19)
print(mitocarta2.hg19)

# Load RONKS variant calls
data(RONKSvariants)
show(RONKSvariants)
```

### Filtering Variants
The `RONKSvariants` object is an `MVRangesList`. You can use `endoapply` to perform operations across the list, such as filtering for high-quality "PASS" variants.

```r
# Filter for variants that passed quality controls
passed_variants <- endoapply(RONKSvariants, subset, PASS == TRUE)
```

### Integrating with MTseeker
The datasets in this package are designed to be used with `MTseeker` functions for visualization and analysis.

```r
# Example: Summarizing variants
# (Requires MTseeker functions)
# summarizeVariants(RONKSvariants)
```

## Usage Tips
- **Coordinate Systems**: Note that `RONKSreads` and `RONKSvariants` are aligned against `hg19_rCRSchrM` (GRCh37 with UCSC contig names). Ensure your reference genomes match when performing comparative analyses.
- **Object Classes**: The data uses specialized classes from `MTseeker` (e.g., `MAlignmentsList`, `MVRangesList`). These subclass standard Bioconductor containers like `GAlignmentsList` and `VRangesList`, making them compatible with standard genomic workflows.

## Reference documentation

- [MTseekerData Reference Manual](./references/reference_manual.md)