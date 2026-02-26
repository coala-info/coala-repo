---
name: vgp-processcuration
description: `vgp-processcuration` automates the structural reconciliation of genome assemblies after manual curation. Use when user asks to process genome assemblies, split haplotypes, assign unlocalized sequences, correct AGP files, assign chromosomes, align haplotypes, or reorient sequences.
homepage: https://github.com/vgl-hub/vgl-curation
---


# vgp-processcuration

## Overview
The `vgp-processcuration` (also known as `vgl-curation`) skill provides a specialized workflow for the final stages of genome assembly. After manual curation in tools like PretextView, assemblies often require structural reconciliation. This tool automates the splitting of haplotypes, assignment of unlocalized sequences (unlocs), and the reorientation of sequences based on MashMap alignments to ensure consistency between haplotype sets.

## Core Workflow
The most efficient way to use this tool is via the master pipeline script, which handles the multi-step process of file splitting, sorting, and renaming.

### Full Pipeline Execution
Use the `curation_2.0_pipe.sh` script to process both haplotypes simultaneously.
```bash
sh curation_2.0_pipe.sh -f <combined_fasta> -a <pretextview_agp> -s <heterogametic_chrom> -d
```
- `-f`: The input FASTA containing both haplotypes.
- `-a`: The AGP file generated after manual curation.
- `-s`: The heterogametic chromosome (e.g., X, Y, Z, or W) to ensure correct tagging.
- `-d`: Optional flag to test and install dependencies via conda.

### Modular Operations
If the full pipeline is not required, use individual components for specific tasks:

1.  **AGP Correction and Haplotype Splitting (`split_agp`)**
    Corrects sequence lengths and separates haplotypes.
    ```bash
    split_agp -f <assembly.fasta> -a <curated.agp> -o <output_dir>
    ```

2.  **Chromosome Assignment (`chromosome_assignment`)**
    Maps scaffolds to chromosome names and generates a chromosome-level FASTA.
    ```bash
    chromosome_assignment -a <hap.unlocs.agp> -f <hap.sorted.fa> -o <output_dir>
    ```

3.  **Haplotype Alignment and Reorientation (`sak_generation`)**
    Uses MashMap data to ensure Haplotype 2 matches the orientation and naming of Haplotype 1.
    ```bash
    sak_generation -1 <hap1_inter_chr.tsv> -2 <hap2_inter_chr.tsv> -r Hap_1 -q Hap_2 -a corrected.agp -m mashmap.out -o <output_dir>
    ```

## Expert Tips & Best Practices
- **Temporary Suffixing**: When manually reorienting sequences with `gfastats` and SAK files, always add a temporary suffix (e.g., `_oldname`) to your FASTA headers before running `sak_generation`. This prevents naming collisions during the renaming process.
- **Sorting**: Always run `gfastats --sort largest` on your reconciled FASTA files before chromosome assignment to ensure consistent indexing.
- **Dependency Management**: The tool relies on `gfastats` (>=1.3.10) and `MashMap`. If running individual components, ensure these are in your PATH.
- **Unloc Handling**: The `split_agp` tool automatically identifies and assigns unlocalized sequences; check the `//hap.unlocs.no_hapdups.agp` output to verify that haplotig duplications were correctly removed.

## Reference documentation
- [VGL Curation GitHub Repository](./references/github_com_vgl-hub_vgl-curation.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_vgp-processcuration_overview.md)