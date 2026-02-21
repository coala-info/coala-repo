---
name: severus
description: Severus is a specialized bioinformatics tool designed to identify somatic structural variations from long-read sequencing alignments.
homepage: https://github.com/KolmogorovLab/Severus
---

# severus

## Overview
Severus is a specialized bioinformatics tool designed to identify somatic structural variations from long-read sequencing alignments. It excels at modeling complex rearrangements by utilizing a breakpoint graph framework and leveraging haplotype-specific information (phasing). It supports single-sample (tumor-only), paired-sample (tumor/normal), and multi-sample tumor analysis. By incorporating phased VCFs and Variable Number Tandem Repeat (VNTR) annotations, Severus provides high-precision SV calls in challenging genomic regions.

## Installation and Setup
The recommended way to install Severus is via Bioconda:
```bash
conda create -n severus_env bioconda::severus
conda activate severus_env
```

## Common CLI Patterns

### Tumor/Normal Paired Analysis (Recommended)
This is the standard workflow for identifying somatic mutations by filtering out germline variants found in a matched control.
```bash
severus --target-bam tumor_phased.bam \
        --control-bam normal_phased.bam \
        --phasing-vcf phased_variants.vcf \
        --vntr-bed human_GRCh38_vntrs.bed \
        --out-dir ./severus_results \
        --threads 16
```

### Tumor-Only Analysis
When a matched normal sample is unavailable, use a Panel of Normals (PoN) to filter common germline variants and artifacts.
```bash
severus --target-bam tumor_phased.bam \
        --PON PoN_1000G_hg38.tsv.gz \
        --phasing-vcf phased_variants.vcf \
        --vntr-bed human_GRCh38_vntrs.bed \
        --out-dir ./tumor_only_results
```

### Multi-Sample Tumor Analysis
Severus can process multiple tumor samples against a single control to track clonal evolution or metastatic progression.
```bash
severus --target-bam tumor_p1.bam tumor_p2.bam \
        --control-bam normal.bam \
        --out-dir ./multi_sample_results
```

## Expert Tips and Best Practices

### Input Preparation
*   **Haplotagging**: While not strictly required, using haplotagged (phased) BAM files significantly improves accuracy. If your BAMs are haplotagged, you must provide the corresponding `--phasing-vcf`.
*   **Indexing**: Ensure all input BAM files are indexed (`.bai` or `.csi`).
*   **VNTR Annotations**: Always provide a `--vntr-bed` file for human samples (available in the Severus repository for GRCh38 and CHM13) to avoid false positives in repetitive regions.

### Parameter Tuning
*   **Low Quality Samples**: If working with lower coverage or higher error rates, use the `--low-quality` flag to apply stricter filtering.
*   **Support Thresholds**: Adjust `--min-support` (default: 3) based on your sequencing depth. For high-depth HiFi data, increasing this can reduce noise.
*   **Phasing Tags**: If using HiPhase or LongPhase for haplotagging, add the `--use-supplementary-tag` flag to ensure HP tags in supplementary alignments are correctly processed.
*   **VAF Filtering**: Use `--vaf-thr` to set a custom Variant Allele Frequency threshold if you expect low-purity samples.

### Output Interpretation
*   `severus_somatic.vcf`: Contains the high-confidence somatic structural variants.
*   `severus_all.vcf`: Includes both somatic and germline calls.
*   **Breakpoint Graphs**: Check the output directory for complexSV clusters which provide insights into linked rearrangements that form complex events like chromothripsis.

## Reference documentation
- [Severus GitHub Repository](./references/github_com_KolmogorovLab_Severus.md)
- [Bioconda Severus Overview](./references/anaconda_org_channels_bioconda_packages_severus_overview.md)