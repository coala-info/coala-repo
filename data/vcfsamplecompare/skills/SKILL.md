---
name: vcfsamplecompare
description: The vcfsamplecompare tool performs a differential analysis of genetic variants to rank them by how well they discriminate between samples or groups. Use when user asks to perform differential analysis of genetic variants, rank variants by their ability to discriminate between samples or groups, or calculate scores based on genotype calls, allelic frequencies, or read depth.
homepage: https://github.com/hepcat72/vcfSampleCompare
metadata:
  docker_image: "quay.io/biocontainers/vcfsamplecompare:2.013--pl526_0"
---

# vcfsamplecompare

## Overview

The `vcfsamplecompare` tool performs a differential analysis of genetic variants, similar in concept to differential gene expression analysis but applied to VCF records. It processes VCF files containing two or more samples and ranks variants based on how well they discriminate between samples or user-defined groups. The tool calculates scores for genotype calls (GT), observation ratios (OR/allelic frequency), and read depth (DP) to prioritize variants where the evidence for a difference is strongest.

## Usage and Best Practices

### Core Command Structure
The tool typically operates as a Perl script reading from standard input or a file:
```bash
vcfSampleCompare.pl [options] < input.vcf > output.vcf
```

### Key Scoring Metrics
The tool ranks variants using a weighted sum of three primary scores (default weights 100:10:1):
1.  **BEST_GT_SCORE**: Measures how well genotype calls separate the groups (binary 1/0 by default).
2.  **BEST_OR_SCORE**: Measures the gap in allelic frequencies (AO/DP) between groups.
3.  **BEST_DP_SCORE**: Measures whether read depth meets the "adequate" threshold.

### Common CLI Patterns

*   **Extended Help**: Access detailed documentation and advanced parameters.
    ```bash
    vcfSampleCompare.pl --help --extended
    ```
*   **Allelic Frequency Mode**: Use this when genotype calls are unreliable or when looking for subtle frequency shifts in pooled samples.
    ```bash
    vcfSampleCompare.pl --nogenotype < input.vcf
    ```
*   **Adjusting Depth Thresholds**: Define what constitutes "adequate" depth for a variant to be considered reliable.
    ```bash
    vcfSampleCompare.pl --adequate-depth 10 < input.vcf
    ```
*   **Gap Measurement**: Control how the difference in observation ratios is calculated using the `--gap-measure` option (e.g., comparing averages vs. range edges).

### Expert Tips

*   **VCF Compatibility**: Ensure your VCF contains `GT`, `AO`, `RO`, and `DP` tags in the FORMAT column. While optimized for `freeBayes` and `svTyper`, any VCF with these standard tags is compatible.
*   **Greedy Grouping**: If you do not specify sample groups, the tool will greedily discover the pair of samples that shows the greatest difference for each variant. For more controlled experiments, explicitly define your groups.
*   **Handling Ties**: When multiple variant states (REF vs ALT) show differences, the tool defaults to the alternate state (ALT) to represent the row.
*   **Sorting Logic**: Variants with no data across all samples are automatically sorted to the bottom of the output, even if they share a score of 0 with other variants.
*   **Partial Discrimination**: Use `--minimum-gt-score` in the advanced settings to allow variants that only partially discriminate between groups rather than requiring a perfect binary split.

## Reference documentation
- [vcfsamplecompare Overview](./references/anaconda_org_channels_bioconda_packages_vcfsamplecompare_overview.md)
- [vcfSampleCompare GitHub Repository](./references/github_com_hepcat72_vcfSampleCompare.md)