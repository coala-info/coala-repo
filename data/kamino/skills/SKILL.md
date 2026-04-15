---
name: kamino
description: Kamino is a reference-free tool that constructs amino-acid alignments from proteome sequences using a global assembly graph. Use when user asks to construct amino-acid alignments, generate phylogenomic datasets from proteomes, or perform alignment-free sequence analysis.
homepage: https://github.com/rderelle/kamino
metadata:
  docker_image: "quay.io/biocontainers/kamino:0.7.0--h4349ce8_0"
---

# kamino

## Overview
Kamino is a high-performance, reference-free, and alignment-free tool designed to construct amino-acid alignments from proteome sequences. Unlike traditional pipelines that rely on ortholog identification and multiple sequence alignment, kamino uses a global assembly graph and a 6-letter recoding scheme to identify variant groups. This approach allows for the generation of phylogenomic datasets in seconds or minutes, even for hundreds of samples, while remaining fully deterministic.

## Installation
Install kamino via Bioconda:
```bash
conda install bioconda::kamino
```

## Core CLI Usage
Kamino requires proteome files in FASTA format (can be gzipped).

### Basic Execution
Provide an input directory containing one FASTA file per sample:
```bash
kamino -i <input_directory> -o <output_alignment.fasta> -t <threads>
```

Alternatively, provide a tab-delimited file containing paths to the proteomes:
```bash
kamino -I <tabular_file> -o <output_alignment.fasta> -t <threads>
```

## Parameter Tuning and Best Practices

### Increasing Alignment Size
If the resulting alignment has too few positions, adjust the following:
- **Increase Graph Depth (`-d`)**: Raise the maximum depth of the graph traversal to explore more complex variant groups.
- **Lower Missing Data Threshold (`-f`)**: Decrease the minimum proportion of isolates required to have an amino acid at a specific position.

### Filtering and Refinement
- **Recoding Scheme (`-r`)**: Kamino uses a 6-letter amino acid recoding scheme by default to handle divergence.
- **Polymorphism Masking (`-m`)**: Use this to mask long runs of polymorphisms within variant groups to reduce noise.
- **Length Thresholds (`-l`)**: Filter variant groups based on middle-length thresholds to ensure high-quality positions.
- **Constant Positions (`-c`)**: Use this flag to incorporate constant positions into the final alignment, which can be useful for certain phylogenetic models.

### When to Avoid Kamino
- **Low Diversity (Within-species)**: For very closely related isolates, genome-based SNP approaches are more powerful.
- **Extreme Divergence**: Do not use for highly divergent datasets (e.g., across the entire animal kingdom).
- **Sparse Outgroups**: Avoid using a distant outgroup represented by only one or two isolates, as this may lead to excessive missing data.

## Reference documentation
- [Kamino Overview](./references/anaconda_org_channels_bioconda_packages_kamino_overview.md)
- [Kamino GitHub Documentation](./references/github_com_rderelle_kamino.md)