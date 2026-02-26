---
name: lodei
description: LoDEI identifies and quantifies differential A-to-I RNA editing levels across genomic regions between two groups of RNA-seq samples. Use when user asks to detect differential editing, quantify regional editing indices, or compare epitranscriptomic landscapes between experimental conditions.
homepage: https://github.com/rna-editing1/lodei
---


# lodei

## Overview

LoDEI (Local Differential Editing Index) is a specialized bioinformatics tool for identifying and quantifying differential RNA editing—specifically A-to-I transitions—between two sets of RNA-seq samples. It moves beyond single-site analysis to evaluate editing levels across defined genomic regions, providing a robust statistical framework for comparing experimental conditions. The tool is essential for researchers investigating the epitranscriptomic landscape in different tissues, developmental stages, or disease states.

## Installation and Setup

LoDEI is primarily distributed via Bioconda. It is recommended to run the tool within a dedicated environment:

```bash
conda create -c conda-forge -c bioconda --name lodei lodei
conda activate lodei
```

## Core Command: lodei find

The `find` subcommand is the primary entry point for detecting differential editing.

### Required Inputs
*   **BAM Files**: Sorted BAM files for both groups. Each `.bam` file must have a corresponding `.bai` index in the same directory.
*   **Reference Genome**: A FASTA file (`-f`) matching the one used for initial read mapping.
*   **Annotations**: A GFF3 file (`-g`) defining the regions (e.g., genes, exons) where editing should be calculated.

### Basic Usage Pattern
```bash
lodei find \
  --group1 sample1.bam sample2.bam sample3.bam \
  --group2 sample4.bam sample5.bam sample6.bam \
  -f reference.fa \
  -g annotations.gff3 \
  -o ./results_dir \
  --library SR \
  --min_coverage 5 \
  -c 8
```

## Expert Tips and Best Practices

### 1. Library Strandedness (`--library`)
LoDEI uses strandedness definitions similar to Salmon. Selecting the correct type is critical for accurate site identification:
*   **SR**: Single-end, reverse stranded (common for many Illumina protocols).
*   **SF**: Single-end, forward stranded.
*   **U**: Unstranded.
*   **ISR**: Paired-end, reverse stranded.
*   **ISF**: Paired-end, forward stranded.

### 2. Coverage Thresholds
The `--min_coverage` parameter filters out positions with low depth. A value of 5 is a standard starting point, but for high-depth datasets, increasing this can reduce noise and improve the reliability of the differential editing index. Note that this threshold must be met in **all** samples provided.

### 3. Performance Optimization
Use the `-c` flag to specify the number of CPU cores. LoDEI is designed to parallelize the processing of genomic regions, significantly reducing runtime on multi-core systems.

### 4. SNP Filtering
Consider using the `--rm_snps` flag if you have a list of known SNPs for your organism. This prevents genomic variations from being incorrectly identified as RNA editing events.

### 5. Output Interpretation
LoDEI generates multiple files in the output directory. The primary results are typically provided in tabular formats and BedGraph files (in newer versions) for visualization in genome browsers like IGV.

## Reference documentation
- [LoDEI GitHub Repository](./references/github_com_rna-editing1_lodei.md)
- [Bioconda LoDEI Package Overview](./references/anaconda_org_channels_bioconda_packages_lodei_overview.md)