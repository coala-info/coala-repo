---
name: pomoxis
description: Pomoxis is a suite of bioinformatics tools developed by Oxford Nanopore Technologies Research to streamline common analysis chains for nanopore sequencing data.
homepage: https://github.com/nanoporetech/pomoxis
---

# pomoxis

## Overview
Pomoxis is a suite of bioinformatics tools developed by Oxford Nanopore Technologies Research to streamline common analysis chains for nanopore sequencing data. It acts primarily as a high-level wrapper around established third-party tools like minimap2, miniasm, and racon, providing "known-good" default parameters optimized for ONT reads. Use this skill to execute rapid assembly-to-consensus workflows and to perform detailed statistical analysis of alignment and assembly errors.

## Common CLI Patterns

### Assembly and Alignment
*   **Rapid Assembly**: Use `mini_assemble` to generate a draft assembly from raw ONT reads. This tool automates the overlap-layout-consensus (OLC) process using `miniasm` and `racon`.
*   **Optimized Alignment**: Use `mini_align` to map reads to a reference. It wraps `minimap2` and handles index generation and sorting automatically.
    *   *Tip*: `mini_align` can accept BAM files as input in addition to FASTX formats.
    *   *Tip*: Use the option to copy FASTX comments to BAM tags to preserve metadata during alignment.

### BAM Processing and Statistics
*   **Extracting Stats**: Use `stats_from_bam` to generate summary statistics. Recent versions include read mean Q-scores and alignment flags in the output.
*   **Filtering Reads**: Use `filter_bam` to clean up alignments. 
    *   *Performance*: Assign multiple threads to improve BAM I/O speed.
    *   *Flexibility*: You can choose to keep unmapped reads if needed for downstream analysis.
*   **Subsampling**: Use `subsample_bam` for downsampling datasets. 
    *   *Note*: Use the `--primary_only` flag instead of the deprecated `--ignore_secondary` to focus on primary alignments.

### Assembly Evaluation
*   **Quality Assessment**: Use `assess_assembly` to compare a draft assembly against a known reference to determine identity and error rates.
*   **Error Analysis**: 
    *   Use `cat_errors` to categorize different types of assembly errors (mismatches, insertions, deletions).
    *   Use `intersect_assembly_errors` to find common errors across multiple assembly attempts.

## Expert Tips
*   **Environment Management**: Pomoxis is best managed via Bioconda. If installing via pip, ensure that `minimap2`, `miniasm`, `racon`, `samtools`, `bcftools`, and `seqkit` are manually added to your PATH.
*   **Memory and CPU**: Since many pomoxis tools wrap `minimap2` and `racon`, ensure your environment has sufficient RAM for large genome assemblies. Use multithreading flags where available (especially in `filter_bam` and `mini_align`) to reduce wall-clock time.
*   **Handling Large Files**: When working with very large BAM files, use `subsample_bam` to create smaller test sets before running computationally expensive error analysis tools like `intersect_assembly_errors`.

## Reference documentation
- [Pomoxis GitHub Repository](./references/github_com_nanoporetech_pomoxis.md)
- [Pomoxis Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pomoxis_overview.md)
- [Pomoxis Commit History (Feature Updates)](./references/github_com_nanoporetech_pomoxis_commits_master.md)