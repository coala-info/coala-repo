---
name: goleft
description: Goleft is a high-performance bioinformatics suite for rapid genomic data processing and quality control. Use when user asks to estimate coverage from index files, calculate insert-size statistics, parallelize depth calculations, or split genomic regions for balanced workloads.
homepage: https://github.com/brentp/goleft
---


# goleft

## Overview
goleft is a high-performance bioinformatics suite written in Go that provides a collection of tools for genomic data processing. It is designed to be fast and efficient, often utilizing file indexes or sampling methods to provide results in a fraction of the time required by traditional tools. Use this skill to perform rapid quality control, estimate coverage statistics, and prepare genomic regions for parallelized analysis pipelines.

## Core Commands and Usage

### Rapid Coverage Estimation (indexcov)
The `indexcov` tool is the most prominent feature of goleft. It estimates coverage using only the BAM/CRAM index files (.bai/.crai), allowing it to process thousands of samples in seconds.

*   **Basic Usage**: `goleft indexcov --directory output_dir/ *.bam`
*   **Best Practice**: Use this for large cohorts to identify sex mismatches, aneuploidy, or samples with failed library preparation.
*   **Note**: While it supports CRAM, it is most optimized for BAI files. If using CRAM, ensure you have the reference fasta available or indexed.

### Coverage and Insert-Size Statistics (covstats)
Estimates statistics by sampling the BAM/CRAM file rather than reading every record.

*   **Basic Usage**: `goleft covstats input.bam`
*   **Output**: Provides mean coverage, standard deviation, and insert-size metrics.
*   **Expert Tip**: Use this for a "sanity check" on new sequencing data before committing to a full analysis pipeline.

### Parallel Depth Calculation (depth)
Parallelizes calls to samtools to calculate depth across user-defined windows.

*   **Basic Usage**: `goleft depth --windowsize 1000 --processes 4 input.bam`
*   **Workflow**: This is significantly faster than standard `samtools depth` for generating windowed coverage across the genome.

### Cohort Parallelization (indexsplit)
Generates genomic regions containing roughly equal amounts of data to ensure balanced workloads in parallel processing.

*   **Basic Usage**: `goleft indexsplit --n 20 *.bam`
*   **Use Case**: Use the output to feed into a variant caller (like GATK or FreeBayes) to ensure that each parallel process takes approximately the same amount of time.

### Utility Commands
*   **samplename**: Quickly extract the SM tag from a BAM header: `goleft samplename input.bam`
*   **depthwed**: Convert the output of the `depth` command into a matrix format (n-sites by n-samples), useful for downstream R or Python analysis.

## Common CLI Patterns

### Quality Control Pipeline
To quickly assess a new batch of BAM files:
1. Run `goleft indexcov` to check for large-scale coverage anomalies.
2. Run `goleft covstats` on a subset of files to verify library insert sizes.

### Efficient Parallelization
To split a genome into 50 balanced chunks for a cohort:
`goleft indexsplit --n 50 --ref reference.fasta.fai *.bam > regions.bed`

## Reference documentation
- [github_com_brentp_goleft.md](./references/github_com_brentp_goleft.md)
- [anaconda_org_channels_bioconda_packages_goleft_overview.md](./references/anaconda_org_channels_bioconda_packages_goleft_overview.md)