---
name: dsh-bio
description: The `dsh-bio` suite provides a collection of high-performance command-line utilities for genomic data manipulation.
homepage: https://github.com/heuermh/dishevelled-bio
---

# dsh-bio

## Overview
The `dsh-bio` suite provides a collection of high-performance command-line utilities for genomic data manipulation. Use this skill to perform efficient file format conversions, filter genomic features, and prepare datasets for downstream analysis. It is designed to handle large-scale biological data by providing tools for sequence indexing, k-mer counting, and converting flat files into structured formats like Parquet for big data applications.

## Command Syntax
All tools are accessed via the primary wrapper script:
`dsh-bio [command] [args]`

## Common Workflows and Patterns

### Sequence Manipulation
*   **Convert FASTA to FASTQ**: `dsh-bio fasta-to-fastq input.fasta > output.fastq`
*   **Downsample FASTQ**: `dsh-bio downsample-fastq --probability 0.1 input.fastq > sampled.fastq`
*   **Interleave/Disinterleave**: 
    *   `dsh-bio interleave-fastq R1.fastq R2.fastq > interleaved.fastq`
    *   `dsh-bio disinterleave-fastq interleaved.fastq R1.fastq R2.fastq`

### Format Conversion
*   **GFF3 to BED**: Extract transcript features into BED format for genome browsers or overlap analysis.
    `dsh-bio gff3-to-bed input.gff3 > output.bed`
*   **FASTQ to BAM**: Convert raw reads to unaligned BAM format.
    `dsh-bio fastq-to-bam input.fastq > output.bam`
*   **GFA Version Migration**: Convert GFA 1.0 to GFA 2.0.
    `dsh-bio gfa1-to-gfa2 input.gfa1 > output.gfa2`

### Big Data Integration (Parquet)
`dsh-bio` supports converting biological formats into Apache Parquet for use with tools like DuckDB or Spark.
*   **FASTA to Parquet**: `dsh-bio fasta-to-parquet input.fasta output.parquet`
*   **VCF to Partitioned Parquet**: `dsh-bio vcf-to-partitioned-parquet input.vcf output_dir/`

### Compression and Indexing
Use the `compress-*` commands to ensure files are in splittable formats (bgzf or bzip2), which is critical for parallel processing.
*   **Compress VCF**: `dsh-bio compress-vcf input.vcf > input.vcf.bgz`
*   **Create Sequence Dictionary**: `dsh-bio create-sequence-dictionary input.fasta > output.dict`

## Best Practices
*   **Splittable Compression**: Always use the `compress-[format]` commands when preparing data for distributed systems to ensure the resulting files can be read in parallel.
*   **Piping**: Most `dsh-bio` commands support standard input/output, allowing them to be chained with other bioinformatic tools (e.g., `samtools` or `bcftools`).
*   **Memory Management**: For large-scale Parquet conversions (e.g., `fasta-to-parquet3`), use the partition size and flush parameters to manage memory usage during the build process.

## Reference documentation
- [dsh-bio Overview](./references/anaconda_org_channels_bioconda_packages_dsh-bio_overview.md)
- [dsh-bio GitHub Repository](./references/github_com_heuermh_dishevelled-bio.md)