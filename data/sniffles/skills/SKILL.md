---
name: sniffles
description: Sniffles is a structural variant caller optimized for identifying large-scale genomic alterations from long-read sequencing data. Use when user asks to call structural variants, detect mosaic or somatic mutations, perform multi-sample population studies, or genotype known variants.
homepage: https://github.com/fritzsedlazeck/Sniffles
metadata:
  docker_image: "quay.io/biocontainers/sniffles:2.7.2--pyhdfd78af_0"
---

# sniffles

## Overview
Sniffles is a high-performance structural variant caller specifically optimized for the unique characteristics of long-read sequencing technologies. It identifies large-scale genomic alterations by analyzing split-read alignments and high-level evidence from BAM or CRAM files. This skill enables the execution of various genomic workflows, from single-sample germline detection to complex multi-sample population studies and low-frequency mosaic variant calling.

## Core CLI Usage Patterns

### Single-Sample Germline Calling
The most common use case for identifying SVs in an individual sample.
```bash
sniffles -i input.bam -v output.vcf
```
*   **Reference-informed calling**: To include the actual sequences for deletions in the VCF output, you must provide the reference genome.
    ```bash
    sniffles --input input.bam --vcf output.vcf --reference ref.fasta
    ```

### Mosaic and Somatic SV Detection
Use this mode for cancer samples or cases where variants are present at low allele frequencies.
```bash
sniffles --input tumor.bam --vcf mosaic_output.vcf --mosaic
```

### Population-Scale Workflow (Multi-Sample)
For cohorts, Sniffles uses a two-step process to maintain efficiency and accuracy across many samples.

1.  **Step 1: Generate Candidate Files (.snf)**
    Run this for every individual sample in the cohort.
    ```bash
    sniffles --input sample1.bam --snf sample1.snf
    ```

2.  **Step 2: Combined Calling**
    Merge the .snf files into a single multi-sample VCF.
    ```bash
    sniffles --input sample1.snf sample2.snf sample3.snf --vcf cohort.vcf
    ```
    *Tip: For large cohorts, provide a TSV file containing the paths to .snf files (one per line) to the `--input` argument.*

### Genotyping Known Variants (Force Calling)
To check for the presence of specific, previously identified SVs in a new sample.
```bash
sniffles --input sample.bam --genotype-vcf known_variants.vcf --vcf output_genotypes.vcf
```

## Expert Tips and Best Practices

*   **Tandem Repeat Annotations**: Accuracy in repetitive regions is significantly improved by providing a tandem repeat BED file.
    ```bash
    sniffles -i input.bam -v output.vcf --tandem-repeats human_hg38_repeats.bed
    ```
*   **Performance Tuning**: Sniffles is parallelized. Use `--threads` to speed up processing, but monitor memory usage as it scales with the thread count.
*   **Read Name Tracking**: If you need to perform downstream visualization or validation (e.g., with IGV), use the `--output-rnames` flag to include the names of reads supporting each SV in the VCF.
*   **Compressed Output**: Sniffles supports direct output to bgzipped VCF files if the output filename ends in `.vcf.gz`.
*   **Low Coverage**: For datasets with low coverage, default parameters may be too stringent. Consider adjusting the minimum support thresholds if expected variants are missing.

## Reference documentation
- [Sniffles Main Documentation](./references/github_com_fritzsedlazeck_Sniffles.md)
- [Sniffles Wiki and Quickstart](./references/github_com_fritzsedlazeck_Sniffles_wiki.md)