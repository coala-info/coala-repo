---
name: amap
description: AMAP (Alignment by Sequence Annealing) is a specialized tool for multiple sequence alignment that utilizes a sequence annealing algorithm.
homepage: https://web.archive.org/web/20060902044446/http://bio.math.berkeley.edu/amap/
---

# amap

## Overview
AMAP (Alignment by Sequence Annealing) is a specialized tool for multiple sequence alignment that utilizes a sequence annealing algorithm. Unlike traditional progressive alignment methods that can be sensitive to the order in which sequences are added, AMAP focuses on a probabilistic framework to reduce the expected distance between the predicted and true alignments. It is particularly useful for researchers seeking high-accuracy alignments where traditional tools like ClustalW or Muscle may struggle with specific sequence motifs or divergent sequences.

## Usage Patterns

### Basic Alignment
To perform a standard multiple sequence alignment with default parameters:
```bash
amap [input_sequences.fasta] > [output_alignment.aln]
```

### Common CLI Options
- `-query`: Specify the input file in FASTA format.
- `-outfmt`: Define the output format (e.g., CLUSTAL, FASTA).
- `-gapopen`: Adjust the gap opening penalty to control alignment stringency.
- `-gapextend`: Adjust the gap extension penalty.
- `-nuc`: Force the tool to treat sequences as nucleotides.
- `-prot`: Force the tool to treat sequences as proteins (default behavior usually detects this).

### Expert Tips
- **Sequence Annealing**: AMAP is unique because it does not use a guide tree in the same way progressive aligners do. If your sequences have complex evolutionary relationships, AMAP's annealing approach may provide a more robust topology-independent alignment.
- **Memory Management**: For very large datasets, monitor memory usage as the sequence annealing process can be computationally intensive compared to simple progressive methods.
- **Refinement**: AMAP is often used as a high-accuracy alternative when initial alignments from faster tools show obvious misalignments in conserved regions.

## Reference documentation
- [amap Overview](./references/anaconda_org_channels_bioconda_packages_amap_overview.md)