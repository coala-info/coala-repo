---
name: rust-bio-tools
description: Rust-Bio-Tools is a suite of high-performance command-line utilities for processing genomic data formats like VCF, BCF, FASTQ, and BAM. Use when user asks to convert VCF files to text, match or split VCF records, filter and split FASTQ files, collapse reads using UMIs, or generate interactive HTML reports and plots for genomic data.
homepage: https://github.com/rust-bio/rust-bio-tools
---

# rust-bio-tools

## Overview

Rust-Bio-Tools (`rbt`) is a suite of ultra-fast, robust command-line utilities designed for common bioinformatics workflows. Built on the Rust-Bio library, it prioritizes performance and linear-time algorithms. It is particularly effective for handling large-scale genomic data where standard tools might be slow, specifically for tasks involving VCF tag extraction, FASTQ record filtering, and the creation of portable, interactive HTML visualizations for variant and alignment data.

## Command Line Usage and Patterns

### VCF/BCF Processing

*   **Convert VCF to Text**: Use `vcf-to-txt` to extract specific fields into a tab-delimited format. It is superior to standard tools for handling multiallelic sites by properly expanding records.
    ```bash
    rbt vcf-to-txt --info DP AF --format GQ < input.vcf > output.txt
    ```
*   **Fuzzy Matching**: Match records between two VCF files in linear time.
    ```bash
    rbt vcf-match file1.vcf file2.vcf > matched.vcf
    ```
*   **Splitting**: Split a VCF into N equal chunks while maintaining structural variant (BND) integrity.
    ```bash
    rbt vcf-split input.bcf folder/prefix --n-chunks 10
    ```

### FASTQ Manipulation

*   **Round-Robin Splitting**: Distribute reads across multiple files to ensure balanced processing in downstream pipelines.
    ```bash
    rbt fastq-split chunk1.fastq chunk2.fastq < input.fastq
    ```
*   **Filtering**: Quickly filter FASTQ records based on IDs or other criteria.
    ```bash
    rbt fastq-filter ids.txt < input.fastq > filtered.fastq
    ```

### BAM and Read Processing

*   **Depth Extraction**: Extract depth at specific loci efficiently.
    ```bash
    rbt bam-depth reference.fasta < input.bam --loci loci.bed
    ```
*   **UMI/Duplicate Collapsing**: Merge reads into consensus fragments using Unique Molecular Identifiers (UMIs) or duplicate marks.
    ```bash
    rbt collapse-reads-to-fragments bam < input.bam > collapsed.bam
    rbt collapse-reads-to-fragments fastq < fwd.fastq < rev.fastq > collapsed.fastq
    ```

### Interactive Reporting and Visualization

*   **Genomic Reports**: Generate standalone HTML reports containing interactive plots for VCF and BAM data.
    ```bash
    rbt vcf-report input.vcf reference.fasta --bam input.bam --output report/
    ```
*   **BAM Plotting**: Create a single HTML file visualizing a specific genomic region across multiple BAM files.
    ```bash
    rbt plot-bam reference.fasta region_coords --bam file1.bam file2.bam > plot.html
    ```

## Expert Tips

*   **Performance**: `rbt` tools are optimized for speed. When processing large datasets, prefer BCF over VCF for input to reduce parsing overhead.
*   **Multiallelic Sites**: When using `vcf-to-txt`, the tool automatically handles the expansion of multiallelic records, ensuring that each allele is represented correctly in the output text file.
*   **Anonymization**: For sharing data while maintaining privacy, use `bam-anonymize` (if available in the local environment) to strip sensitive metadata and sequence information while preserving alignment structures.



## Subcommands

| Command | Description |
|---------|-------------|
| rbt | A set of command-line utilities for bioinformatics in Rust. |
| rbt | A set of command-line utilities for bioinformatics, written in Rust. |
| rbt | A set of command-line utilities for bioinformatics tasks using the Rust-Bio library. |
| rbt | A collection of command-line utilities for bioinformatics in Rust. |
| rbt | A set of command-line utilities for bioinformatics, written in Rust. |
| rbt bam-anonymize | Tool to build artifical reads from real BAM files with identical properties |
| rbt collapse-reads-to-fragments | Tool to predict maximum likelihood fragment sequence from FASTQ or BAM files. |
| rbt csv-report | Creates report from a given csv file containing a table with the given data |
| rbt fastq-filter | Remove records from a FASTQ file (from STDIN), output to STDOUT. |
| rbt plot-bam | Creates a html file with a vega visualization of the given bam region that is then written to stdout. |
| rbt sequence-stats | Tool to compute stats on sequence file (from STDIN), output is in YAML with fields: min, max, average, median, nb_reads, nb_bases, n50. |
| rbt vcf-annotate-dgidb | Looks for interacting drugs in DGIdb and annotates them for every gene in every record. |
| rbt vcf-baf | Annotate b-allele frequency for each single nucleotide variant and sample. |
| rbt vcf-match | Annotate for each variant in a VCF/BCF at STDIN whether it is contained in a given second VCF/BCF. The matching is fuzzy for indels and exact for SNVs. Results are printed as BCF to STDOUT, with an additional INFO tag MATCHING. The two vcfs do not have to be sorted. |
| rbt vcf-report | Creates report from a given VCF file including a visual plot for every variant with the given BAM and FASTA file. The VCF file has to be annotated with VEP, using the options --hgvs and --hgvsg. |
| rbt vcf-split | Split a given VCF/BCF file into N chunks of approximately the same size. Breakends are kept together. Output type is always BCF. |
| rbt vcf-to-txt | Convert VCF/BCF file from STDIN to tab-separated TXT file at STDOUT. INFO and FORMAT tags have to be selected explicitly. |

## Reference documentation
- [Rust-Bio-Tools README](./references/github_com_rust-bio_rust-bio-tools_blob_master_README.md)
- [Rust-Bio-Tools Changelog](./references/github_com_rust-bio_rust-bio-tools_blob_master_CHANGELOG.md)