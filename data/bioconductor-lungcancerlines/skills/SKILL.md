---
name: bioconductor-lungcancerlines
description: This package provides RNA-seq data and a TP53 genomic reference for H1993 and H2073 lung cancer cell lines. Use when user asks to retrieve BAM or Fastq file paths for these cell lines, access the TP53Genome object, or perform genomic analysis workflows on lung cancer datasets.
homepage: https://bioconductor.org/packages/release/data/experiment/html/LungCancerLines.html
---


# bioconductor-lungcancerlines

name: bioconductor-lungcancerlines
description: Access and utilize RNA-seq data from H1993 (metastatic) and H2073 (primary) lung cancer cell lines. Use this skill when a user needs to retrieve BAM or Fastq file paths for these specific cell lines, or when working with the TP53Genome object for genomic analysis in R.

# bioconductor-lungcancerlines

## Overview
The `LungCancerLines` package provides a small, curated dataset from an RNA-seq experiment comparing two lung cancer cell lines: H1993 (met) and H2073 (primary). The data is specifically processed for use with the `gmapR` and `VariationTools` packages, focusing on the TP53 gene region (including a 1-megabase buffer on each side). It serves as a standard dataset for testing alignment, variant calling, and genomic visualization workflows.

## Loading the Package
To begin using the data, load the library in R:

```r
library(LungCancerLines)
```

## Accessing Data Files

### BAM Files
The package includes BAM files containing read alignments that were processed using `HTSeqGenie` and aligned to the `TP53Genome`. These files contain only unique alignments.

```r
# Returns a BamFileList object pointing to H1993 and H2073 BAMs
bams <- LungCancerBamFiles()
```

### Fastq Files
If you need the raw sequence reads for alignment testing:

```r
# Returns a named character vector of file paths
fastqs <- LungCancerFastqFiles()
# Names follow the pattern: H1993.first, H1993.last, H2073.first, H2073.last
```

## Working with the TP53 Genome
The package provides a specialized `GmapGenome` object representing the TP53 gene region. This is often used as a reference for alignment or variant detection tools in the Bioconductor ecosystem.

```r
# Load the TP53 genome object
data(p53Genome)

# The object 'p53Genome' is now available in the environment
print(p53Genome)
```

## Typical Workflow
1. **Data Retrieval**: Use `LungCancerBamFiles()` to get paths to pre-aligned data.
2. **Reference Setup**: Load `data(p53Genome)` to provide the genomic context.
3. **Downstream Analysis**: Pass the BAM files and the genome object to packages like `VariantTools` to identify mutations or `gmapR` for alignment tasks.

## Reference documentation
- [LungCancerLines Reference Manual](./references/reference_manual.md)