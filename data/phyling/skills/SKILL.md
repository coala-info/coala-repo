---
name: phyling
description: Phyling reconstructs species phylogenies from protein-encoded genomic data using HMM marker sets to identify and align single-copy orthologs. Use when user asks to download BUSCO marker sets, align genomic samples to markers, filter multiple sequence alignments, or generate a species tree.
homepage: https://github.com/stajichlab/Phyling
---


# phyling

## Overview

Phyling is a specialized bioinformatics tool designed for reconstructing species phylogenies directly from protein-encoded genomic data. It streamlines the phylogenomic workflow by leveraging Hidden Markov Model (HMM) marker sets from the BUSCO database to identify single-copy orthologs. The tool is particularly effective for large-scale genomic datasets where speed and scalability are required. It supports both peptide and DNA coding sequences (CDS) as input, providing automated translation and back-translation for high-accuracy estimation of closely related species.

## Core Workflow

The Phyling process follows a four-step modular approach:

1.  **Download**: Retrieve HMM marker sets (e.g., from BUSCO v5).
2.  **Align**: Search genomic samples against markers and perform multiple sequence alignment.
3.  **Filter**: Refine MSA results to improve phylogenetic signal.
4.  **Tree**: Generate the final species phylogeny.

### 1. Managing HMM Markers
Before processing samples, you must obtain a marker set.
- **List available sets**: `phyling download list`
- **Download a specific set**: `phyling download <markerset_name>` (e.g., `fungi_odb10`)
- **Storage**: Markers are saved to `~/.phyling` or the path defined in `$PHYLING_DB`.

### 2. Running Alignments
The `align` module identifies orthologs and aligns them.
- **Basic usage**: `phyling align -m <markerset_dir> -i <input_dir>`
- **Input types**: Accepts `.fasta`, `.faa`, or `.fna` files. Supports bgzipped files.
- **DNA/CDS Input**: When using DNA sequences, Phyling automatically translates them to peptides for HMM searching and alignment, then back-translates the final MSA to DNA.
- **Optimization**: Use `-t <threads>` to speed up the search and alignment process.

### 3. Filtering Results
Use the `filter` module to remove low-quality alignments or uninformative sites before tree building.
- **Basic usage**: `phyling filter -i <alignment_dir>`

### 4. Phylogenetic Reconstruction
The `tree` module builds the final phylogeny from the filtered alignments.
- **Concatenation**: Combines all markers into a single supermatrix.
- **Consensus**: Builds individual gene trees and generates a consensus species tree.
- **Basic usage**: `phyling tree -i <filtered_alignments_dir>`

## Expert Tips and Best Practices

- **Marker Selection**: Choose the most specific BUSCO lineage available for your taxa to maximize the number of single-copy orthologs identified.
- **Thread Management**: For large datasets, ensure the number of threads does not exceed 4x the number of samples to maintain efficiency in the alignment pipeline.
- **Closely Related Species**: Always use DNA coding sequences (`cds`) as input for closely related taxa to capture synonymous substitutions that peptide sequences might miss.
- **Environment Variables**: Set `PHYLING_DB` in your `.bashrc` or `.zshrc` to point to a shared database location if working in a multi-user environment or on a cluster with limited home directory space.



## Subcommands

| Command | Description |
|---------|-------------|
| phyling align | Perform multiple sequence alignment (MSA) on orthologous sequences that match the hmm markers across samples. |
| phyling download | Help to download/update BUSCO v5 markerset to a local folder. |
| phyling filter | Filter the multiple sequence alignment (MSA) results for tree module. |
| phyling_tree | Construct a phylogenetic tree by the selected multiple sequence alignment (MSA) results. |

## Reference documentation

- [Phyling Tool README](./references/github_com_stajichlab_Phyling_blob_main_README.md)
- [Phyling Overview](./references/anaconda_org_channels_bioconda_packages_phyling_overview.md)