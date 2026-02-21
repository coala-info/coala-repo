---
name: shiver
description: shiver (Sequences from HIV Easily Reconstructed) is a bioinformatics pipeline that automates the reconstruction of viral sequences.
homepage: https://github.com/ChrisHIV/shiver
---

# shiver

## Overview
shiver (Sequences from HIV Easily Reconstructed) is a bioinformatics pipeline that automates the reconstruction of viral sequences. Unlike standard mapping approaches that use a single distant reference, shiver uses sample-specific contigs to create a tailored reference. This process involves cleaning contigs of contamination, correcting structural issues, and aligning them to a set of existing references to ensure the final mapping is as accurate as possible. While optimized for HIV-1, it can be adapted for other viruses.

## Core Workflow

The shiver pipeline typically follows a three-step execution pattern.

### 1. Initialization
Run this once to prepare a directory for a batch of samples using the same configuration and reference set.
```bash
shiver_init.sh <init_dir> <config_file> <ref_alignment.fasta> <adapters.fasta> <primers.fasta>
```
*   **Reference Alignment**: Use a curated alignment (e.g., LANL HIV-1 compendium) that covers the expected diversity of your samples.
*   **Config File**: Usually found in the `bin/config.sh` of the shiver installation.

### 2. Contig Alignment and Cleaning
This step processes the contigs assembled from your reads. It identifies viral contigs, removes contamination, and aligns them to the reference set.
```bash
shiver_align_contigs.sh <init_dir> <config_file> <sample_contigs.fasta> <output_id>
```
*   **Output**: Generates `<output_id>_cut_wRefs.fasta`, which contains the corrected contigs aligned to the references.
*   **Expert Tip**: Always inspect this alignment file. If the algorithmic alignment is poor, the subsequent mapping will be biased or incomplete.

### 3. Read Mapping and Consensus Calling
The final step builds the sample-specific reference, maps the raw reads (FASTQ), and calls the consensus sequence.
```bash
shiver_map_reads.sh <init_dir> <config_file> <sample_contigs.fasta> <output_id> \
    <output_id>.blast <output_id>_cut_wRefs.fasta \
    <reads_R1.fastq> <reads_R2.fastq>
```
*   **Blast File**: Use the `.blast` file generated in the previous step.
*   **Reads**: Supports both paired-end and single-end reads.

## Best Practices and Tips

*   **Dependency Check**: Ensure `blast` is version 2.2.28 or higher. Earlier versions contain a bug that prevents shiver from correctly processing contigs.
*   **Reference Selection**: For HIV-1, the LANL "compendium" alignment is the gold standard. Ensure your reference alignment includes all subtypes and recombinants likely to be present in your dataset.
*   **Configuration**: Modify `config.sh` to adjust mapping parameters (e.g., using `smalt`, `BWA`, or `bowtie`) and quality trimming settings.
*   **Contamination**: `shiver_align_contigs.sh` is effective at stripping non-viral sequences, but high levels of human DNA contamination should be pre-filtered if possible to speed up processing.
*   **Windows Usage**: shiver does not run natively on Windows. Use the official Ubuntu-based VirtualBox image or a Linux environment (WSL2/Docker) with `bioconda` installed.

## Reference documentation
- [shiver Overview](./references/anaconda_org_channels_bioconda_packages_shiver_overview.md)
- [shiver GitHub Repository](./references/github_com_ChrisHIV_shiver.md)