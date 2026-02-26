---
name: rustynuc
description: "rustynuc identifies 8-oxoG oxidative damage artifacts in sequencing data by analyzing strand orientation bias. Use when user asks to scan BAM files for potential damage sites, annotate existing VCF variants with damage likelihood, or identify G>T sequencing artifacts."
homepage: https://github.com/bjohnnyd/rustynuc
---


# rustynuc

## Overview

`rustynuc` is a specialized bioinformatics tool designed to identify 8-oxoG damage, a common oxidative modification that can lead to G>T (or C>A) sequencing artifacts. By analyzing the strand orientation (FF vs FR) of reads at specific genomic positions, the tool calculates the likelihood that a perceived variant is actually a result of damage rather than a true biological mutation. It is highly efficient, written in Rust, and supports both de novo pileup analysis (outputting BED files) and targeted variant annotation (outputting VCF files).

## Installation and Setup

The tool is primarily available via Bioconda:

```bash
conda install -c bioconda rustynuc
```

## Common CLI Patterns

### 1. De Novo Damage Discovery (BED Output)
To scan an entire BAM file for potential damage sites without a pre-existing VCF:

```bash
rustynuc -r reference.fasta input.bam > damage_sites.bed
```

### 2. Annotating Existing Variants (VCF Output)
To check if specific calls in a VCF are likely 8-oxoG artifacts:

```bash
rustynuc -r reference.fasta -b input.vcf input.bam > annotated_variants.vcf
```

### 3. High-Sensitivity Filtering
For low-depth data or when seeking to minimize false negatives, use pseudocounts to stabilize Fisher's Exact Test:

```bash
rustynuc --pseudocount -r reference.fasta input.bam > output.bed
```

## Expert Tips and Best Practices

### Handling VCF Input
*   **Pre-process Variants**: `rustynuc` does not process Multi-Nucleotide Polymorphisms (MNPs). Always normalize your VCF and decompose complex variants into allelic primitives (e.g., using `bcftools norm` or `vt decompose`) before running the tool.
*   **Filtering Results**: When using VCF output, the tool adds a `PASS` filter only if the Fisher's p-value is significant (< 0.05). Use `bcftools` to extract these sites:
    ```bash
    bcftools filter -i 'FILTER=="PASS"' annotated_variants.vcf
    ```

### Optimizing Statistical Power
*   **Depth Requirements**: Statistical significance in orientation bias is heavily dependent on depth. If depth is low, rely more on the `FF_FR_AF` (Alternate Frequency in FF/FR orientations) values rather than the p-value alone.
*   **Minimum Reads**: Use `-m` (default: 4) to set the threshold for the minimum number of reads in a specific orientation required to even consider a position.

### Sequence Context
*   **3-mer Context**: Always provide a reference file (`-r`). This allows `rustynuc` to report the sequence context (e.g., the bases surrounding the G>T change), which is critical for confirming 8-oxoG signatures, as they often occur in specific motifs.

### Performance Tuning
*   **Multithreading**: Use the `-t` flag to specify threads (default: 4).
*   **Region Restriction**: If you are only interested in specific genomic regions (e.g., exome targets), provide a BED file with `--bed` to significantly speed up processing.

## Reference documentation
- [rustynuc - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_rustynuc_overview.md)
- [bjohnnyd/rustynuc: Quick analysis of pileups for likely 8-oxoG locations](./references/github_com_bjohnnyd_rustynuc.md)