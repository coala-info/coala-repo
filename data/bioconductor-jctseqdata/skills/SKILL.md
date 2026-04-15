---
name: bioconductor-jctseqdata
description: This package provides example RNA-Seq datasets, annotation files, and count tables formatted for the JunctionSeq and QoRTs R packages. Use when user asks to access sample datasets for testing differential exon usage, retrieve GTF or GFF annotation files, or load pre-processed JunctionSeqCountSet objects for demonstration purposes.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/JctSeqData.html
---

# bioconductor-jctseqdata

name: bioconductor-jctseqdata
description: Provides example data for the JunctionSeq and QoRTs R packages. Use this skill when you need to access sample RNA-Seq datasets, annotation files (GTF/GFF), or count tables for testing differential expression, differential exon usage, and splice junction analysis workflows.

# bioconductor-jctseqdata

## Overview

The `JctSeqData` package is a Bioconductor experiment data package. It contains data produced by the QoRTs (Quality of RNA-Seq ToolSet) pipeline, specifically formatted for use with the `JunctionSeq` and `DEXSeq` R packages. The data is derived from a subset of rat pineal gland samples (ribosome-depleted, paired-end RNA-Seq) and is intended for demonstration and testing purposes.

## Loading Data Objects

The package provides pre-processed `JunctionSeqCountSet` objects that can be loaded directly into the R environment.

```r
# Load the full example dataset (subset of chromosomes)
data(fullExampleDataSet, package="JctSeqData")

# Load the "tiny" dataset (subset of genes for rapid testing)
data(exampleDataSet, package="JctSeqData")

# The objects are typically named 'jscs2' (full) and 'jscs' (tiny)
# Check the object
print(jscs)
```

## Accessing Raw Files

Many workflows require paths to raw count files or annotation files. Use `system.file` to retrieve these paths.

### Annotation Files
The package includes GTF and flattened GFF files required for differential exon/junction usage analysis.

```r
# Path to the flattened GFF for JunctionSeq
gff_file <- system.file("extdata/annoFiles/JunctionSeq.flat.gff.gz", package="JctSeqData")

# Path to the sample decoder (metadata)
decoder_file <- system.file("extdata/annoFiles/decoder.bySample.txt", package="JctSeqData")
decoder <- read.table(decoder_file, header=TRUE, stringsAsFactors=FALSE)
```

### Count Files
Count files are organized by sample ID and type (gene, exon, or junction).

```r
# Get paths for JunctionSeq count files for all samples in the decoder
count_files <- system.file(paste0("extdata/cts/", 
                                  decoder$sample.ID, 
                                  "/QC.spliceJunctionAndExonCounts.forJunctionSeq.txt.gz"), 
                           package="JctSeqData")

# Get paths for DEXSeq-formatted exon counts
exon_files <- system.file(paste0("extdata/cts/", 
                                 decoder$sample.ID, 
                                 "/QC.exonCounts.formatted.for.DEXSeq.txt.gz"), 
                          package="JctSeqData")
```

## Typical Workflow with JunctionSeq

A common use case is initializing a `JunctionSeq` analysis using the paths provided by this package.

```r
library(JunctionSeq)

# 1. Define paths
decoder_file <- system.file("extdata/annoFiles/decoder.bySample.txt", package="JctSeqData")
decoder <- read.table(decoder_file, header=TRUE)

count_files <- system.file(paste0("extdata/cts/", 
                                  decoder$sample.ID, 
                                  "/QC.spliceJunctionAndExonCounts.forJunctionSeq.txt.gz"), 
                           package="JctSeqData")

gff_file <- system.file("extdata/annoFiles/JunctionSeq.flat.gff.gz", package="JctSeqData")

# 2. Run analysis (example using the tiny subset for speed)
# Note: In a real workflow, you would use the paths defined above.
# Here we use the pre-loaded 'exampleDataSet'
data(exampleDataSet, package="JctSeqData")
# jscs is now available for plotting or testing
buildAllPlots(jscs, geneIDs = "ENSRNOG00000000044", out.dir = "plots/")
```

## Tips
- **Tiny Dataset**: Always use the `tiny` dataset or the `extdata/tiny/` directory for quick code verification, as the full example dataset still contains thousands of features.
- **Novel Junctions**: The package includes files with the suffix `withNovel` which contain counts for unannotated splice junctions identified by QoRTs.
- **Chromosomes**: The data is limited to reads mapping to chr14, chr15, chrX, and chrM to keep the package size manageable.

## Reference documentation
- [JunctionSeqExampleData](./references/JunctionSeqExampleData.md)