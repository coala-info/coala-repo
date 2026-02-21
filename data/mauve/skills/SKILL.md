---
name: mauve
description: Mauve is a specialized bioinformatics tool designed for the global alignment of multiple genomes that have undergone significant structural changes.
homepage: http://darlinglab.org/mauve/
---

# mauve

## Overview
Mauve is a specialized bioinformatics tool designed for the global alignment of multiple genomes that have undergone significant structural changes. Unlike traditional aligners that assume linear conservation, Mauve identifies "Locally Collinear Blocks" (LCBs)—regions of the genome that are internally free from rearrangements—and maps their positions across all input sequences. This makes it essential for studying genome evolution, identifying horizontal gene transfer, and visualizing chromosomal shuffling.

## Usage Guidelines

### Core Command Line Interface
The primary engine for Mauve is `progressiveMauve`. This version is preferred over the original `Mauve` aligner as it handles genomes with varying degrees of sequence identity and different rates of rearrangement more effectively.

**Basic Alignment Syntax:**
```bash
progressiveMauve --output=my_alignment.xmfa genome1.gbk genome2.gbk genome3.fasta
```

### Key Parameters and Best Practices
- **Input Formats**: Use GenBank (.gbk) files instead of FASTA when possible. Mauve can extract gene annotations from GenBank files, which allows the alignment to be viewed in the context of genomic features.
- **Output Files**: 
    - `.xmfa`: The standard eXtended Multi-FastA format containing the alignment.
    - `.backbone`: Defines the segments conserved among all genomes.
    - `.guide_tree`: The phylogenetic tree used to guide the progressive alignment.
- **Handling Rearrangements**: If the genomes are highly rearranged, ensure you are using `progressiveMauve` rather than the legacy `mauveAligner`, as the latter assumes a fixed order of LCBs.
- **Memory Management**: For large eukaryotic genomes, use the `--seeded-guide-trees` flag to reduce memory consumption during the initial distance calculation phase.

### Expert Tips
- **Seed Weight**: If aligning very divergent genomes, you can manually adjust the `--seed-weight` parameter. Lowering the weight can increase sensitivity but will significantly increase computation time and noise.
- **Consistency**: When comparing multiple strains of the same species, use a consistent reference genome as the first input file to simplify the interpretation of the resulting LCB coordinates.
- **Visualization**: While the CLI performs the computation, the resulting `.xmfa` file is best inspected using the Mauve GUI viewer to identify specific inversion breakpoints and insertions.

## Reference documentation
- [Mauve Overview](./references/anaconda_org_channels_bioconda_packages_mauve_overview.md)