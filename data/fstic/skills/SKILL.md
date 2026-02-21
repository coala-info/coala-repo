---
name: fstic
description: fstic is a high-performance Rust-based utility designed to compute genetic distance matrices from variant data.
homepage: https://github.com/PathoGenOmics-Lab/fstic
---

# fstic

## Overview

fstic is a high-performance Rust-based utility designed to compute genetic distance matrices from variant data. It processes single-sample VCFs or allele-frequency tables to generate an N × N matrix summarizing genetic differentiation. The tool is optimized for multi-core systems and provides a variety of estimators suitable for population differentiation, phylogenetic analysis, and profile comparison.

## Core CLI Patterns

### Input Methods
fstic supports two primary input types. Note that VCF mode is generally preferred for ease of use as it contains reference alleles.

*   **VCF Mode**: Provide one or more single-sample VCF files.
    ```bash
    fstic --vcf sample1.vcf sample2.vcf --output matrix.csv
    ```
*   **Table Mode**: Requires a reference FASTA to infer missing alleles.
    ```bash
    fstic --table data.tsv --reference ref.fa --output matrix.csv
    ```
*   **Batch Processing**: Use file lists to avoid shell argument limits with hundreds of samples.
    ```bash
    fstic --vcf-list vcf_paths.txt --output matrix.csv
    ```

### Selecting the Right Metric
Use the `--formula` flag to match your analytical goals:

| Goal | Recommended Metric | Flag |
| :--- | :--- | :--- |
| **Standard Differentiation** | Weir & Cockerham FST (Default) | `fst` |
| **Overall Differentiation** | Nei's GST | `gst` |
| **Allelic Diversity** | Jost’s D | `jost_d` |
| **Short-term Divergence** | Reynolds Distance | `reynolds` |
| **Long-term Phylogeny** | Nei’s D | `nei` |
| **Geometric/Tree Inference** | Cavalli-Sforza Chord | `chord` |

## Expert Tips and Best Practices

### Quality Filtering
Always apply filters to remove low-confidence variants, especially when working with raw VCFs.
*   **Depth**: Use `--min-depth` (default 30) to ensure sufficient coverage.
*   **Allele Frequency**: Use `--min-af` (default 0.05) to exclude rare variants or sequencing noise.
*   **Support**: Use `--min-alt-reads` (default 2) to ensure the alternative allele is seen multiple times.

### Normalization
By default, fstic outputs cumulative distances. For metrics like `fst`, `bray-curtis`, `chord`, and `jost_d`, add the `--normalize` flag to obtain per-locus means. This is critical when comparing datasets with different numbers of SNPs.

### Performance Optimization
fstic automatically uses all logical CPU cores. In shared computing environments (like HPC clusters), explicitly set the thread count to match your resource allocation:
```bash
fstic --vcf *.vcf --output out.csv --workers 8
```

### Input Table Requirements
If using `--table`, ensure your file (CSV/TSV/TAB) contains these case-insensitive columns:
1.  `sample`
2.  `position`
3.  `sequence` (the alt allele)
4.  `frequency` (decimal 0.125 or percentage 12.5%)
5.  `ref_allele` (highly recommended for indels)

## Reference documentation
- [fstic GitHub Repository](./references/github_com_PathoGenOmics-Lab_fstic.md)
- [fstic Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fstic_overview.md)