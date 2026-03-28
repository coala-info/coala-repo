---
name: snipe
description: Snipe detects non-germline variants and de novo mutations across multiple related samples using joint-likelihood models. Use when user asks to call de novo mutations in trios, identify somatic variants in tumor-normal pairs, or perform quality control on genomic signatures.
homepage: https://github.com/snipe-bio/snipe
---


# snipe

## Overview
The `snipe` skill provides a specialized framework for detecting non-germline variants and de novo mutations by applying joint-likelihood models across multiple related samples. Unlike standard single-sample callers, it leverages the expected genetic relationships (or lack thereof in somatic contexts) to distinguish true low-frequency variants from sequencing artifacts. It is most effective when processing BAM files from trios or paired tumor-normal samples to identify high-confidence mutations that follow specific inheritance or evolutionary constraints.

## Usage Guidelines

### Core Command Pattern
The primary execution follows a multi-sample input approach:
```bash
snipe -r [reference.fa] -t [target_regions.bed] -o [output.vcf] [sample1.bam] [sample2.bam] [sample3.bam]
```

### Best Practices
- **Reference Alignment**: Ensure all input BAM files are aligned to the exact same reference genome version used in the `-r` flag.
- **Base Quality Calibration**: For optimal results in low-frequency detection, use BAM files that have undergone Base Quality Score Recalibration (BQSR).
- **Trio Analysis**: When calling de novo mutations, input the samples in the order: Child, Father, Mother. This allows the internal probability equations to correctly model the Mendelian inheritance patterns.
- **Filtering**: Use the `SNIPE_SCORE` provided in the output VCF to filter candidates. A higher score indicates a higher probability that the variant is a true mutation rather than a sequencing error or a germline variant.

### Common CLI Flags
- `-minMQ`: Set the minimum mapping quality (default is usually 20; increase to 30+ for high-precision clinical sets).
- `-minBQ`: Set the minimum base quality for a nucleotide to be considered in the likelihood calculation.
- `-s`: Specify the somatic/de novo prior probability if the default biological assumptions do not match your specific experimental design (e.g., high-mutability regions).



## Subcommands

| Command | Description |
|---------|-------------|
| qc | Perform quality control (QC) on multiple samples against a reference genome. |
| sketch | Sketch genomic data to generate signatures for QC. |
| snipe_ops | Perform operations on SnipeSig signatures. |

## Reference documentation
- [Anaconda Bioconda Snipe Overview](./references/anaconda_org_channels_bioconda_packages_snipe_overview.md)