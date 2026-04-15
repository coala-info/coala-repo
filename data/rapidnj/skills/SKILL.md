---
name: rapidnj
description: RapidNJ performs fast and memory-efficient phylogenetic tree reconstruction using the Neighbor-Joining method. Use when user asks to infer a phylogenetic tree from a multiple sequence alignment, process a distance matrix, or perform large-scale phylogenetic analysis on desktop hardware.
homepage: http://birc.au.dk/software/rapidnj/
metadata:
  docker_image: "quay.io/biocontainers/rapidnj:v2.3.2--h2d50403_0"
---

# rapidnj

## Overview
RapidNJ is an optimized implementation of the canonical Neighbor-Joining method designed for speed and memory efficiency. It utilizes a search heuristic to bypass the $O(n^3)$ complexity of traditional NJ, making it suitable for large-scale phylogenetic reconstruction on standard desktop hardware. It can estimate distances directly from alignments or process pre-computed distance matrices.

## Usage Guidelines

### Input Formats
RapidNJ automatically attempts to detect the input format, but explicit flags are recommended for reliability:
- **Distance Matrices**: Full (squared) matrices in PHYLIP format.
- **Alignments**: Stockholm (.sth) or PHYLIP formatted multiple sequence alignments.

### Common CLI Patterns

**Infer a tree from a Stockholm alignment:**
```bash
rapidnj input.sth -i sth > output.tre
```

**Infer a tree from a PHYLIP distance matrix:**
```bash
rapidnj matrix.phy -i pd > output.tre
```

**Specifying the number of CPU cores:**
To leverage multi-core processors for distance estimation and tree construction:
```bash
rapidnj input.sth -c <number_of_cores>
```

### Algorithm Selection
While RapidNJ automatically switches algorithms based on dataset size and available RAM, you can force specific behaviors:
- `-m`: Use the memory-efficient version of the algorithm.
- `-x`: Enable external memory (disk-based) processing for extremely large datasets that exceed physical RAM.

### Expert Tips
- **Large Datasets**: For datasets exceeding 50,000 taxa, always ensure sufficient disk space if using the `-x` (external memory) flag, as swap files can become large.
- **Distance Estimation**: When providing alignments, RapidNJ calculates distance estimators internally. For protein sequences, ensure the input is in a format that allows the tool to correctly identify the amino acid alphabet.
- **Output**: The tool outputs the resulting tree in Newick format to `stdout` by default. Always redirect to a file or pipe to a tree viewer like FigTree or NWK-utils.

## Reference documentation
- [RapidNJ Software Page](./references/birc_au_dk_software_rapidnj.md)
- [Bioconda RapidNJ Package Overview](./references/anaconda_org_channels_bioconda_packages_rapidnj_overview.md)