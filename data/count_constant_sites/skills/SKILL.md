---
name: count_constant_sites
description: This tool counts the number of constant nucleotide sites in a FASTA-formatted multiple sequence alignment. Use when user asks to count constant A, C, G, and T sites or provide constant site counts for phylogenetic tree reconstruction tools like IQ-TREE.
homepage: https://github.com/pvanheus/count_constant_sites
metadata:
  docker_image: "quay.io/biocontainers/count_constant_sites:0.1.1--0"
---

# count_constant_sites

## Overview
The `count_constant_sites` tool processes a nucleotide Multiple Sequence Alignment (MSA) in FASTA format to identify columns that are entirely constant (containing only one type of nucleotide across all sequences). It outputs four comma-separated integers representing the total counts of constant A, C, G, and T sites. This utility is essential for phylogenetic workflows where constant sites were previously removed from the alignment, but their counts are needed to correct for sampling bias during tree reconstruction.

## Usage and Best Practices

### Basic Command
The tool typically takes a FASTA alignment file as its primary argument:

```bash
count_constant_sites input_alignment.fasta
```

### Integration with IQ-TREE
The primary use case for this tool is generating the string required for the `-fconst` flag in IQ-TREE. You can capture the output directly in a command substitution:

```bash
# Example of passing counts directly to IQ-TREE
iqtree -s input_alignment.fasta -fconst $(count_constant_sites input_alignment.fasta) -m GTR+G
```

### Tool Behavior and Constraints
- **Nucleotide Focus**: The tool is designed for nucleotide alignments. It counts four specific bases: Adenine (A), Cytosine (C), Guanine (G), and Thymine (T).
- **Constant Site Definition**: A site is considered constant only if the entire column in the alignment consists of the same nucleotide.
- **Handling Gaps and Ambiguity**: Gaps (`-`) and ambiguous nucleotides (e.g., `N`, `R`, `Y`) are not considered constant sites and are ignored by the counting logic.
- **Case Sensitivity**: The tool is case-insensitive; it will treat `a` and `A` as the same character.
- **Input Format**: Ensure the input file is a valid Multiple Sequence Alignment (MSA) where all sequences are of equal length.

## Reference documentation
- [count_constant_sites - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_count_constant_sites_overview.md)
- [pvanheus/count_constant_sites: GitHub Repository](./references/github_com_pvanheus_count_constant_sites.md)