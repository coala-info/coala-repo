---
name: bioconductor-oligoclasses
description: This package provides foundational S4 class infrastructure and data containers for handling high-throughput genomic array data within the oligo and crlmm frameworks. Use when user asks to manage SNP or expression array objects, perform genotype calling, estimate copy number, or handle large genomic datasets using disk-backed storage.
homepage: https://bioconductor.org/packages/release/bioc/html/oligoClasses.html
---


# bioconductor-oligoclasses

name: bioconductor-oligoclasses
description: Specialized R package for handling high-throughput array classes (SNP, Expression, Exon, Tiling) used by the oligo and crlmm packages. Use this skill when working with Bioconductor objects like CNSet, SnpSet2, FeatureSet, or AlleleSet, particularly for copy number estimation, genotype calling, or managing large genomic datasets using ff-based storage.

# bioconductor-oligoclasses

## Overview

The `oligoClasses` package provides the foundational S4 class infrastructure for the `oligo` and `crlmm` Bioconductor packages. It defines containers for locus-level summaries, genotype calls, and copy number estimates. A key feature is its support for "large data" through the `ff` package, allowing R to handle datasets that exceed available RAM by storing them on disk while maintaining matrix-like access.

## Core Classes and Workflows

### 1. FeatureSet and Extensions
These classes store feature-level data (e.g., intensities from CEL files).
- `ExpressionFeatureSet`: For gene expression arrays.
- `SnpFeatureSet`: For SNP-specific arrays.
- `TilingFeatureSet`: For tiling arrays.

### 2. SnpSet2 and AlleleSet
Used for summarized SNP data.
- `AlleleSet`: Stores allele-specific summaries (Allele A and Allele B).
- `SnpSet2`: An extension of `gSet` for genotype calls and confidence scores.

### 3. CNSet (Copy Number Set)
The primary container for allele-specific copy number estimation.
- **Slots**: `alleleA`, `alleleB`, `call`, `callProbability`, and `batch`.
- **Batch Effects**: Use `batch(object)` to access or set batch variables, which is critical for normalizing systematic differences in copy number estimation.

## Key Functions and Operations

### Data Accessors
- `calls(obj)`: Retrieve genotype calls (1: AA, 2: AB, 3: BB).
- `confs(obj)`: Retrieve confidence scores (automatically transforms integer representations back to probabilities).
- `copyNumber(obj)`: Access copy number estimates. Note: These are often stored as `integer * 100`; divide by 100 to restore the original scale.
- `baf(obj)`: Access B-Allele Frequencies.
- `chromosome(obj)` / `position(obj)`: Access genomic coordinates.

### Genomic Integration
- `makeFeatureGRanges(obj)`: Converts an `oligoClasses` object into a `GRanges` object for use with `GenomicRanges` tools.
- `chromosome2integer(chrom)`: Standardizes chromosome names (e.g., "X" to 23) for sorting.

### Large Data Management (ff)
If the `ff` package is loaded, `oligoClasses` can initialize objects on disk:
- `ldStatus()`: Check if large data support is enabled.
- `ldPath(path)`: Set the directory for temporary `ff` files.
- `open(obj)` / `close(obj)`: Manage file connections for `ff`-backed objects.

### Parallel Processing
- `ocLapply(X, FUN, ...)`: A wrapper for `lapply` that automatically uses a cluster if configured via `foreach` or `snow`.
- `ocSamples(n)` / `ocProbesets(n)`: Set limits on how many samples or probesets are processed in RAM at once to prevent memory exhaustion.

## Common Patterns

### Converting Probabilities to Integers
To save space, probabilities are often stored as integers:
```r
# Convert probability to integer
int_val <- p2i(0.95)
# Convert integer back to probability
prob_val <- i2p(int_val)
```

### Ordering Objects
Ensure objects are sorted by genomic position before analysis:
```r
if(!checkOrder(myObj)) {
  myObj <- myObj[order(chromosome(myObj), position(myObj)), ]
}
```

## Reference documentation
- [oligoClasses Reference Manual](./references/reference_manual.md)