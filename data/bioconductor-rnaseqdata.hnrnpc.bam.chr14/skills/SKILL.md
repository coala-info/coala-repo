---
name: bioconductor-rnaseqdata.hnrnpc.bam.chr14
description: The package contains 8 BAM files, 1 per sequencing run. Each BAM file was obtained by (1) aligning the reads (paired-end) to the full hg19 genome with TopHat2, and then (2) subsetting to keep only alignments on chr14. See accession number E-MTAB-1147 in the ArrayExpress database for details about the experiment, including links to the published study (by Zarnack et al., 2012) and to the FASTQ files.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RNAseqData.HNRNPC.bam.chr14.html
---

# bioconductor-rnaseqdata.hnrnpc.bam.chr14

## Overview

Use the Bioconductor R package **RNAseqData.HNRNPC.bam.chr14** for: The package contains 8 BAM files, 1 per sequencing run. Each BAM file was obtained by (1) aligning the reads (paired-end) to the full hg19 genome with TopHat2, and then (2) subsetting to keep only alignments on chr14. See accession number E-MTAB-1147 in the ArrayExpress database for details about the experiment, including links to the published study (by Zarnack et al., 2012) and to the FASTQ files.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RNAseqData.HNRNPC.bam.chr14")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.