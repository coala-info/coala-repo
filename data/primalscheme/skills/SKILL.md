---
name: primalscheme
description: Primalscheme automates the design of tiled primer sets for multiplex PCR to enable whole-genome sequencing and viral surveillance. Use when user asks to design multiplex primer schemes, create tiled amplicons for viral sequencing, or generate conserved primers from a multi-sequence alignment.
homepage: https://github.com/aresti/primalscheme
---


# primalscheme

## Overview

`primalscheme` is a specialized bioinformatics tool that automates the design of primer sets for multiplex PCR, primarily used in viral surveillance and whole-genome sequencing. It employs a greedy algorithm to find optimal primer pairs that generate tiled amplicons across a target genome. By providing a multi-sequence FASTA alignment, the tool ensures that the designed primers are conserved across all provided reference strains while minimizing primer-primer interactions (dimers) that typically plague multiplex reactions.

## Installation

The tool can be installed via Conda or Pip:

```bash
# Via Bioconda (Recommended)
conda install bioconda::primalscheme

# Via Pip
pip install primalscheme
```

## Core Usage Patterns

### Basic Multiplex Design
To design a standard scheme using default parameters (amplicon size ~400bp):
```bash
primalscheme multiplex input_alignment.fasta
```

### Customizing Amplicon Size
For specific sequencing platforms (e.g., shorter reads for Illumina or longer for Nanopore), define an exact range by passing the `-a` flag twice:
```bash
# Design for 250-300bp amplicons
primalscheme multiplex input.fasta -a 250 -a 300 -n my_virus_scheme
```

### Handling High-GC Content
If working with high-GC viral genomes, use the optimized configuration flag:
```bash
primalscheme multiplex input.fasta --high-gc -o ./high_gc_output
```

### Pinned Reference Mode
To force the tool to only consider primer sites present in your primary reference (the first sequence in the FASTA), use the pinned flag:
```bash
primalscheme multiplex input.fasta --pinned
```

## Expert Workflow & Best Practices

### 1. Input Preparation
*   **Alignment is Mandatory**: Input FASTA files must be pre-aligned (e.g., using Clustal Omega or MAFFT). Primers are only designed within the limits of the alignment.
*   **Coordinate System**: The first sequence in your FASTA file is the "Primary Reference." All coordinates in the output `.bed` and `.tsv` files will be relative to this sequence.
*   **Sequence Divergence**: Ensure maximum sequence divergence among inputs is < 5%. If divergence is higher, split the sequences into independent schemes.
*   **Redundancy**: Remove sequences with 99-100% identity to others in the file to prevent bias in primer selection.

### 2. Interpreting Outputs
The tool generates several critical files in the output directory:
*   `{name}.primer.tsv`: The master list of primer sequences, melting temperatures (Tm), and GC content.
*   `{name}.primer.bed`: Primer coordinates for use in downstream bioinformatic pipelines (e.g., for primer trimming).
*   `{name}.report.json`: Contains a summary of the run, including any gaps in coverage where the algorithm failed to find suitable primers.
*   `{name}.plot.pdf/svg`: A visual representation of the tiling scheme and amplicon overlaps.

### 3. Troubleshooting Gaps
If the report indicates gaps in coverage:
1.  Check the alignment for high-variability regions or Ns in the reference sequences.
2.  Try increasing the amplicon size range to give the algorithm more flexibility.
3.  Adjust the `--target-overlap` (default 0) to a positive value to force deeper overlaps between adjacent amplicons.

## Reference documentation
- [primalscheme GitHub Repository](./references/github_com_aresti_primalscheme.md)
- [primalscheme Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_primalscheme_overview.md)