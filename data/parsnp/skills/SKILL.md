---
name: parsnp
description: "Parsnp performs efficient microbial core genome alignment, SNP calling, and phylogenetic reconstruction for large sets of genomes. Use when user asks to align microbial genomes, identify core SNPs, or generate a phylogenetic tree from draft and finished assemblies."
homepage: https://github.com/marbl/parsnp
---


# parsnp

## Overview
Parsnp is a specialized command-line tool designed for efficient microbial core genome alignment. It identifies the conserved "core" regions shared among a set of input genomes and performs high-speed SNP calling and phylogenetic reconstruction. It is optimized to handle both finished genomes and draft assemblies, making it a standard choice for outbreak investigations and large-scale comparative genomics where traditional whole-genome alignment methods are too slow.

## Common CLI Patterns

### Basic Alignment
To run Parsnp, you must provide a reference genome and a directory containing the query genomes.

Using a GenBank reference (recommended for better annotation context):
`parsnp -g /path/to/reference.gbk -d /path/to/genomes_dir -o output_dir`

Using a FASTA reference:
`parsnp -r /path/to/reference.fna -d /path/to/genomes_dir -o output_dir`

### Handling Large Datasets (Partition Mode)
Parsnp 2 uses a partitioning strategy to reduce memory and CPU usage. It groups query genomes into random sets (default 50) and merges the results.

*   **Adjust partition size**: Use `--min-partition-size <int>` to change the grouping threshold.
*   **Disable partitioning**: For smaller datasets where you want to align all genomes in a single step, use the `--no-partition` flag.

### Filtering and Quality Control
*   **Divergent Genomes**: If your input genomes are highly divergent, Parsnp might filter them out. Use `--skip-ANI-filter` (formerly `--no-recruit`) to bypass the Average Nucleotide Identity check.
*   **Overwrite Output**: Parsnp requires the `--force-overwrite` (or `--fo`) flag if the specified output directory already exists.

## Output Files
*   `parsnp.xmfa`: The core-genome multi-alignment.
*   `parsnp.tree`: The Newick format phylogenetic tree based on core SNPs.
*   `parsnp.snps.mblocks`: The core-SNP signature in FASTA format used for tree generation.
*   `parsnp.ggr`: A compressed alignment file for visualization in Gingr.

## Expert Tips
*   **Unique Filenames**: Ensure all input genome files have unique file stems (the part before the extension). Parsnp will exit with an error if it detects duplicate stems.
*   **Reference Selection**: The choice of reference significantly impacts the "core" genome size. Use a reference that is closely related to the majority of your query set to maximize the alignment length.
*   **Memory Management**: If running on a cluster or a machine with limited resources, leverage the partition mode to keep the memory footprint low.
*   **Visualization**: The `.ggr` output is specifically designed for the Harvest suite. Use the `harvest-tools` to convert or manipulate these files if needed for other downstream applications.

## Reference documentation
- [Parsnp GitHub Repository](./references/github_com_marbl_parsnp.md)
- [Bioconda Parsnp Overview](./references/anaconda_org_channels_bioconda_packages_parsnp_overview.md)