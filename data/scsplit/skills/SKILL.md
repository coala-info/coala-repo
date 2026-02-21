---
name: scsplit
description: scSplit is a computational tool designed to demultiplex pooled single-cell RNA-seq data without requiring prior knowledge of the individual genotypes.
homepage: https://github.com/jon-xu/scSplit
---

# scsplit

## Overview
scSplit is a computational tool designed to demultiplex pooled single-cell RNA-seq data without requiring prior knowledge of the individual genotypes. It utilizes a hidden state model to identify genetically distinct samples within a mixed population based on allelic ratios at heterozygous SNV sites. This is particularly useful for experiments where reference genotypes for each donor are unavailable or difficult to obtain.

## Workflow and CLI Patterns

### 1. Data Pre-processing
Before using scSplit, the input BAM file must be strictly filtered to ensure high-quality reads.

*   **Filter and Sort**: Remove low-quality reads, unmapped segments, and duplicates.
    ```bash
    samtools view -S -b -q 10 -F 3844 processed.bam > filtered.bam
    samtools sort filtered.bam -o filtered_sorted.bam
    samtools index filtered_sorted.bam
    ```
*   **Deduplication**: If using UMIs, it is highly recommended to use `umi_tools rmdup` before sorting.

### 2. SNV Calling
Call SNVs from the filtered BAM. FreeBayes is the recommended tool, configured to ignore indels and complex events.

*   **FreeBayes Pattern**:
    ```bash
    freebayes -f <reference.fa> -iXu -C 2 -q 1 filtered_sorted.bam > snv.vcf
    ```
*   **Post-filtering**: Keep only high-confidence variants (QUAL > 30).
    ```bash
    bcftools filter -i '%QUAL>30' snv.vcf -o filtered.vcf
    ```

### 3. Building Allele Count Matrices
Use the `count` command to generate reference and alternative allele matrices.

*   **Command**:
    ```bash
    scSplit count -v filtered.vcf -i filtered_sorted.bam -b barcodes.tsv -r ref_filtered.csv -a alt_filtered.csv -o ./output_dir
    ```
*   **Expert Tip (Common SNPs)**: Use the `-c` parameter with a list of known common SNPs (e.g., from 1000 Genomes) to significantly improve prediction accuracy. Ensure the chromosome naming (e.g., "chr1" vs "1") matches your BAM file.
*   **Resource Management**: This step is memory-intensive. For 10,000 cells and 60,000 SNVs, ensure at least 30GB of RAM is available.

### 4. Demultiplexing
Run the hidden state model to assign cells to samples.

*   **Known Sample Number**:
    ```bash
    scSplit run -r ref_filtered.csv -a alt_filtered.csv -n <expected_sample_count> -o ./results
    ```
*   **Auto-detection**: If the number of samples is unknown, use `-n 0`.
    ```bash
    scSplit run -r ref_filtered.csv -a alt_filtered.csv -n 0 -s 10 -o ./results
    ```
*   **Doublet Handling**: Use the `-d` parameter to specify an expected doublet rate (e.g., `-d 0.1` for 10%) if you have not pre-filtered doublets using other tools.

## Best Practices
*   **Barcode Tags**: By default, scSplit looks for the `CB` tag. If your BAM uses a different tag (e.g., `CR`), specify it using `-t`.
*   **Whitelist**: Always use a "trusted" barcode whitelist (actual detected cells) rather than the full library whitelist to reduce noise and memory usage.
*   **Parallelization**: SNV calling is the bottleneck. Split the BAM by chromosome and run FreeBayes in parallel, then merge VCFs before the `count` step.

## Reference documentation
- [scSplit GitHub Repository](./references/github_com_jon-xu_scSplit.md)
- [scSplit Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scsplit_overview.md)