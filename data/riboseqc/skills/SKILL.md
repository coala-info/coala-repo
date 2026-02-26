---
name: riboseqc
description: RiboseQC is an R package for the comprehensive quality control and analysis of ribosome profiling data. Use when user asks to evaluate Ribo-seq library quality, calculate P-site offsets, or generate interactive reports on triplet periodicity and codon usage.
homepage: https://github.com/ohlerlab/RiboseQC
---


# riboseqc

## Overview
RiboseQC (also known as Ribo-seQC) is a specialized R package designed for the comprehensive quality control of Ribosome Profiling (Ribo-seq) data. It provides a systematic workflow to evaluate the quality of sequencing libraries by focusing on read-length specific distributions across various genomic regions, such as CDS, UTRs, and non-coding RNAs. The tool is particularly effective at distinguishing between cytoplasmic and organellar (mitochondrial/chloroplast) ribosome activity and provides automated P-site offset selection and codon usage statistics.

## Installation
RiboseQC can be installed via Bioconda or directly from GitHub within an R environment.

**Using Conda:**
```bash
conda install bioconda::riboseqc
```

**Using R:**
```R
library("devtools")
install_github(repo = "lcalviell/Ribo-seQC")
library("RiboseQC")
```

## Core Workflow
The analysis consists of two primary steps: preparing the genomic annotation and running the analysis on mapped reads (BAM files).

### 1. Prepare Annotation Files
This step parses genomic features and must be performed once for every genome/annotation combination. It requires a GTF file and a 2bit genome file.

```R
# In R
prepare_annotation_files(
  annotation_directory = "path/to/annotation/",
  gtf_file = "path/to/genes.gtf",
  two_bit_file = "path/to/genome.2bit",
  output_file = "path/to/output_annotation.obj"
)
```
*Note: If you only have a FASTA file, convert it to 2bit using the UCSC `faToTwoBit` tool before running this command.*

### 2. Execute RiboseQC Analysis
The master function performs the full analysis, including P-site calculation and report generation.

```R
# In R
RiboseQC_analysis(
  annotation_obj = "path/to/output_annotation.obj",
  bam_files = c("sample1.bam", "sample2.bam"),
  fastqc_files = NULL, # Optional: path to FastQC results
  report_file = "RiboseQC_Report.html",
  sample_names = c("Control", "Treatment"),
  dest_all = "path/to/output_directory/"
)
```

## Expert Tips and Best Practices
- **P-site Offsets:** RiboseQC automatically attempts to calculate P-site offsets. If the automatic detection fails or looks incorrect in the HTML report, you can manually provide offsets using the `offsets` parameter in the analysis function.
- **Organellar Analysis:** The tool is highly effective for plants and animal cells with high mitochondrial content. Ensure your GTF and 2bit files include organellar sequences to see these specific read-length distributions.
- **Memory Management:** For very large BAM files, ensure your R session has sufficient memory, as the tool processes genomic regions to provide high-resolution mapping statistics.
- **Interactive Reports:** The output HTML report is self-contained and interactive. It is the primary way to validate if the Ribo-seq "triplet periodicity" (3-nt stepping) is present in your data, which is a hallmark of high-quality ribosome footprinting.

## Reference documentation
- [RiboseQC Overview](./references/anaconda_org_channels_bioconda_packages_riboseqc_overview.md)
- [RiboseQC GitHub README](./references/github_com_ohlerlab_RiboseQC.md)