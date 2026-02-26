---
name: sword
description: "SWORD performs protein sequence alignment using a heuristic filter followed by an optimal Smith-Waterman phase. Use when user asks to search a query sequence against a protein database, perform sensitive protein alignment, or use the Smith-Waterman algorithm on a reduced database."
homepage: https://github.com/rvaser/sword
---


# sword

## Overview
SWORD (Smith Waterman On Reduced Database) is a specialized tool designed for protein sequence alignment. It operates using a two-phase approach: a heuristic step that filters the database to identify the most relevant sequences, followed by an optimal alignment phase using the OPAL library. This design allows it to maintain high sensitivity while significantly increasing search speeds compared to traditional Smith-Waterman implementations.

## CLI Usage and Best Practices

### Basic Search
The primary function of SWORD is to search a query sequence against a protein database. Both files should be in FASTA format.

```bash
sword -i <query.fasta> -j <database.fasta>
```

### Performance and Hardware
- **Multithreading**: SWORD is designed to utilize multithreading. When running large batches, ensure your environment provides sufficient CPU cores to take advantage of the parallelized alignment phase.
- **Instruction Sets**: The tool requires SSE4.1 or higher. It will not run on older hardware that lacks these SIMD instructions.
- **Memory Management**: Because SWORD performs optimal alignment on a reduced set of sequences, it is generally more memory-efficient than full-matrix Smith-Waterman tools, but performance scales with available RAM when handling massive databases.

### Configuration and Help
To view the full list of parameters, including heuristic thresholds and threading options, use the help command:

```bash
sword -h
# or
sword --help
```

## Installation
The most reliable way to deploy SWORD is via Bioconda:

```bash
conda install bioconda::sword
```

## Reference documentation
- [SWORD GitHub Repository](./references/github_com_rvaser_sword.md)
- [Bioconda SWORD Overview](./references/anaconda_org_channels_bioconda_packages_sword_overview.md)