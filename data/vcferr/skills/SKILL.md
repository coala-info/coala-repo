---
name: vcferr
description: vcferr injects stochastic errors and missing data into VCF genotypes based on user-defined probabilities. Use when user asks to inject errors into VCF genotypes, simulate specific error profiles like drop-outs or drop-ins, add missing data to VCF genotypes, or generate reproducible error datasets.
homepage: https://github.com/signaturescience/vcferr
metadata:
  docker_image: "quay.io/biocontainers/vcferr:1.0.2--pyh5e36f6f_0"
---

# vcferr

## Overview
The `vcferr` tool is a lightweight Python-based framework designed to inject stochastic errors into VCF genotypes. It is particularly useful for testing the robustness of downstream analysis tools (like kinship estimation or variant callers) against specific error profiles. It supports various error models including heterozygous/homozygous drop-outs, drop-ins, and the injection of missing data (./.) based on user-defined probabilities.

## Installation
Install via Bioconda or pip:
```bash
conda install bioconda::vcferr
# OR
pip install vcferr
```

## Core Error Models
The tool uses specific flags to define the probability (0.0 to 1.0) of a genotype transition:

| Flag | Description | Transition |
|------|-------------|------------|
| `--p_rarr` | Heterozygous drop out | (0,1) or (1,0) → (0,0) |
| `--p_aara` | Homozygous alt drop out | (1,1) → (0,1) |
| `--p_rrra` | Heterozygous drop in | (0,0) → (0,1) |
| `--p_raaa` | Homozygous alt drop in | (0,1) or (1,0) → (1,1) |
| `--p_aarr` | Double homozygous alt drop out | (1,1) → (0,0) |
| `--p_rraa` | Double homozygous alt drop in | (0,0) → (1,1) |

## Missingness Models
You can also simulate data loss for specific genotype states:
- `--p_ramm`: Heterozygous to missing (0,1) or (1,0) → (.,.)
- `--p_rrmm`: Homozygous ref to missing (0,0) → (.,.)
- `--p_aamm`: Homozygous alt to missing (1,1) → (.,.)

## Common CLI Patterns

### Basic Error Simulation
Simulate a 5% heterozygous dropout rate for a specific sample and stream the result to stdout:
```bash
vcferr input.vcf.gz --sample "HG001" --p_rarr 0.05
```

### Writing to Disk
Use the `--output_vcf` flag to save the simulated data directly to a file:
```bash
vcferr input.vcf.gz --sample "HG001" --p_rarr 0.1 --output_vcf simulated_errors.vcf.gz
```

### Complex Error Profiles
Combine multiple error types to simulate realistic sequencing noise:
```bash
vcferr input.vcf.gz --sample "HG001" \
  --p_rarr 0.02 \
  --p_rrra 0.01 \
  --p_rrmm 0.05 \
  --output_vcf complex_sim.vcf.gz
```

### Reproducible Simulations
Always provide a seed when generating datasets for benchmarks to ensure the stochastic process is repeatable:
```bash
vcferr input.vcf.gz --sample "HG001" --p_rarr 0.1 --seed 42
```

## Expert Tips
- **Biallelic SNPs Only**: `vcferr` is designed for biallelic SNPs. Ensure your input VCF is pre-filtered to avoid unexpected behavior with indels or multiallelic sites.
- **Phasing Preservation**: The tool preserves phasing information during the simulation process.
- **Sample Specificity**: The tool operates on one sample at a time. If you need to simulate errors across multiple samples in a multi-sample VCF, you must run the tool iteratively or script the process for each sample.
- **Piping**: Since the tool defaults to stdout, it integrates well with `bcftools` for further processing:
  ```bash
  vcferr input.vcf.gz --sample "HG001" --p_rarr 0.1 | bcftools view -O z -o final.vcf.gz
  ```

## Reference documentation
- [vcferr GitHub Repository](./references/github_com_signaturescience_vcferr.md)
- [vcferr Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vcferr_overview.md)