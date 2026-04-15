---
name: ska2
description: ska2 aligns closely related genomic sequences by matching split k-mers to identify variants and generate alignments without a reference. Use when user asks to build split k-mer files, create FASTA alignments, map sequences to a reference for VCF output, or perform local assembly for diverged samples.
homepage: https://github.com/bacpop/ska.rust
metadata:
  docker_image: "quay.io/biocontainers/ska2:0.5.1--h4349ce8_0"
---

# ska2

## Overview
`ska2` (Split K-mer Analysis version 2) is a high-performance Rust implementation designed to align closely related genomic sequences by matching split k-mers—pairs of k-mers separated by a single central base. This approach excels in outbreak analytics because it is reference-free, allowing for the inclusion of accessory genome variation. It is optimized for speed and low memory usage compared to traditional aligners, though its accuracy decreases when sequence divergence exceeds 1%.

## Core Workflows

### 1. Building Split K-mer Files (.skf)
The `build` command is the primary entry point, replacing several commands from version 1. It processes FASTA or FASTQ files into a standardized `.skf` format.

*   **From a list of files**: Create a tab-separated file with sample names and file paths.
    ```bash
    ska build -f file_list.txt -o samples.skf
    ```
*   **Adjusting K-mer size**: The default `k` is 31 (representing a split k-mer of 63 bases).
    ```bash
    ska build --kmer 31 -f file_list.txt -o samples.skf
    ```

### 2. Generating Alignments and Variants
Once an `.skf` file is created, you can generate alignments or call variants.

*   **Create a FASTA alignment**:
    ```bash
    ska align samples.skf -o alignment.aln
    ```
*   **Map to a reference for VCF output**:
    ```bash
    ska map reference.fasta samples.skf -o variants.vcf
    ```

### 3. Handling Diverged Samples with `ska lo`
For samples with higher divergence (approaching or slightly exceeding 1%), use the "left-out" (lo) command which utilizes local assembly to recover variants.
```bash
ska lo -f file_list.txt -o local_assembly.skf
```

### 4. Quality Control and Inspection
*   **Filter FASTQ reads**: Use `ska cov` to filter reads based on a coverage model to reduce noise before building.
*   **Inspect .skf metadata**: The `nk` command (new k-mers) replaces the old `info` and `summary` commands.
    ```bash
    ska nk --full-info samples.skf
    ```

## Expert Tips and Best Practices
*   **Divergence Limit**: Do not use `ska2` for sequences with >1% divergence; the split k-mer matching will fail to find enough anchors, leading to poor recall.
*   **SNP Spacing**: `ska2` can only align SNPs that are further apart than the k-mer length. If SNPs are clustered, they may be missed.
*   **Memory Optimization**: `ska2` is fully parallelized. On high-core machines, ensure you provide sufficient threads to speed up the build phase.
*   **Strand Awareness**: For RNA viruses or known-strand sequences, use the strand-specific options during the build to maintain orientation.
*   **Reference Bias**: When using `ska map`, be aware that it inherently introduces reference bias. For true discovery of accessory elements, prefer `ska align`.

## Reference documentation
- [ska2 Overview](./references/anaconda_org_channels_bioconda_packages_ska2_overview.md)
- [ska.rust GitHub Repository](./references/github_com_bacpop_ska.rust.md)