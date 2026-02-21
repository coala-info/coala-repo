---
name: phame
description: PhaME (Phylogenetic and Molecular Evolution) is a specialized bioinformatics pipeline designed to automate the extraction of Single Nucleotide Polymorphisms (SNPs) from various genomic data types.
homepage: https://github.com/LANL-Bioinformatics/PhaME
---

# phame

## Overview

PhaME (Phylogenetic and Molecular Evolution) is a specialized bioinformatics pipeline designed to automate the extraction of Single Nucleotide Polymorphisms (SNPs) from various genomic data types. By comparing raw reads, draft assemblies, or finished genomes against a reference, it generates SNP multiple sequence alignments used to reconstruct high-resolution phylogenetic trees. Beyond tree building, PhaME facilitates evolutionary studies by analyzing SNPs within coding sequences (CDS) to detect signatures of positive selection.

## Core Usage

The primary way to interact with PhaME is through its command-line interface using a control file that defines the parameters of the run.

### Basic Execution
To run a PhaME analysis, navigate to your project directory and execute:
```bash
phame phame.ctl
```

### Installation and Environment
Due to the complex dependency tree (including BioPerl, SAMtools, and various aligners), it is highly recommended to use a dedicated Conda environment:
```bash
conda create -n phame_env
conda install -c bioconda phame -n phame_env
conda activate phame_env
```

## Workflow Best Practices

### Input Preparation
PhaME is versatile in its input requirements. Ensure your data is organized as follows:
- **Reference Genome**: A high-quality complete genome is preferred to serve as the backbone for SNP calling.
- **Raw Reads**: Fastq files from Illumina platforms.
- **Contigs/Genomes**: Fasta files for draft or complete genomes.

### The Control File (phame.ctl)
The `phame.ctl` file is the central configuration hub. Key parameters to configure include:
- **refdir**: Directory containing the reference genome.
- **workdir**: Directory where output files will be generated.
- **project**: A prefix for all output files.
- **aligner**: Choose between `bowtie2`, `bwa`, or `minimap2` based on your data type and preference.
- **tree**: Select the tree-building algorithm, such as `fasttree`, `raxml`, or `iqtree`.
- **code**: Specify the genetic code for translation if performing CDS-based evolutionary analysis.

### Evolutionary Analysis
To perform positive selection analysis, ensure that:
1. Your reference genome has an associated GFF file for CDS coordinates.
2. The `cds` option is enabled in the control file.
3. PhaME will utilize tools like PAML or HyPhy to calculate dN/dS ratios.

## Expert Tips
- **Dependency Conflicts**: If using the development version from GitHub, be cautious of BioPerl version mismatches. The Bioconda package is generally more stable for production runs.
- **Testing**: Before running on large datasets, use the provided test script to verify the installation: `test/TestAll.sh 1`.
- **SNP Filtering**: Pay attention to the SNP filtering parameters in the control file to balance between sensitivity and the removal of false positives in repetitive regions.

## Reference documentation
- [PhaME GitHub Repository](./references/github_com_LANL-Bioinformatics_PhaME.md)
- [PhaME Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phame_overview.md)