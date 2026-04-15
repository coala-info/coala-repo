---
name: wakhan
description: Wakhan performs haplotype-specific copy number analysis on long-read genomic data from cancer samples. Use when user asks to resolve haplotype-specific copy number changes, identify large-scale chromosomal alterations, or perform phase-switch correction in tumor samples.
homepage: https://github.com/KolmogorovLab/Wakhan
metadata:
  docker_image: "quay.io/biocontainers/wakhan:0.4.2--pyhdfd78af_0"
---

# wakhan

## Overview
Wakhan is a specialized bioinformatics tool designed for long-read genomic analysis of cancer samples. It leverages the unique advantages of long reads to resolve haplotype-specific copy number changes. By using phased heterozygous variants, Wakhan can extend phased blocks and correct errors by analyzing the copy number differences between maternal and paternal haplotypes. It is particularly effective for identifying large-scale chromosomal alterations and aneuploidy that might be missed by short-read technologies.

## Usage Guidelines

### Core Workflows
Wakhan typically operates in two primary modes: `all` (standalone) or modular steps (`hapcorrect` and `cna`).

#### 1. Standalone Execution (Tumor-Normal)
Use this for a standard analysis when a matched normal sample's phased VCF is available.
```bash
python wakhan.py all \
    --threads 24 \
    --reference ref.fa \
    --target-bam tumor.bam \
    --normal-phased-vcf normal_phased.vcf.gz \
    --genome-name "Sample_ID" \
    --out-dir-plots ./output \
    --breakpoints somatic_svs.vcf
```

#### 2. Tumor-Only Mode
Use this when a matched normal is unavailable. You must provide a phased VCF derived from the tumor itself.
```bash
python wakhan.py all \
    --target-bam tumor.bam \
    --tumor-phased-vcf tumor_phased.vcf.gz \
    --out-dir-plots ./output
```

#### 3. Advanced Phased SV Pipeline
For maximum precision in segmenting copy number boundaries, use the two-step process with Severus-derived phased breakpoints.
1. **Phase Correction**: `python wakhan.py hapcorrect ...` to generate `rephased.vcf.gz`.
2. **Haplotagging**: Use `whatshap` to tag the BAM with the rephased VCF.
3. **CNA Analysis**:
```bash
python wakhan.py cna \
    --target-bam tumor.haplotagged.bam \
    --normal-phased-vcf rephased.vcf.gz \
    --breakpoints severus_somatic.vcf \
    --use-sv-haplotypes
```

### Parameter Best Practices
- **Breakpoints**: Always provide somatic SV calls via `--breakpoints` if available. This significantly improves segmentation accuracy.
- **Contig Handling**: By default, Wakhan looks for `chr1-22,chrX`. If your reference uses numerical names (1, 2, X), you must specify `--contigs 1-22,X`.
- **Annotations**: Ensure the centromere BED file matches your reference version. Use the `_nochr.bed` variants in `src/annotations` if your BAM/VCF files lack the "chr" prefix.
- **Low Heterozygosity**: For mouse models or samples with low heterozygosity, run in unphased mode.

### Expert Tips
- **Interactive Plots**: The default output includes interactive HTML plots. Use `--pdf-enable` if you require static versions for publications.
- **Memory Management**: Long-read pileups can be memory-intensive. Adjust `--threads` based on available RAM; 16-24 threads is usually the sweet spot for standard human genomes.
- **Phase-Switch Correction**: If your input VCF has many small phase blocks, Wakhan's `hapcorrect` module is essential to merge them based on copy number evidence before proceeding to CNA estimation.



## Subcommands

| Command | Description |
|---------|-------------|
| wakhan | Wakhan plots coverage and copy number profiles from a bam and phased VCF files |
| wakhan | Wakhan plots coverage and copy number profiles from a bam and phased VCF files |
| wakhan | Wakhan plots coverage and copy number profiles from a bam and phased VCF files |

## Reference documentation
- [Wakhan README](./references/github_com_KolmogorovLab_Wakhan_blob_main_README.md)
- [Environment and Dependencies](./references/github_com_KolmogorovLab_Wakhan_blob_main_environment.yml.md)