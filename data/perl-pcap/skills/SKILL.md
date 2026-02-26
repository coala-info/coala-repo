---
name: perl-pcap
description: perl-pcap provides standardized genomic alignment and BAM processing tools for the ICGC/TCGA Pan-Cancer Analysis Project. Use when user asks to align paired-end reads using BWA-MEM, compare BAM files for consistency, or download genomic data from GNOS repositories.
homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
---


# perl-pcap

## Overview
The `perl-pcap` package (also known as PCAP-core) provides the reference implementations for the ICGC/TCGA Pan-Cancer Analysis Project. It is designed to facilitate standardized genomic alignments of paired-end data and subsequent variant calling workflows. The toolset includes Perl wrappers for high-performance bioinformatic tools like BWA and Samtools, as well as optimized C utilities for BAM file processing. It is particularly useful for researchers needing to replicate the PCAWG (Pan-Cancer Analysis of Whole Genomes) alignment environment.

## Core CLI Tools and Usage

### Genomic Alignment with bwa_mem.pl
The primary tool for sequence alignment is `bwa_mem.pl`. It wraps BWA-MEM to handle paired-end data and integrates duplicate marking.
- **Threading**: Use the threading options to manage CPU allocation. Recent versions include improved threading control to optimize throughput.
- **Memory Management**: Supports alternative `malloc` implementations to optimize BWA performance during large-scale runs.
- **Input Formats**: Typically accepts FASTQ, BAM, or CRAM inputs. When using BAM/CRAM inputs, the tool reduces temporary data overhead by streaming.

### BAM Comparison with diff_bams
For validating or comparing two BAM files (e.g., checking consistency between different pipeline versions or environments):
- Use the C implementation of `diff_bams` for high-performance comparison.
- This tool is essential for regression testing and ensuring alignment reproducibility across different compute nodes.

### Data Retrieval with gnos_pull.pl
Used for downloading genomic data from GNOS (Genomic Data Commons) repositories.
- **RNA Support**: Includes specific support for RNA-seq data downloads.
- **Robustness**: Features hardened external process handling to manage the instability often associated with large-scale network transfers.

## Best Practices and Expert Tips

- **Environment Variables**: 
  - Use environment variables to control "auto back-off" logic for file operations, which is useful in high-latency distributed filesystem environments.
  - Force synchronization of file writes via environment variables if you encounter truncated files on specific storage backends.
- **Dependency Chain**: Ensure that `biobambam`, `bwa`, `samtools`, and `cgpBigWig` are correctly installed and available in your `$PATH`. `perl-pcap` acts as a high-level coordinator for these underlying binaries.
- **BAM Header Management**: When processing legacy data, `perl-pcap` can automatically handle cases where input BAMs lack the `@RG` (Read Group) or `SM` (Sample) tags, but it is best practice to verify these tags before starting long-running alignment jobs.
- **Performance Optimization**: For BAM processing, `perl-pcap` utilizes separate processes for compression and streaming BAS (BAM Index Statistics) generation to prevent I/O bottlenecks. Note that this specific optimization is generally not applicable to CRAM output.

## Reference documentation
- [Anaconda Bioconda perl-pcap Overview](./references/anaconda_org_channels_bioconda_packages_perl-pcap_overview.md)
- [GitHub PCAP-core README](./references/github_com_ICGC-TCGA-PanCancer_PCAP-core.md)
- [PCAP-core Wiki Home](./references/github_com_ICGC-TCGA-PanCancer_PCAP-core_wiki.md)