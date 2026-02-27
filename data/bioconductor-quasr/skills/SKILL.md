---
name: bioconductor-quasr
description: The QuasR package provides an integrated workflow for preprocessing, aligning, and quantifying high-throughput sequencing data such as ChIP-seq, RNA-seq, and Bisulfite-seq within R. Use when user asks to align reads to a reference genome, perform quality control on sequencing data, quantify genomic features, or analyze DNA methylation patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/QuasR.html
---


# bioconductor-quasr

name: bioconductor-quasr
description: Comprehensive analysis of high-throughput sequencing data (ChIP-seq, RNA-seq, smRNA-seq, and Bis-seq) using the QuasR Bioconductor package. Use this skill to perform read preprocessing, alignment (via Rbowtie or Rhisat2), quality control, and quantification of genomic features in R.

# bioconductor-quasr

## Overview
The `QuasR` (Quantify and Annotate Short Reads in R) package provides an integrated workflow for analyzing sequencing experiments. It manages the transition from raw sequence files (FASTA/FASTQ) to alignments (BAM) and finally to count tables or methylation reports. It is particularly powerful for managing complex projects via a `qProject` object, which tracks metadata, alignment parameters, and file locations.

## Core Workflow

### 1. Project Initialization
The foundation of a QuasR analysis is the `qProject` object created by `qAlign`. You must provide a sample file and a reference genome.

```r
library(QuasR)

# Define inputs
sampleFile <- "samples.txt" # Tab-delimited: FileName, SampleName
genomeFile <- "hg19.fa"     # Or a BSgenome name like "BSgenome.Hsapiens.UCSC.hg19"

# Create project and perform alignments
proj <- qAlign(sampleFile, genomeFile)
```

### 2. Read Preprocessing
Use `preprocessReads` to clean data before alignment (e.g., adapter trimming, quality filtering).
- `truncateEndBases`: Remove fixed number of bases.
- `Lpattern` / `Rpattern`: Trim 5' or 3' adapters.
- `minLength`: Discard reads shorter than threshold.

### 3. Alignment Options
`qAlign` behavior changes based on the experiment type:
- **RNA-seq (Spliced)**: Set `splicedAlignment = TRUE` and `aligner = "Rhisat2"`.
- **Bisulfite-seq**: Set `bisulfite = "dir"` (directional) or `"undir"`.
- **Allele-specific**: Provide a `snpFile` (tab-delimited: chr, pos, ref, alt).
- **Auxiliary Targets**: Use `auxiliaryFile` to align reads to contaminants (e.g., phiX, vectors).

### 4. Quality Control and Stats
- `qQCReport(proj, pdfFilename = "QC.pdf")`: Generates a comprehensive PDF with quality metrics.
- `alignmentStats(proj)`: Returns a data frame with mapped/unmapped counts per sample.

### 5. Quantification
QuasR provides several functions to extract data from BAM files:

- **qCount**: Counts alignments in query regions.
  - `query`: A `GRanges` or `TxDb` object.
  - `reportLevel`: "gene", "exon", "junction", or "pair".
- **qProfile**: Calculates average alignment density around anchor points (e.g., TSS).
- **qMeth**: Specifically for Bis-seq; calculates methylation states at Cytosine positions.
- **qExportWig**: Exports coverage tracks for visualization in genome browsers.

## Typical Task Patterns

### RNA-seq Gene Quantification
```r
library(GenomicFeatures)
txdb <- makeTxDbFromGFF("annotation.gtf")
geneCounts <- qCount(proj, txdb, reportLevel = "gene")
```

### Calculating RPKM
```r
counts <- qCount(proj, txdb, reportLevel = "gene")
rpkm <- t(t(counts[,-1] / counts[,1] * 1000) / colSums(counts[,-1]) * 1e6)
```

### CpG Methylation Analysis
```r
# mode="CpGcomb" combines plus and minus strand counts for CpG sites
meth <- qMeth(proj, mode = "CpGcomb")
# Calculate percentage: (Methylated / Total) * 100
percMeth <- mcols(meth)[, "Sample1_M"] / mcols(meth)[, "Sample1_T"] * 100
```

## Tips for Success
- **File Persistence**: QuasR creates `.txt` files alongside BAM files to store alignment parameters. Do not delete these, as `qAlign` uses them to skip redundant alignment steps.
- **Memory/Speed**: For large projects, use the `clObj` argument in `qAlign` and `qCount` to pass a cluster object (from `parallel` package) for multi-core processing.
- **Genome Selection**: When using human genomes, prefer "primary assembly" or "analysis set" versions to avoid multi-mapping issues caused by redundant alternative loci in standard UCSC versions.

## Reference documentation
- [An introduction to QuasR](./references/QuasR.md)