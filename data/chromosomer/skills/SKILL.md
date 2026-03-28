---
name: chromosomer
description: Chromosomer organizes fragmented genomic sequences into chromosome-level assemblies using a related reference genome as a guide. Use when user asks to organize scaffolds into chromosomes, map fragments to a reference genome, or transfer annotations to a new assembly.
homepage: https://github.com/gtamazian/chromosomer
---


# chromosomer

## Overview

Chromosomer is a bioinformatics utility designed to organize fragmented genomic sequences into chromosome-level assemblies by using a related reference genome as a guide. It facilitates the transition from unordered scaffolds to structured chromosomes by determining fragment orientation and placement based on alignment data. This tool is particularly useful in the final stages of a genome project where a high-quality reference of a related species is available.

## Core Workflow

The standard assembly process follows a four-step procedure:

1.  **Calculate Fragment Lengths**: Generate a length file for your input fragments.
    `chromosomer fastalength fragments.fa fragments.length`

2.  **Align Fragments**: Align your fragments to the reference genome using BLAST+ (required format: tabular outfmt 6).
    `blastn -query fragments.fa -db reference_db -outfmt 6 -out alignments.txt`

3.  **Create Fragment Map**: Map the fragments to the reference chromosomes.
    `chromosomer fragmentmap alignments.txt <gap_size> fragments.length fragment_map.txt`

4.  **Assemble Sequences**: Produce the final FASTA file of reconstructed chromosomes.
    `chromosomer assemble fragment_map.txt fragments.fa assembled_chromosomes.fa`

## Command Reference

### fragmentmap
Produces a map of fragments based on alignments.
- **Arguments**: `alignment_file`, `gap_size`, `fragment_lengths`, `output_map`
- **Tip**: Set `gap_size` to the maximum insert size of your mate-pair library to represent the minimum physical distance likely separating scaffolds.

### assemble
Obtains FASTA sequences of the reconstructed chromosomes.
- **Arguments**: `map_file`, `fragment_fasta`, `output_fasta`
- **Note**: The output headers will match the chromosome names in the reference genome.

### transfer
Moves annotated regions (GFF/BED) from original fragments to the new assembled chromosomes.
- **Arguments**: `map_file`, `annotation_file`, `output_file`
- **Format Support**: Supports common annotation formats; use the `--format` flag to specify if not automatically detected.

### fragmentmapstat
Provides a summary of the mapping results, including the number of mapped, unlocalized, and unplaced fragments.
- **Usage**: `chromosomer fragmentmapstat fragment_map.txt`

## Expert Tips and Best Practices

- **Repeat Masking**: Always mask interspersed and low-complexity repeats in both the reference genome and the fragments before running BLAST. Unmasked repeats lead to non-specific alignments and incorrect fragment placement.
- **Alignment Filtering**: When running `blastn`, use parameters like `-perc_identity` or `-evalue` to ensure only high-quality alignments are used for the mapping step.
- **Unplaced Fragments**: Use `fragmentmapstat` to check the total length of unplaced fragments. If a large portion of your assembly is unplaced, consider lowering the alignment stringency or checking for significant evolutionary divergence between your sample and the reference.
- **Soft-masking**: If your input fragments are soft-masked, `chromosomer assemble` can preserve this masking in the output chromosomes.



## Subcommands

| Command | Description |
|---------|-------------|
| agp2map | Convert an AGP file to the fragment map format. |
| chromosomer assemble | Get the FASTA file of assembled chromosomes. |
| chromosomer fragmentmap | Construct a fragment map from fragment alignments to reference chromosomes. |
| chromosomer fragmentmapbed | Convert a fragment map to the BED format. |
| chromosomer fragmentmapstat | Show statistics on a fragment map. |
| chromosomer simulator | Simulate fragments and test assembly for testing purposes. |
| chromosomer_fastalength | Get lengths of sequences in the specified FASTA file (required to build a fragment map). |
| chromosomer_transfer | Transfer annotated genomic features from fragments to their assembly. |

## Reference documentation
- [Chromosomer Main Repository](./references/github_com_gtamazian_chromosomer.md)
- [Brief guide to Chromosomer assembly process](./references/github_com_gtamazian_chromosomer_wiki_Brief-guide-to-Chromosomer-assembly-process.md)