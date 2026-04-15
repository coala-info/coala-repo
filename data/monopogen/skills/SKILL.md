---
name: monopogen
description: Monopogen is a computational framework for calling germline and somatic single-nucleotide variants from sparse single-cell sequencing data using reference panels and linkage disequilibrium. Use when user asks to preprocess single-cell BAM files, call germline SNVs with imputation, or identify somatic mutations through statistical phasing.
homepage: https://github.com/KChen-lab/Monopogen
metadata:
  docker_image: "quay.io/biocontainers/monopogen:1.6.0--pyhdfd78af_0"
---

# monopogen

## Overview

Monopogen is a specialized analysis framework designed to overcome the inherent sparsity and allelic dropout issues in single-cell sequencing when calling SNVs. It transforms raw alignment data into high-confidence variant calls by leveraging external reference panels (like 1000 Genomes or TopMed) and population-level linkage disequilibrium. The tool is structured into three primary modules: preprocessing for quality control, a germline module for sensitive population-based calling, and a somatic module that uses statistical phasing to identify cell-specific mutations.

## Installation and Environment Setup

Monopogen can be installed via Bioconda or from source. Because it relies on specific versions of bioinformatics tools (samtools 1.2, bcftools 1.8, Beagle 4.1), it is recommended to use the binaries provided in the `apps` directory of the repository.

```bash
# Installation via Conda
conda install bioconda::monopogen

# Manual setup and environment configuration
export MONOPOGEN_PATH="/path/to/Monopogen"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${MONOPOGEN_PATH}/apps
```

## Core Workflows

### 1. Data Preprocessing
This step filters reads with high alignment mismatches and prepares BAM files for variant calling.

**Input Requirement**: A `bam.lst` file where each row contains the path to a sorted BAM file for a sample.

```bash
python ${MONOPOGEN_PATH}/src/Monopogen.py preProcess \
    -b bam.lst \
    -o ./output_dir \
    -a ${MONOPOGEN_PATH}/apps \
    -m 3 \
    -t 8
```
*   `-m`: Maximum alignment mismatches allowed per read (default is 3).
*   `-t`: Number of threads.

### 2. Germline SNV Calling
Uses LD refinement to improve detection sensitivity in sparse data.

```bash
python ${MONOPOGEN_PATH}/src/Monopogen.py germline \
    -r chr20:1-2000000 \
    -s all \
    -o ./output_dir \
    -g reference_genome.fa \
    -p reference_panel.vcf.gz \
    -a ${MONOPOGEN_PATH}/apps \
    -t 8
```
*   `-s`: Steps to run (`varScan`, `varImpute`, `varPhasing`, or `all`).
*   `-p`: The imputation reference panel (e.g., 1KG3 or TopMed).
*   `-r`: Target genomic region.

### 3. Somatic SNV Calling
Identifies putative somatic mutations by phasing observed alleles with adjacent germline alleles.

**Key Feature**: Version 1.5.0+ uses a motif-based search directly from BAM files, significantly increasing speed by avoiding BAM splitting.

```bash
# Typical somatic workflow involves preprocessing, germline calling, 
# and then LD refinement on putative somatic sites.
python ${MONOPOGEN_PATH}/src/Monopogen.py somatic [options]
```

## Expert Tips and Best Practices

*   **Binary Compatibility**: If you encounter execution errors with the bundled tools in `apps/`, you may need to compile `samtools` (v1.2) and `bcftools` (v1.8) locally, as Monopogen is sensitive to the output format of these specific versions.
*   **Speed Optimization**: For large datasets (e.g., 10k cells), ensure you are using version 1.5.0 or later to take advantage of the `cell-scan` optimization, which can process 20k loci in under 60 minutes.
*   **Memory Management**: When running the `germline` module on whole-genome data, process by chromosome or specific regions using the `-r` flag to manage memory consumption.
*   **Cell Type Filtering**: For somatic calling, use cell type information (from scRNA/ATAC clusters) to filter putative SNVs, as true somatic mutations often cluster within specific lineages.
*   **Matrix Output**: Note that in recent updates, the `cellxSNV` matrix reflects sequencing depth for both wild-type and mutated alleles rather than a simple binary presence/absence.

## Reference documentation
- [Monopogen GitHub Repository](./references/github_com_KChen-lab_Monopogen.md)
- [Bioconda Monopogen Package](./references/anaconda_org_channels_bioconda_packages_monopogen_overview.md)