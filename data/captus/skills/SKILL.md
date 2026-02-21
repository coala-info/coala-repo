---
name: captus
description: Captus is a modular bioinformatics pipeline designed to streamline the creation of phylogenomic datasets from raw sequencing data.
homepage: https://github.com/edgardomortiz/Captus
---

# captus

## Overview
Captus is a modular bioinformatics pipeline designed to streamline the creation of phylogenomic datasets from raw sequencing data. It automates a multi-step workflow that includes read cleaning, assembly, marker recovery, and alignment. It is particularly effective for researchers working with target enrichment (Hyb-Seq), genome skimming, or transcriptomics who need to move from raw FASTQ files to curated alignments ready for tree inference.

## Core Workflow Commands
Captus follows a typical sequential execution order. Use `captus <command> -h` for detailed options on any specific step.

### 1. Read Cleaning (`clean`)
Trims adapters and filters reads by quality using BBTools, followed by FastQC reporting.
- **Usage**: `captus clean -i <input_dir> -o <output_dir>`
- **Best Practice**: Always run this first unless your reads are already pre-processed by a sequencing provider.

### 2. De Novo Assembly (`assemble`)
Performs assembly using MEGAHIT and estimates contig coverage with Salmon.
- **Usage**: `captus assemble -i <cleaned_reads_dir> -o <output_dir>`
- **Note**: While it prefers reads cleaned by the `clean` command, it can accept reads processed by other tools.

### 3. Marker Extraction (`extract`)
Recovers targeted markers from assemblies using BLAT and Scipio.
- **Usage**: `captus extract -a <assemblies_dir> -t <targets_fasta> -o <output_dir>`
- **Expert Tip (BUSCO)**: You can use BUSCO lineage datasets as reference targets. Download the `.tar.gz` from BUSCO and provide the path:
  `captus extract -a 02_assemblies -n ~/path/to/lineage_odb10.tar.gz`

### 4. Alignment and Filtering (`align`)
Aligns extracted markers across samples using MAFFT or MUSCLE. This step automatically handles paralog filtering and alignment trimming via TAPER and ClipKIT.
- **Usage**: `captus align -i <extracted_markers_dir> -o <output_dir>`

## Installation and Environment
Captus is best managed via Conda/Mamba within the `bioconda` and `conda-forge` channels.

- **Standard Linux/Intel Mac**:
  `mamba create -n captus -c bioconda -c conda-forge captus`
- **Apple Silicon (M1/M2/M3)**:
  Requires the `osx-64` platform flag for compatibility with specific dependencies:
  `mamba create --platform osx-64 -n captus -c bioconda -c conda-forge captus megahit=1.2.9 mmseqs2=16.747c6`

## Common CLI Patterns
- **Check Version**: `captus --version`
- **Help for Subcommand**: `captus <command> -h` (e.g., `captus align -h`)
- **Resume/Overwrite**: Most commands support directory structures created by previous steps; ensure your `-i` (input) points to the specific output folder of the preceding command.

## Reference documentation
- [Captus GitHub Repository](./references/github_com_edgardomortiz_Captus.md)
- [Captus Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_captus_overview.md)