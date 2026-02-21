---
name: wakhan
description: Wakhan is a specialized tool for somatic copy number profiling using long-read alignments and phased heterozygous variants.
homepage: https://github.com/KolmogorovLab/Wakhan
---

# wakhan

# Wakhan

## Overview
Wakhan is a specialized tool for somatic copy number profiling using long-read alignments and phased heterozygous variants. It distinguishes itself by using copy number differences between haplotypes to extend phased blocks and correct phase-switch errors. The tool provides a comprehensive analysis of the genomic landscape, including purity/ploidy estimation and interactive visualization, making it essential for cancer genomics workflows utilizing ONT or PacBio data.

## Installation and Setup
The most reliable way to install Wakhan is via Bioconda:
```bash
conda create -n wakhan_env wakhan
conda activate wakhan_env
```

## Core CLI Patterns

### 1. Standalone Mode (Tumor-Normal)
Use this when you have a tumor BAM and a phased germline VCF from a matched normal sample.
```bash
python wakhan.py all \
    --threads 24 \
    --reference ref.fa \
    --target-bam tumor.bam \
    --normal-phased-vcf normal_phased.vcf.gz \
    --genome-name "Sample_ID" \
    --out-dir-plots ./output_dir \
    --breakpoints severus_somatic_svs.vcf
```

### 2. Standalone Mode (Tumor-Only)
Use this when a matched normal is unavailable. Requires a phased VCF derived from the tumor sample.
```bash
python wakhan.py all \
    --threads 24 \
    --reference ref.fa \
    --target-bam tumor.bam \
    --tumor-phased-vcf tumor_phased.vcf.gz \
    --genome-name "Sample_ID" \
    --out-dir-plots ./output_dir \
    --breakpoints severus_somatic_svs.vcf
```

### 3. Advanced Phased SV Pipeline
For higher precision, Wakhan can be run in two stages (hapcorrect and cna) to integrate with phased structural variants (e.g., from Severus).

**Step A: Phase Correction**
```bash
python wakhan.py hapcorrect \
    --threads 16 \
    --reference ref.fa \
    --target-bam tumor.bam \
    --normal-phased-vcf input.vcf.gz \
    --genome-name "Sample_ID"
```

**Step B: Copy Number Analysis (after SV phasing)**
After running an SV caller like Severus on the rephased data, run the CNA module:
```bash
python wakhan.py cna \
    --threads 16 \
    --reference ref.fa \
    --target-bam tumor.bam \
    --normal-phased-vcf rephased.vcf.gz \
    --breakpoints severus_phased_svs.vcf \
    --use-sv-haplotypes
```

## Expert Tips and Best Practices

- **Breakpoint Integration**: Always provide a VCF to the `--breakpoints` parameter (ideally from Severus). This significantly improves the accuracy of segmentation boundaries compared to coverage-only analysis.
- **Chromosome Naming**: Ensure your `--contigs` match your reference. If your BAM/VCF uses "1" instead of "chr1", specify `--contigs 1-22,X,Y`.
- **Unphased Mode**: If working with organisms with low heterozygosity (e.g., specific mouse models), use the unphased input mode to avoid errors related to insufficient phased blocks.
- **Memory Management**: For large human genomes, ensure at least 16-24 threads are allocated to handle the pileup and optimization steps efficiently.
- **Output Interpretation**: The interactive plots generated in the output directory are the primary way to validate purity and ploidy estimates. Check the `phasing_output/rephased.vcf.gz` if you need to use the corrected phases for downstream haplotagging.

## Reference documentation
- [Wakhan GitHub Repository](./references/github_com_KolmogorovLab_Wakhan.md)
- [Bioconda Wakhan Package](./references/anaconda_org_channels_bioconda_packages_wakhan_overview.md)