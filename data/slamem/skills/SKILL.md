---
name: slamem
description: slamem identifies long exact matches between genomic datasets using a memory-efficient FM-Index and specialized search structures. Use when user asks to find maximal exact matches, identify maximal almost matches, or generate visual maps of genomic similarities between sequences.
homepage: https://github.com/sguizard/slaMEM
metadata:
  docker_image: "quay.io/biocontainers/slamem:v0.8.5--h779adbc_0"
---

# slamem

## Overview
The `slamem` tool is a high-performance sequence analysis utility designed to identify long exact matches between genomic datasets. By utilizing an FM-Index and a specialized Sampled Search Intervals from Longest Common Prefixes (SSI LCP) structure, it provides a memory-efficient alternative to traditional suffix tree-based methods. Use this skill to configure match parameters, handle double-stranded searches, and generate visual maps of genomic similarities.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::slamem
```

## Command Line Usage
The basic syntax requires a reference file and one or more query files:
```bash
slamem [options] <reference.fasta> <query.fasta>
```

### Core Search Modes
*   **MEM (Default):** Finds all Maximal Exact Matches regardless of frequency in the reference or query.
*   **MAM:** Finds Maximal Almost Matches that are unique in the reference but can appear any number of times in the query.

### Common Options
*   `-l <int>`: Set the minimum match length (default is 20). Increase this to reduce noise in highly repetitive genomes.
*   `-b`: Search both forward and reverse strands of the sequences.
*   `-n`: Filter out 'N' characters to prevent them from being treated as valid matches.
*   `-o <string>`: Specify a custom output filename (default follows the pattern `*-mems.txt`).
*   `-m <int>`: Set a minimum sequence size to ignore small scaffolds or fragments in the input files.
*   `-r <string>`: Load only reference sequences whose headers contain the specified string.

## Visualizing Matches
`slamem` includes a built-in feature to generate a MEMs map image, which provides a graphical representation of match locations.
```bash
slamem -v <mems_output.txt> <reference.fasta> <query.fasta>
```

## Expert Tips
*   **Memory Efficiency:** Because `slamem` uses a sampled LCP array, it is often more suitable for large reference genomes than tools requiring a full suffix array.
*   **Preprocessing:** Ensure your input files are in standard FASTA format. If working with many small query sequences, the `-m` flag is essential to avoid processing overhead on non-informative fragments.
*   **Strand Specificity:** When analyzing RNA-seq data or specific genomic features, omit the `-b` flag if you only care about the coding strand orientation.

## Reference documentation
- [github_com_sguizard_slaMEM.md](./references/github_com_sguizard_slaMEM.md)
- [anaconda_org_channels_bioconda_packages_slamem_overview.md](./references/anaconda_org_channels_bioconda_packages_slamem_overview.md)