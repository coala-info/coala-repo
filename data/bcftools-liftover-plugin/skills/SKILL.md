---
name: bcftools-liftover-plugin
description: The bcftools-liftover-plugin translates genetic variants in VCF or BCF format across different genome assemblies while preserving metadata and genotypes. Use when user asks to liftover VCF files between genome builds, migrate coordinates for GWAS summary statistics, or convert genetic data using chain files and reference sequences.
homepage: https://github.com/freeseek/score
---


# bcftools-liftover-plugin

## Overview
The `bcftools-liftover-plugin` is a specialized extension for BCFtools designed to accurately translate genetic variants across different genome builds. Unlike standard liftover tools that often operate on BED files, this plugin works directly on VCF/BCF formats, ensuring that essential metadata, genotypes, and INFO fields are preserved and correctly updated. It is particularly effective for GWAS-VCF summary statistics, where maintaining the relationship between the reference allele and the effect allele is critical during coordinate migration.

## Usage Patterns and Best Practices

### Core Command Structure
The tool is invoked as a BCFtools plugin. The general syntax follows the standard BCFtools plugin pattern:

```bash
bcftools +liftover [input.vcf.gz] -- [plugin_options]
```

### Common CLI Tasks
While specific flags are often version-dependent, the following patterns are standard for the `score` suite's liftover functionality:

*   **Basic Liftover**: Converting a VCF from one build to another requires a chain file (mapping coordinates) and the target reference FASTA (to verify alleles).
*   **GWAS-VCF Conversion**: Often used in conjunction with `+munge` to prepare summary statistics for polygenic score (PGS) calculations.
*   **Reference Verification**: The plugin checks if the moved variant matches the reference allele in the new assembly, often tagging mismatches rather than simply moving coordinates.

### Expert Tips
*   **Chain Files**: Always ensure you are using the correct "direction" in your chain file (e.g., hg19ToHg38.over.chain.gz).
*   **Reference Consistency**: Use the `-f` (or equivalent FASTA reference) option to ensure that the REF allele in the VCF matches the actual sequence at the new position. This prevents "silent" errors where coordinates move but the underlying sequence context changes.
*   **Multi-allelic Sites**: The plugin is designed to handle multi-allelic records more robustly than simple coordinate-based liftover scripts.
*   **Pipeline Integration**: For GWAS workflows, the typical order is:
    1. `bcftools +munge`: Standardize the input TSV/SSF to VCF.
    2. `bcftools +liftover`: Move to the desired assembly.
    3. `bcftools +score`: Calculate polygenic scores.

## Reference documentation
- [bcftools-liftover-plugin Overview](./references/anaconda_org_channels_bioconda_packages_bcftools-liftover-plugin_overview.md)
- [freeseek/score GitHub Repository](./references/github_com_freeseek_score.md)