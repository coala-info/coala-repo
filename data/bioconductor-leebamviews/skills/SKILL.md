---
name: bioconductor-leebamviews
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/leeBamViews.html
---

# bioconductor-leebamviews

## Overview

The `leeBamViews` package provides a lightweight infrastructure for managing multiple Next-Generation Sequencing (NGS) samples. It centers around the `BamViews` class, which allows users to treat a collection of BAM files similarly to an `ExpressionSet`. This skill facilitates the programmatic access to BAM data, extraction of coverage information, and integration with downstream statistical tools like `edgeR`.

## Core Workflows

### Initializing a BamViews Object

To manage multiple samples, you must define the paths to BAM files and provide sample metadata.

```r
library(leeBamViews)
library(S4Vectors)

# Locate BAM files within the package
bpaths <- dir(system.file("bam", package="leeBamViews"), full=TRUE, patt="bam$")

# Create sample metadata (DataFrame)
# Example: extracting genotype from filenames
gt <- gsub(".*/", "", bpaths)
geno <- gsub("_.*", "", gt)
pd <- DataFrame(geno=geno, row.names=paste(geno, seq_along(geno), sep="."))

# Construct the BamViews object
bs1 <- BamViews(bamPaths=bpaths, bamSamples=pd)
```

### Defining Genomic Ranges

A `BamViews` object requires a `GRanges` object to specify which regions of the genome to interrogate.

```r
library(GenomicRanges)
# Define regions on yeast chromosome XIII (Scchr13)
START <- c(861250, 863000)
END <- c(862750, 864000)
exc <- GRanges(seqnames="Scchr13", IRanges(start=START, end=END), strand="+")

# Assign ranges to the BamViews object
bamRanges(bs1) <- exc
```

### Extracting Coverage and Counts

Once ranges are defined, you can extract coverage or tabulate reads across all samples.

```r
library(GenomicAlignments)

# Extract coverage for a specific chromosome
covex <- RleList(lapply(bamPaths(bs1), function(x) {
  coverage(readGAlignments(x))[["Scchr13"]]
}))

# Tabulate reads in the defined bamRanges
# Returns a matrix of counts (ranges x samples)
tab <- tabulateReads(bs1, strandmarker="+")
```

### Differential Expression with edgeR

`leeBamViews` integrates with `edgeR` for statistical analysis of read counts.

```r
library(edgeR)

# 1. Get total library sizes
totcnts <- totalReadCounts(bs1)

# 2. Create DGEList
# Note: annotab is the result of tabulateReads()
dgel1 <- DGEList(counts=t(annotab), 
                 group=factor(bamSamples(bs1)$geno), 
                 lib.size=totcnts)

# 3. Estimate dispersion and test
cd <- estimateCommonDisp(dgel1)
et12 <- exactTest(cd)
topTags(et12)
```

## Tips and Best Practices

- **Chromosome Naming**: Ensure `seqnames` match the BAM header. In this package's yeast data, chromosome XIII is often referred to as "Scchr13".
- **Strand Specificity**: Use the `strandmarker` argument in `tabulateReads` to control how strand information is handled during counting.
- **Memory Management**: `BamViews` manages data external to R. Data is only imported into memory when specific interrogation functions (like `readGAlignments` or `tabulateReads`) are called.
- **Metadata Access**: Use `bamSamples(bs1)` to access or modify the sample metadata and `bamPaths(bs1)` to retrieve the file locations.

## Reference documentation

- [Managing and analyzing multiple NGS samples with Bioconductor bamViews objects](./references/leeViews.md)