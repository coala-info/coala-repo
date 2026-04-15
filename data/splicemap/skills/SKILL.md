---
name: splicemap
description: SpliceMap is an alignment tool designed to discover splice junctions from RNA-seq data using a seeding and extension strategy. Use when user asks to align RNA-seq reads to a reference genome, identify unannotated splicing events, or detect splice junctions without relying on known gene models.
homepage: http://www.stanford.edu/group/wonglab/SpliceMap/
metadata:
  docker_image: "quay.io/biocontainers/splicemap:3.3.5.2--h9948957_7"
---

# splicemap

## Overview
SpliceMap is a specialized alignment tool designed to discover splice junctions directly from RNA-seq data. Unlike many aligners that rely on a "GT-AG" anchor or known gene models, SpliceMap uses a seeding and extension strategy to find junctions with high sensitivity. It is ideal for researchers working on non-model organisms or those seeking to identify unannotated splicing events. The tool handles both single-end and paired-end reads and integrates with Bowtie for initial mapping.

## Configuration and Execution
SpliceMap 3.x uses a configuration file (`.cfg`) rather than long command-line strings. This file defines the environment, input data, and alignment parameters.

### Core Workflow
1.  **Prepare Genome**: Organize your reference genome as individual FASTA files per chromosome in a single directory (e.g., `chr1.fa`, `chr2.fa`).
2.  **Create Configuration**: Define your parameters in a `run.cfg` file.
3.  **Run SpliceMap**: Execute the tool by passing the configuration file:
    ```bash
    SpliceMap run.cfg
    ```

### Essential Configuration Parameters
A typical `.cfg` file should include the following blocks:

*   **Input/Output**:
    *   `genome_dir`: Path to the directory containing chromosome FASTA files.
    *   `read_format`: `FASTQ` or `FASTA`.
    *   `reads_list1`: Path to the first set of reads.
    *   `reads_list2`: Path to the second set of reads (for paired-end).
    *   `temp_path`: Directory for intermediate files (requires significant space).
    *   `out_path`: Directory for final results.

*   **Alignment Settings**:
    *   `max_intron`: Maximum allowed intron length (default is often 400,000).
    *   `min_intron`: Minimum allowed intron length (default 20).
    *   `max_multi_hit`: Maximum number of multi-hits allowed during seeding.
    *   `full_read_length`: The length of your RNA-seq reads.
    *   `num_chromosome_together`: Number of chromosomes to process simultaneously (increase to speed up, but monitor RAM).

*   **Output Options**:
    *   `sam_file`: Set to `yes` to generate SAM format output.
    *   `coverage_out`: Set to `yes` to generate a coverage BED file.

## Best Practices and Expert Tips
*   **Memory Management**: SpliceMap can be memory-intensive (up to 50GB+ for 200M+ reads). If running on a machine with limited RAM, set `num_chromosome_together = 1`.
*   **Read Lengths**: While optimized for 50–100nt, SpliceMap 3.3.3+ supports uneven read lengths caused by adapter trimming. Ensure `full_read_length` reflects the maximum length in your dataset.
*   **Bowtie Integration**: SpliceMap bundles Bowtie. If you have a pre-built Bowtie index, ensure it matches the files in your `genome_dir`. If not found, SpliceMap will attempt to build it automatically.
*   **SAM Compatibility**: If using older versions of SpliceMap, the SAM output might contain a trailing tab that breaks `samtools`. If you encounter errors, strip the trailing tab from the SAM file using `sed 's/\t$//'`.
*   **Soft Clipping**: Use the `max_clip_allowed` parameter to control how many bases can be soft-clipped from the ends of reads, which helps in mapping reads with residual adapter sequences.

## Reference documentation
- [SpliceMap - Splice Junction Discovery and Alignment](./references/web_stanford_edu_group_wonglab_SpliceMap.md)
- [splicemap - bioconda package overview](./references/anaconda_org_channels_bioconda_packages_splicemap_overview.md)