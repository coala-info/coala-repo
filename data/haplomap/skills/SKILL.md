---
name: haplomap
description: Haplomap is an automated graph-based pipeline designed to identify genetic loci associated with specific phenotypes in inbred populations. Use when user asks to perform genetic mapping, identify genetic drivers of complex traits, or process murine phenotype and variant data.
homepage: https://github.com/zqfang/haplomap
---


# haplomap

## Overview
The haplomap tool is a modern successor to the Haplotype-based Computational Genetic Mapping (HBCGM) project. It implements an automated, multi-modal graph-based pipeline designed to identify genetic loci associated with specific phenotypes in inbred populations. It is primarily utilized in murine research to process large-scale datasets (such as those from the Mouse Phenome Database) by integrating variant calling, strain metadata, and gene expression data to discover genetic drivers of complex traits.

## Installation and Environment Setup
The most efficient way to deploy haplomap is via the Bioconda channel.

```bash
# Install via conda
conda install -c bioconda haplomap

# Create the specific environment from the repository's environment file
conda create -n hbcgm -f environment.yaml
conda activate hbcgm
```

### Core Dependencies
Ensure the following tools are available in your path for the full pipeline:
- **Mapping/Calling**: GATK 4.x, BWA, SAMtools, BCFtools
- **Genomics Utilities**: BEDtools, svtools
- **Workflow Management**: Snakemake
- **System**: GSL (GNU Scientific Library), GCC >= 4.8

## Workflow Execution Patterns

### 1. Variant Calling
Before mapping, variants must be called and annotated. The pipeline supports BCFtools and GATK.

```bash
# Run variant calling using BCFtools with 12 cores
snakemake -s workflows/bcftools.call.smk --configfile config.yaml -k -p -j 12
```

### 2. Preparing Input Data
Haplomap requires specific input formats for phenotype and strain data:
- **Trait IDs**: A file with one ID per row, suffixed with `-m` (male) or `-f` (female) (e.g., `26720-m`).
- **Strain Metadata**: A CSV mapping strain abbreviations to full names and JAX IDs.
- **VCF/VEP**: Filtered VCF files and Ensembl-VEP output from the variant calling step.

### 3. Running the Mapping Pipeline
The main mapping procedure is executed through Snakemake.

```bash
# Execute the haplomap pipeline with 24 cores
snakemake -s workflows/haplomap.smk --configfile workflows/config.yaml -k -p -j 24
```

## Configuration Best Practices
When configuring the workflow, pay attention to these critical parameters:
- **USE_RAWDATA**: Set to `false` to use strain means (default) or `true` to use individual animal data.
- **GENETIC_REL**: Provide a genetic relation file (e.g., PLINK output) to account for population structure.
- **GENE_EXPRS**: Including a gene expression file allows for multi-modal integration during the discovery process.

## Expert Tips
- **HPC Execution**: For large-scale MPD datasets (>10k datasets), use the provided SLURM submission scripts (`slurm.submit.sh`) to manage resource allocation on clusters like Stanford Sherlock.
- **Standalone Mode**: While the Snakemake workflow is recommended for reproducibility, the `haplomap` binary can be run standalone for specific sub-tasks.
- **Memory Management**: Genetic mapping is memory-intensive. When running on a local node, ensure at least 24 cores and proportional RAM are available for the haplotype construction phase.

## Reference documentation
- [Haplomap GitHub Repository](./references/github_com_zqfang_haplomap.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_haplomap_overview.md)