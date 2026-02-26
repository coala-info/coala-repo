---
name: bactopia-variants
description: Bactopia-variants performs high-quality variant calling to identify SNPs and InDels in bacterial sequencing data against a reference genome. Use when user asks to call variants, identify genetic variations, or perform SNP-based strain characterization.
homepage: https://bactopia.github.io/
---


# bactopia-variants

## Overview
The `bactopia-variants` skill provides procedural knowledge for executing high-quality variant calling (SNPs and InDels) on bacterial sequencing data. It is primarily used to identify genetic variations between a set of samples and a reference genome, facilitating downstream tasks like outbreak investigation, phylogenetics, and strain characterization.

## Installation and Setup
The tool is distributed via Bioconda. Ensure your environment is configured with the necessary channels.

```bash
conda install -c bioconda -c conda-forge bactopia-variants
```

## Common CLI Patterns
While `bactopia-variants` is often invoked as a subworkflow within the broader Bactopia pipeline, it can be targeted specifically for variant-centric analyses.

### Basic Variant Calling
To run the standard variant calling pipeline against a reference:
```bash
bactopia --samples sample_list.txt --reference reference.fasta --workflow variants
```

### Key Parameters for Variant Analysis
- `--min_coverage`: Set the minimum depth of coverage required to call a variant (default is usually 10x).
- `--min_base_quality`: Filter out low-quality base calls to reduce false positives.
- `--min_fraction`: The minimum allele frequency required to report a SNP (useful for detecting sub-populations).

## Expert Tips
- **Reference Selection**: Always use a high-quality, closed reference genome that is phylogenetically close to your samples to minimize mapping artifacts.
- **Masking**: For phylogenetic trees, consider masking repetitive regions (like IS elements or prophages) to avoid "noise" in the SNP alignment.
- **QC Integration**: Always review the `bactopia-variants` summary reports to check for samples with low mapping percentages, which may indicate contamination or poor reference choice.

## Reference documentation
- [Bactopia Introduction](./references/bactopia_github_io_index.md)
- [Bactopia Variants Overview](./references/anaconda_org_channels_bioconda_packages_bactopia-variants_overview.md)