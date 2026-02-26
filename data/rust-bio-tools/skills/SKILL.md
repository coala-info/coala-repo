---
name: rust-bio-tools
description: rust-bio-tools is a suite of high-performance command-line utilities for processing and analyzing Next-Generation Sequencing data. Use when user asks to manipulate VCF/BCF files, split or filter FASTQ files, extract BAM depth, collapse reads, or generate interactive HTML reports for genomic data.
homepage: https://github.com/rust-bio/rust-bio-tools
---


# rust-bio-tools

## Overview

`rust-bio-tools` (invoked via the `rbt` command) is a suite of ultra-fast, robust command-line utilities designed for common bioinformatics tasks. Built on the Rust-Bio library, it provides linear-time implementations for processing Next-Generation Sequencing (NGS) data. It is particularly useful for researchers needing to manipulate VCF/BCF files, split or filter FASTQ files, extract depth information from BAM files, or generate portable, interactive HTML reports for variant and alignment visualization.

## Common CLI Patterns

### VCF/BCF Manipulation
*   **Fuzzy Matching**: Compare two VCF/BCF files in linear time.
    ```bash
    rbt vcf-match file1.vcf file2.vcf > matched.vcf
    ```
*   **Flexible Conversion**: Convert VCF/BCF to a tab-delimited text format. This tool is superior to simple parsers as it correctly handles multiallelic sites and allows specific tag selection.
    ```bash
    rbt vcf-to-txt --info DP AF --format AD < input.vcf > output.txt
    ```
*   **Splitting**: Divide a VCF/BCF into N equal chunks while maintaining BND (breakend) record integrity.
    ```bash
    rbt vcf-split input.vcf chunk1.vcf chunk2.vcf ...
    ```

### FASTQ Processing
*   **Round-Robin Splitting**: Split FASTQ files into a specific number of chunks efficiently.
    ```bash
    rbt fastq-split chunk1.fastq chunk2.fastq < input.fastq
    ```
*   **Filtering**: Filter records from a FASTQ file based on a list of IDs.
    ```bash
    rbt fastq-filter ids.txt < input.fastq > filtered.fastq
    ```

### BAM Utilities
*   **Depth Extraction**: Extract depth information at specific loci.
    ```bash
    rbt bam-depth input.bam < loci.bed > depth.txt
    ```
*   **Read Collapsing**: Merge BAM or FASTQ reads using Unique Molecular Identifiers (UMIs) or duplicate marks to create consensus fragments.
    ```bash
    rbt collapse-reads-to-fragments bam input.bam output.bam
    rbt collapse-reads-to-fragments fastq input_R1.fq input_R2.fq output_R1.fq output_R2.fq
    ```
*   **Anonymization**: Remove sensitive metadata from BAM files.
    ```bash
    rbt bam-anonymize input.bam output.bam
    ```

### Interactive Reporting and Visualization
*   **VCF Reports**: Generate an interactive HTML report with plots for VCF and BAM data.
    ```bash
    rbt vcf-report input.vcf --bam input.bam --reference ref.fasta --output report_dir/
    ```
*   **BAM Plotting**: Create a single HTML file containing visualizations for specific genomic regions across one or multiple BAM files.
    ```bash
    rbt plot-bam reference.fasta region_coords input1.bam input2.bam > plot.html
    ```
*   **CSV Reports**: Transform a standard CSV file into an interactive HTML report with built-in visualization capabilities.
    ```bash
    rbt csv-report input.csv --output report_dir/
    ```

## Expert Tips
*   **Performance**: `rbt` is optimized for speed and memory safety. Use it as a faster alternative to Python or Perl-based scripts for large-scale NGS datasets.
*   **Piping**: Most `rbt` tools support standard input/output, making them ideal for inclusion in shell-based bioinformatics pipelines.
*   **Multiallelic Handling**: When using `vcf-to-txt`, the tool automatically expands multiallelic sites into multiple rows, ensuring that no information is lost during conversion to tabular format.
*   **GSL Dependency**: Note that `rust-bio-tools` depends on the GNU Scientific Library (GSL). Ensure `libgsl-dev` (Ubuntu), `gsl` (Arch/OSX), or the equivalent is installed in your environment.

## Reference documentation
- [GitHub Repository - rust-bio-tools](./references/github_com_rust-bio_rust-bio-tools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_rust-bio-tools_overview.md)