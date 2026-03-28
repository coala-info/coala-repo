---
name: goleft
description: goleft is a high-performance bioinformatics suite designed for rapid genomic alignment file manipulation and quality control using index metadata and sampling. Use when user asks to estimate cohort coverage from index files, calculate library statistics, split genomic regions for parallel processing, or extract sample metadata from BAM/CRAM headers.
homepage: https://github.com/brentp/goleft
---


# goleft

## Overview

goleft is a high-performance bioinformatics suite designed for efficient manipulation and quality control of genomic alignment files (BAM/CRAM). It excels at "lightweight" operations—tasks that usually require scanning entire files but can be approximated or accelerated using index metadata or sampling. Use this skill to quickly assess cohort coverage, extract sample metadata, or optimize parallel workflows without the computational overhead of full-file processing.

## Core Workflows and CLI Patterns

### Rapid Cohort QC with indexcov
The `indexcov` command is the most efficient way to estimate coverage across a cohort by using the linear index in BAM (.bai) or CRAM (.crai) files.

*   **Basic Usage**: `goleft indexcov -d output_directory/ *.bam`
*   **CRAM Support**: If using CRAM files without a reference available in the environment, provide the fasta index: `goleft indexcov -f reference.fasta.fai -d output_dir/ *.cram`
*   **Sex Inference**: Use the `--sex` flag to specify allosomes for sex estimation (e.g., `X,Y` or `chrX,chrY`).
*   **Excluding Regions**: By default, it excludes many "decoy" or "alt" contigs. Customize this with the `--exclude` regex.

### Estimating Library Statistics with covstats
Use `covstats` to get a quick estimate of median coverage and insert-size distribution by sampling reads rather than processing the entire file.

*   **Command**: `goleft covstats input.bam`
*   **Output**: Reports sample name, median coverage, and the 5th/95th percentiles of insert size.
*   **Expert Tip**: `covstats` automatically skips the first 100K reads to avoid biases often found at the very beginning of genomic files.

### Parallelization Optimization with indexsplit
When running tools like GATK or FreeBayes in parallel, use `indexsplit` to create genomic windows that contain roughly equal amounts of data (rather than equal base pairs).

*   **Balanced Splitting**: `goleft indexsplit -n 50 --ref reference.fasta *.bam > regions.bed`
*   **Cohort-wide Balance**: Always provide the full cohort of BAMs to `indexsplit` so the resulting regions are balanced for the total data volume across all samples.

### Parallel Depth Calculation
The `depth` command parallelizes `samtools` calls across user-defined windows.

*   **Command**: `goleft depth --window 500 --reference ref.fasta input.bam > output.depth`
*   **Matrix Generation**: Use `depthwed` to combine multiple `.depth` files into a single site-by-sample matrix.

### Metadata Extraction
*   **Sample Name**: To quickly extract the SM tag from the BAM header without using `samtools view -H | grep`, use: `goleft samplename input.bam`

## Best Practices

*   **Index Availability**: Ensure your BAM/CRAM files are indexed. `indexcov` and `indexsplit` rely entirely on the index files and will not work without them.
*   **Memory Efficiency**: `indexcov` is designed to handle thousands of samples simultaneously with minimal memory overhead.
*   **Visualization**: `indexcov` generates an `index.html` file with interactive plots (via Chart.js) and static PNGs. Always check the "slope" output in the generated `.ped` file to identify samples with potential coverage biases or library complexity issues.



## Subcommands

| Command | Description |
|---------|-------------|
| goleft | Estimate coverage statistics from BAM/CRAM files. |
| goleft | Calculate depth of coverage for BAM files. |
| goleft | Aggregate depth.bed files from goleft depth |
| goleft | Estimate coverage for BAM files |
| goleft | Splits indexed BAM/CRAM files into smaller regions based on a reference FASTA index. |
| goleft | Extract sample name(s) from a BAM file. |

## Reference documentation
- [goleft README](./references/github_com_brentp_goleft_blob_master_README.md)
- [goleft Version History and Subcommand Details](./references/github_com_brentp_goleft_blob_master_HISTORY.md)