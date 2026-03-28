---
name: haplomap
description: Haplomap performs haplotype-based computational genetic mapping to identify genomic regions associated with specific phenotypes in inbred populations. Use when user asks to perform genetic mapping, identify genomic regions associated with phenotypes, or analyze haplotype blocks in mouse populations.
homepage: https://github.com/zqfang/haplomap
---

# haplomap

## Overview

Haplomap is a specialized tool for Haplotype-Based Computational Genetic Mapping (HBCGM). It is designed to identify genomic regions associated with specific phenotypes in inbred populations, such as those found in the Mouse Phenome Database (MPD). By analyzing haplotype blocks rather than individual SNPs, it provides a more robust framework for genetic discovery. This skill provides guidance on setting up the environment, preparing input data, and executing the core mapping workflows.

## Environment Setup

Haplomap requires a specific set of dependencies for both the core mapping and the preceding variant calling steps.

### Core Dependencies
- **GSL**: GNU Scientific Library (Required for C++ backend)
- **C++11**: GCC >= 4.8 or Clang >= 11.0.3
- **Python**: For workflow management and data processing

### Installation via Conda
The most efficient way to install haplomap and its dependencies is through Bioconda:
```bash
conda install -c bioconda haplomap
```

## Data Preparation

Before running the mapping, you must prepare your trait data and genomic variants.

### 1. Trait ID File
Create a text file containing Mouse Phenome Database (MPD) `measnum` IDs.
- Format: One ID per row.
- Suffixes: Use `-m` for male and `-f` for female data.
- Example:
  ```text
  26720-m
  26720-f
  9940-f
  ```

### 2. Genomic Input Requirements
Haplomap relies on high-quality variant data. Ensure you have the following ready:
- **VCF Files**: Filtered VCFs containing the variants for your population.
- **VEP Output**: Ensembl Variant Effect Predictor results for functional annotation.
- **Genetic Relation File**: (Optional) PLink output (`.rel`) to account for population structure.
- **Gene Expression**: (Optional) Compact expression data to support multi-modal discovery.

## Execution Patterns

### Standalone Usage
For direct execution of the `haplomap` binary, ensure your GSL library path is exported if you installed from source:
```bash
export LD_LIBRARY_PATH="${HOME}/program/gsl/lib:$LD_LIBRARY_PATH"
```

### Snakemake Workflow Integration
Haplomap is typically run as part of a Snakemake pipeline to handle the multi-step nature of genetic mapping.

**Local Execution:**
Run the pipeline using the provided Snakemake file and configuration:
```bash
snakemake -s workflows/haplomap.smk --configfile workflows/config.yaml -k -p -j 24
```

**HPC Execution (SLURM):**
For large-scale MPD datasets, use the SLURM submission script:
```bash
sbatch slurm.submit.sh
```

## Best Practices

- **Strain Annotation**: Ensure your `STRAIN_ANNO` metadata file correctly maps strain abbreviations to full names and JAX IDs.
- **Raw Data vs. Means**: By default, the tool uses strain means. Set `USE_RAWDATA: true` in your configuration if you need to analyze individual animal data.
- **Resource Allocation**: Genetic mapping is computationally intensive. When running on local nodes, use at least 12-24 cores (`-j` flag) to handle the parallel processing of multiple traits.



## Subcommands

| Command | Description |
|---------|-------------|
| annotate | Convert ensembl-vep to eblocks (-g) input |
| convert | Convert VCF to NIEHS compact format |
| eblocks | Finds haploblocks from a set of strains, alleles, and gene annotations. |
| ghmap | Output gene-summaried results by default. |
| pca | Perform reduction on the data dimension (rows) |

## Reference documentation
- [Haplomap Main README](./references/github_com_zqfang_haplomap_blob_master_README.md)
- [Environment Configuration](./references/github_com_zqfang_haplomap_blob_master_environment.yaml.md)
- [SLURM Submission Guide](./references/github_com_zqfang_haplomap_blob_master_slurm.submit.sh.md)