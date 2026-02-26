---
name: bioconductor-esatac
description: bioconductor-esatac provides a systematic, end-to-end pipeline for analyzing ATAC-seq and DNase-seq data within the R environment. Use when user asks to process raw FASTQ files, align reads to a reference genome, call peaks, annotate genomic features, or generate quality control reports for chromatin accessibility data.
homepage: https://bioconductor.org/packages/release/bioc/html/esATAC.html
---


# bioconductor-esatac

name: bioconductor-esatac
description: Systematic pipeline for ATAC-seq and DNase-seq data analysis. Use this skill when processing raw FASTQ files, performing quality control, aligning reads, calling peaks, and annotating ATAC-seq data within the R environment.

# bioconductor-esatac

## Overview

`esATAC` is a dataflow-graph-based R package designed for end-to-end ATAC-seq data analysis. It streamlines the transition from raw sequencing reads to statistical results and quality control reports. The package integrates several tools (AdapterRemoval, Bowtie2, F-seq) and R packages (Rsamtools, ChIPpeakAnno) into a unified framework. It is memory-efficient (typically < 8GB RAM) and supports both single-end and paired-end Illumina data.

## Core Workflows

### 1. Preset Pipeline (End-to-End)
The simplest way to use `esATAC` is through the `atacPipe` function, which executes a complete pipeline from FASTQ to an HTML report.

```r
library(esATAC)

# Define paths to FASTQ files (paired-end example)
read1 <- "path/to/reads_R1.fastq.gz"
read2 <- "path/to/reads_R2.fastq.gz"

# Run the full pipeline
# genome: e.g., "hg19", "mm10"
# tmp.dir: directory for intermediate files
atacPipe(r1 = read1, r2 = read2, genome = "hg19", container = "output_folder")
```

### 2. Customizing Workflows
`esATAC` uses a "Pipe-Component" architecture. You can start from intermediate stages (e.g., BAM files) by calling specific functions or linking components.

**Common Components:**
- `atacRenamer`: Standardize read names.
- `atacTrimAdapter`: Remove sequencing adapters.
- `atacBowtie2Align`: Align reads to a reference genome.
- `atacRemoveDuplicate`: Remove PCR duplicates.
- `atacPeakCalling`: Identify open chromatin regions (peaks).
- `atacAnnotation`: Annotate peaks with genomic features.

### 3. Data Management
The package manages variables through a dataflow graph, allowing users to pass variables between processes seamlessly.

```r
# Example of a partial workflow
# 1. Alignment
bam_file <- atacBowtie2Align(fastqInput1 = "trimmed_R1.fq", 
                             fastqInput2 = "trimmed_R2.fq", 
                             genome = "hg19")

# 2. Peak Calling on the resulting BAM
peaks <- atacPeakCalling(bamInput = bam_file)
```

## Tips for Success

- **Genome Installation**: Ensure the required genome data (BSgenome and Bowtie2 indices) are installed and accessible to the R session.
- **Memory**: While efficient, processing large FASTQ files still benefits from 8-16GB of RAM.
- **HTML Reports**: Always check the generated HTML report in the output container; it provides critical QC metrics like fragment size distribution and TSS enrichment.
- **Input Formats**: The package accepts FASTQ, SAM, BAM, and BED files, making it compatible with data from repositories like GEO or ENCODE.

## Reference documentation

- [esATAC Introduction](./references/esATAC-Introduction.md)
- [esATAC RMarkdown Source](./references/esATAC-Introduction.Rmd)