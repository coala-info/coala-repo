---
name: vg
description: The vg toolset works with genomic pangenomes. Use when user asks to construct graphs, generate indexes, map reads, call variants, convert graph formats, or visualize graphs.
homepage: https://github.com/vgteam/vg
---


# vg

## Overview
The `vg` (variation graph) toolset is a comprehensive suite for working with genomic pangenomes. Unlike traditional linear references, variation graphs represent populations of genomes by encoding variants as alternative paths within a graph structure. This approach reduces reference bias and improves alignment accuracy, especially in highly polymorphic regions. This skill provides the essential command-line patterns for the standard pangenome workflow: constructing graphs, generating required indexes, mapping reads, and calling variants.

## Core CLI Workflows

### 1. Graph Construction
To build a graph from a linear reference and a set of known variants:
```bash
# Construct a graph from FASTA and VCF
vg construct -r reference.fa -v variants.vcf.gz > graph.vg
```

### 2. Automatic Indexing
Modern `vg` workflows (especially for the Giraffe aligner) require multiple index files (GBZ, Distance, and Minimizer). Use `autoindex` to generate these in one command:
```bash
# Generate indexes for the Giraffe workflow
vg autoindex --workflow giraffe -r reference.fa -v variants.vcf.gz -p my_index
```

### 3. Read Mapping
`vg giraffe` is the recommended high-speed aligner for pangenomes. It requires the indexes produced in the previous step.
```bash
# Map short reads using Giraffe
vg giraffe -Z my_index.giraffe.gbz -m my_index.min -d my_index.dist -f reads_R1.fq -f reads_R2.fq > aligned.gam

# Map long reads (Hifi/ONT) using Giraffe
vg giraffe -Z my_index.giraffe.gbz -m my_index.min -d my_index.dist -p hifi -f long_reads.fq > aligned.gam
```

### 4. Variant Calling and Genotyping
To call variants, you must first compute read support (packing) and then run the caller.
```bash
# Compute read support
vg pack -x my_index.giraffe.gbz -g aligned.gam -o aligned.pack

# Call variants from the packed support
vg call my_index.giraffe.gbz -k aligned.pack > output_variants.vcf
```

### 5. Visualization and Conversion
Graphs can be converted to different formats or visualized for small regions.
```bash
# Convert .vg to GFA format
vg view graph.vg > graph.gfa

# Export a small graph to DOT for visualization (requires Graphviz)
vg view -d graph.vg | dot -Tpdf -o graph.pdf
```

## Expert Tips and Best Practices
- **Prefer Giraffe**: For most mapping tasks, `vg giraffe` is significantly faster and more accurate than the older `vg map`.
- **Memory Management**: Variation graphs can be memory-intensive. Use the `.gbz` format (Graph-GBWT index) whenever possible, as it is highly compressed and optimized for random access.
- **Path Coordinates**: Use `vg paths` to manage coordinate systems. Variation graphs use "Paths" to maintain stable coordinates relative to reference genomes embedded in the graph.
- **Validation**: Use `vg stats -z graph.vg` to check the basic topology and verify that paths (like chromosomes) are correctly embedded.
- **Large Datasets**: When working with whole-genome human data, ensure you have at least 64GB-128GB of RAM for indexing and mapping.

## Reference documentation
- [vg GitHub Repository](./references/github_com_vgteam_vg.md)
- [vg Wiki and Documentation](./references/github_com_vgteam_vg_wiki.md)
- [Bioconda vg Package](./references/anaconda_org_channels_bioconda_packages_vg_overview.md)