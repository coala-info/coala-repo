---
name: ngs-chew
description: `ngs-chew` is a specialized Python-based toolbox designed for the rapid validation of germline NGS datasets.
homepage: https://github.com/bihealth/ngs-chew
---

# ngs-chew

## Overview

`ngs-chew` is a specialized Python-based toolbox designed for the rapid validation of germline NGS datasets. It operates by generating compact "fingerprint" files—stored as compressed numpy arrays (.npz)—that represent the unique genetic signature of a sample. These fingerprints allow for highly efficient comparisons across large cohorts to ensure sample integrity, verify pedigrees, and detect contamination without the computational overhead of full sequence alignment comparisons.

## Installation and Requirements

Before using `ngs-chew`, ensure the following dependencies are installed and available in your PATH:
- **samtools**
- **bcftools**

The tool can be installed via bioconda:
```bash
conda install bioconda::ngs-chew
```

## Common CLI Patterns

### Generating Sample Fingerprints
The primary entry point for creating a genetic signature from an alignment file is the `fingerprint` command.

```bash
ngs-chew fingerprint \
    --reference /path/to/reference.fasta \
    --input-bam /path/to/sample.bam \
    --output-fingerprint sample_id.npz \
    --genome-release GRCh37
```

**Key Arguments:**
- `--reference`: Path to the FASTA reference genome used for alignment.
- `--input-bam`: The BAM file to be fingerprinted.
- `--output-fingerprint`: The destination path for the `.npz` file.
- `--genome-release`: Specify the assembly (e.g., `GRCh37` or `GRCh38`).

### Comparing Fingerprints
Once fingerprints are generated, they can be compared to identify sample swaps or relatedness.

- **Sample Swap Detection**: Compare a new fingerprint against a database of known fingerprints to verify identity.
- **Relatedness Analysis**: Detect cryptic relationships (e.g., parent-child, siblings) within a cohort.
- **Contamination Checking**: Use balance-enhanced fingerprints (which store allele balance information) to detect if a sample is contaminated with DNA from another source.

## Expert Tips and Best Practices

1. **Allele Balance**: When possible, enable allele balance storage during fingerprinting. This provides the necessary data for downstream contamination analysis, which is more sensitive than simple identity checks.
2. **Reference Consistency**: Always ensure the `--genome-release` and the `--reference` file match the version used during the initial mapping/alignment phase to avoid coordinate mismatches.
3. **Storage Efficiency**: Use `.npz` fingerprints for long-term QC auditing. They are significantly smaller than BAM or VCF files, making them ideal for maintaining a "genetic ID card" for every sample in a large-scale biobank or clinical pipeline.
4. **Sanity Checking**: Use the tool as a "gatekeeper" in your pipeline. Run fingerprinting immediately after BAM generation to catch sample swaps before expensive downstream variant calling and interpretation occur.

## Reference documentation
- [ngs-chew Overview](./references/anaconda_org_channels_bioconda_packages_ngs-chew_overview.md)
- [ngs-chew GitHub Repository](./references/github_com_bihealth_ngs-chew.md)