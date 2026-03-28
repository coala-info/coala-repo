---
name: vgp-processcuration
description: The vgp-processcuration toolkit automates the final processing of curated genome assemblies to generate submission-ready files. Use when user asks to split AGP files by haplotype, reconcile FASTA sequences with curation instructions, assign chromosome names, or reorient secondary haplotypes.
homepage: https://github.com/vgl-hub/vgl-curation
---


# vgp-processcuration

## Overview

The vgp-processcuration toolkit (also known as ProcessCurated) is designed for the final stages of genome assembly curation. It bridges the gap between manual curation—typically performed in PretextView—and the generation of submission-ready files. The toolset automates the reconciliation of AGP files with FASTA sequences, handles haplotype splitting, assigns chromosome names to scaffolds, and ensures that the secondary haplotype is correctly oriented and named relative to the primary haplotype.

## Core Workflow and CLI Usage

### 1. Splitting and Correcting AGP Files
The first step involves splitting the combined haplotype AGP and correcting sequence lengths.

```bash
split_agp -f <combined_assembly.fasta> -a <curated.agp> -o <output_dir>
```
*   **Input**: Combined FASTA and the AGP file exported from PretextView.
*   **Output**: Corrected AGP files and haplotype-specific AGP files (e.g., `hap.unlocs.no_hapdups.agp`).

### 2. Reconciling FASTA with AGP
Use `gfastats` (a required dependency) to apply the AGP instructions to the FASTA file and sort by size.

```bash
# For Haplotype 1
gfastats <fasta> --agp-to-path Hap_1/hap.unlocs.no_hapdups.agp -o Hap_1/hap.unlocs.no_hapdups.fa
gfastats Hap_1/hap.unlocs.no_hapdups.fa --sort largest -o Hap_1/hap.sorted.fa

# Repeat for Haplotype 2
```

### 3. Chromosome Assignment
Map scaffolds to their final chromosomal assignments.

```bash
chromosome_assignment -a Hap_1/hap.unlocs.no_hapdups.agp -f Hap_1/hap.sorted.fa -o Hap_1
```
*   **Output**: `inter_chr.tsv` (mapping table) and `hap.chr_level.fa` (chromosome-level FASTA).

### 4. Haplotype Reorientation (Hap 2 to Hap 1)
To ensure Haplotype 2 matches Haplotype 1, align them with MashMap and generate a SAK (Sequence Alteration Kit) file.

```bash
# 1. Align
mashmap -r Hap_1/hap.chr_level.fa -q Hap_2/hap.chr_level.fa -f one-to-one -s 50000 --pi 90 -o mashmap.out

# 2. Generate SAK instructions
sak_generation -1 Hap_1/inter_chr.tsv -2 Hap_2/inter_chr.tsv -r Hap_1 -q Hap_2 -a corrected.agp -m mashmap.out -o tagged_pairs/

# 3. Apply reorientation using gfastats
gfastats Hap_2/tmpnamed.fa -k tagged_pairs/reversing_renaming.sak -o Hap_2/hap2.reoriented.renamed.fasta
```

## Expert Tips and Best Practices

*   **Automated Pipeline**: For most standard VGP workflows, use the provided wrapper script `curation_2.0_pipe.sh` to run the entire process in one command.
    ```bash
    sh curation_2.0_pipe.sh -f <combined.fasta> -a <curated.agp> -s <Heterogametic_Chr>
    ```
*   **Temporary Suffixes**: When reorienting Haplotype 2, always add a temporary suffix (e.g., `_oldname`) to the FASTA headers before running `sak_generation` and `gfastats`. This prevents naming collisions during the renaming process.
*   **Unloc Handling**: The `split_agp` tool automatically handles "unlocs" (unlocalized scaffolds). Ensure you use the `hap.unlocs.no_hapdups.agp` output for subsequent steps to ensure these are correctly placed.
*   **Heterogametic Chromosomes**: When running the full pipeline or `sak_generation`, specify the heterogametic chromosome (e.g., `X`, `Y`, `Z`, or `W`) using the `-s` flag to ensure sex chromosomes are handled correctly during homology mapping.



## Subcommands

| Command | Description |
|---------|-------------|
| chromosome_assignment | Modify scaffold names to reflect chromosomal assignment. |
| filter_mashmap_with_tagged_pairs | Filter Mashmap output to keep only Scaffolds paired with the tags Hap_1 and Hap_2 |
| split_agp | Correct AGP for sequence lengths, split the agp per haplotype, assign unlocs and remove duplicated haplotigs |

## Reference documentation
- [Process Curated Genome Assembly README](./references/github_com_vgl-hub_vgl-curation_blob_main_README.md)
- [Tool Usage and Pipeline Details](./references/github_com_vgl-hub_vgl-curation_blob_main_README.rst.md)
- [Version 1.1 Bug Fixes and Technical Details](./references/github_com_vgl-hub_vgl-curation_blob_main_CHANGES.md)