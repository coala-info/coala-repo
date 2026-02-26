---
name: rop
description: The Read Origin Protocol (ROP) characterizes unmapped sequencing reads to identify complex RNA molecules, repetitive elements, and microbial sequences. Use when user asks to analyze unmapped reads, profile the immune repertoire, detect microbial contamination, or identify circular RNAs and repetitive elements.
homepage: https://github.com/smangul1/rop
---


# rop

## Overview
The Read Origin Protocol (ROP) is a specialized bioinformatics pipeline designed to characterize the "unmapped" portion of sequencing datasets. While standard pipelines discard reads that do not align to a reference genome, ROP systematically analyzes these reads to identify complex RNA molecules, repetitive elements, hyper-edited RNAs, circular RNAs, and microbial sequences. It is particularly useful for profiling the immune repertoire (B-cell and T-cell receptors) and detecting environmental or pathogenic contamination within a sample.

## Installation and Setup
ROP can be installed via Bioconda or by cloning the source repository. Note that the tool was originally designed for Python 2 environments.

- **Conda**: `conda install bioconda::rop`
- **Source**: Clone the repository and run `./install.sh`.
- **Databases**: Use the installation script or `getDB.py` to download the required reference sets (repeats, microbiome, etc.). Use the `-d` flag during installation to specify a custom database location if disk space is limited.

## Command Line Usage

### Basic Syntax
The primary entry point is the `rop.sh` script:
```bash
rop.sh [options] <unmapped_reads> <output_dir>
```

### Common Patterns
- **Standard FASTQ analysis**:
  `rop.sh input.fastq output_directory`
- **BAM input**:
  `rop.sh -b input.bam output_directory`
- **Compressed input**:
  `rop.sh -z input.fastq.gz output_directory`
- **FASTA input (disables quality filtering)**:
  `rop.sh -a input.fasta output_directory`

### Step Selection
Use the `-s` or `--steps` flag to run specific modules. Available modules include: `lowq`, `rdna`, `reference`, `repeats`, `circrna`, `immune`, and `microbiome`.
- **Run only immune and microbiome profiling**:
  `rop.sh -s immune,microbiome input.fastq output_dir`
- **Run all steps (default behavior)**:
  `rop.sh -s all input.fastq output_dir`

## Expert Tips and Best Practices
- **Organism Specification**: Always specify the target organism using `-o` (default is `human`, `mouse` is also supported). This ensures the correct reference databases are used for remapping.
- **Liberal Remapping**: If you suspect many reads are failing to map due to minor variations, use the `-m` (max) flag to apply a more liberal threshold when remapping to the reference.
- **Intermediate Files**: By default, ROP deletes intermediate FASTA files to save space. Use the `-d` (dev) flag if you need to inspect the reads at specific stages of the pipeline.
- **Directory Management**: ROP requires the output directory to NOT exist prior to running, unless the `-f` (force) flag is used to overwrite it.
- **Protocol Limitations**: Be aware that `circrna` and `bacteria` (as a sub-category of microbiome) modules may have limited availability or specific version requirements in the current release.

## Reference documentation
- [Main Repository README](./references/github_com_smangul1_rop.md)
- [ROP Wiki and Quick Start](./references/github_com_smangul1_rop_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_rop_overview.md)