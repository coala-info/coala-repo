---
name: jolytree
description: JolyTree is an alignment-free tool for the rapid estimation of evolutionary distances and phylogenetic tree reconstruction from genome assemblies. Use when user asks to infer phylogenetic trees from contig files, estimate evolutionary distances between genomes, or perform high-performance genomic analysis using MinHash transformations.
homepage: https://research.pasteur.fr/fr/software/jolytree/
---


# jolytree

## Overview
JolyTree is a bioinformatics tool designed for the rapid estimation of evolutionary distances between genomes. It bypasses the computationally expensive step of sequence alignment by using a dissimilarity measure (based on MinHash transformations) to estimate substitution events. This skill provides guidance on using JolyTree to generate phylogenetic trees from genome assemblies, leveraging its multi-threading capabilities for high-performance analysis.

## Usage Patterns

### Basic Tree Reconstruction
To infer a phylogenetic tree from a collection of genome assemblies (FASTA format), the standard approach involves pointing JolyTree to a directory of contig files.

```bash
# Basic execution using default parameters
JolyTree.sh -i /path/to/genomes_directory -b output_prefix
```

### Performance Optimization
JolyTree is highly scalable. Always specify the number of threads to significantly reduce computation time for large genomic datasets.

```bash
# Run with 16 threads for faster distance calculation
JolyTree.sh -i /path/to/genomes_directory -b output_prefix -t 16
```

### Key Parameters and Best Practices
- **Input (-i)**: Ensure all input files in the directory are in FASTA format (.fasta, .fa, .fna).
- **Output Prefix (-b)**: This defines the base name for the generated distance matrix and the final Newick tree file.
- **Branch Support**: JolyTree assesses confidence support for internal branches; ensure you check the resulting tree file for these values to evaluate the robustness of the topology.
- **Memory Management**: While alignment-free methods are generally memory-efficient, ensure the system has enough RAM to hold the sketch representations of the genomes being compared.

## Expert Tips
- **Genome Quality**: While JolyTree is robust to fragmented assemblies (contigs), highly contaminated samples can skew distance estimations. Pre-process genomes with quality control tools if necessary.
- **Evolutionary Distances**: JolyTree transforms uncorrected distances into proper evolutionary distances. This makes it more suitable for phylogenetic inference than raw MinHash Jaccard distances.
- **Installation**: The most reliable way to deploy JolyTree is via Bioconda to ensure all dependencies (like Mash or specific shell environments) are correctly configured.

## Reference documentation
- [JolyTree Software Overview](./references/research_pasteur_fr_fr_software_jolytree.md)
- [Bioconda JolyTree Package](./references/anaconda_org_channels_bioconda_packages_jolytree_overview.md)