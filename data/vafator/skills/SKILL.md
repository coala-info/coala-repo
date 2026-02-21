---
name: vafator
description: VAFator is a specialized tool designed to enrich VCF files with site-specific evidence from raw sequencing data.
homepage: https://github.com/tron-bioinformatics/vafator
---

# vafator

## Overview

VAFator is a specialized tool designed to enrich VCF files with site-specific evidence from raw sequencing data. By calculating metrics like Allele Frequency (AF), Depth (DP), and various rank-sum tests directly from BAM files, it allows researchers to scrutinize variant calls independently of the original caller's logic. It is particularly effective for somatic variant analysis, where calculating the "power" to detect a mutation and the probability of a mutation being undetected are critical for interpreting results.

## Installation

VAFator can be installed via bioconda or pip:

```bash
# Via Conda
conda install bioconda::vafator

# Via Pip (requires system libraries: libcurl, libz, liblzma, htslib)
pip install vafator
```

## Common CLI Patterns

### Basic Annotation
To annotate a VCF with a single BAM file:

```bash
vafator --input-vcf input.vcf \
        --output-vcf output.vcf \
        --bam sample_name /path/to/alignment.bam
```

### Multi-Sample (Tumor/Normal) Analysis
You can provide multiple BAM files with unique labels. VAFator will create prefixed INFO fields (e.g., `normal_af`, `tumor_af`) for each:

```bash
vafator --input-vcf somatic.vcf \
        --output-vcf annotated.vcf \
        --bam normal /data/normal.bam \
        --bam tumor /data/tumor.bam
```

### Handling Technical Replicates
If you provide the same label for multiple BAM files, VAFator calculates metrics across the aggregate pool and for each individual file:

```bash
vafator --input-vcf input.vcf \
        --output-vcf output.vcf \
        --bam primary /data/rep1.bam \
        --bam primary /data/rep2.bam
```
*Note: This generates `primary_af` (combined) as well as `primary_af_1` and `primary_af_2`.*

## Expert Tips and Best Practices

### Read Filtering
Control the quality of evidence by setting thresholds for mapping and base quality. Reads falling below these values are ignored in the calculations:

```bash
vafator --input-vcf in.vcf --output-vcf out.vcf \
        --bam tumor t.bam \
        --mapping-quality 30 \
        --base-call-quality 20
```

### Indel Handling
*   **Exact Matches Only:** VAFator only counts reads where the CIGAR string exactly matches the indel coordinates and sequence in the VCF.
*   **Multiallelic Indels:** These are not supported and will result in null values.
*   **Normalization:** Always normalize and decompose your VCF (e.g., using `bcftools norm -m -any`) before running VAFator to ensure complex variants and MNVs are handled correctly.

### Key INFO Field Annotations
*   **{sample}_pu:** Probability that a somatic mutation is undetected given the coverage and expected AF.
*   **{sample}_pw:** Power to detect a somatic mutation (based on Carter et al., 2012).
*   **{sample}_rsmq / {sample}_rsbq:** Rank-sum tests for mapping and base quality. Values near zero indicate the reference and alternate alleles have similar quality distributions.

## Reference documentation
- [VAFator GitHub Repository](./references/github_com_TRON-Bioinformatics_vafator.md)