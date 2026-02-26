---
name: smaca
description: "SMAca calculates the absolute copy number of the SMN1 gene from BAM files to identify SMA carriers and silent carriers. Use when user asks to identify SMA carriers, calculate SMN1 copy number, or detect silent carriers using sequence-specific variants."
homepage: https://github.com/babelomics/SMAca
---


# smaca

## Overview
SMAca is a specialized genomic tool designed to identify individuals at risk of being SMA carriers by calculating the absolute copy number of the SMN1 gene. It distinguishes between the nearly identical SMN1 and SMN2 genes using sequence-specific variants. Beyond simple deletion detection, SMAca can identify "silent carriers" (individuals with a 2+0 genotype) by analyzing specific sequence variants (g.27134T>G and g.27706_27707delAT) and scaling factors proportional to total gene copies.

## Installation
The recommended installation method is via Bioconda:
```bash
conda install -c bioconda smaca
```

## Common CLI Patterns

### Basic Analysis
Run analysis on one or more BAM files using a specific reference genome (hg19 or hg38):
```bash
smaca --reference hg38 sample1.bam sample2.bam
```

### High-Throughput Batch Processing
For large cohorts, use multithreading and output results to a CSV file. Analyzing samples in large batches is recommended for more reliable interpretation:
```bash
smaca --output results.csv --reference hg38 --ncpus 12 path/to/bams/*.bam
```

### Using a Sample List
If you have a text file containing paths to BAM files:
```bash
smaca --output cohort_results.csv --reference hg38 --ncpus 8 $(cat sample_list.txt)
```

## Expert Tips and Best Practices

### Cohort Selection
* **Batch Size**: Always prefer analyzing a large cohort at once rather than single samples. The statistical distribution of coverage across a population makes it significantly easier to interpret copy-number states.
* **Capture Consistency**: Ensure all samples in a batch were processed using the same capture kit (for WES/Panels) to avoid coverage bias at the SMN locus.

### Interpretation of Results
* **Carrier Status (1 copy)**: Look for `Pi_p` (scaled proportion of SMN1 reads) values under 1/3.
* **Silent Carriers (2+0 genotype)**: These individuals have two copies of SMN1 on one chromosome and zero on the other. Identify them by checking:
    1. `Pi_p` values close to 1/2.
    2. `scale_factor` close to 0.75 (for 2:1 SMN1:SMN2 ratio) or 0.5 (for 2:0 ratio).
    3. Consensus sequence at positions g.27134 and g.27706_27707.
* **Complex Reorganizations**: If there are large discrepancies between `Pi_a`, `Pi_b`, and `Pi_c`, the sample likely contains complex SMN locus rearrangements and requires manual inspection of raw coverage (`cov_x_p`).

### Genotype Estimation Table
Use the `scale_factor` and the ratio of SMN1/SMN2 coverage to estimate absolute copy numbers:

| Genotype (SMN1:SMN2) | scale_factor | cov_SMN1_p / cov_SMN2_p |
| :--- | :--- | :--- |
| 1:3 | 1.0 | 1/3 |
| 1:2 | 0.75 | 1/2 |
| 1:1 | 0.5 | 1 |

## Reference documentation
- [SMAca GitHub Repository](./references/github_com_babelomics_SMAca.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_smaca_overview.md)