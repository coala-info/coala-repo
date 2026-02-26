---
name: phyx
description: Phyx is a suite of command-line tools for performing modular phylogenetic operations and sequence alignment manipulations. Use when user asks to concatenate alignments, convert phylogenetic file formats, reroot trees, or translate nucleotide sequences.
homepage: https://github.com/FePhyFoFum/phyx
---


# phyx

## Overview

`phyx` is a comprehensive suite of C++ command-line tools designed for phylogenetic procedures. Following the Unix philosophy of "one tool, one task," it provides modular programs that communicate via standard input and output. This allows for the construction of complex bioinformatics pipelines by chaining simple commands. The toolkit excels at sequence alignment manipulation (concatenation, cleaning, translation), tree operations (rerooting, pruning, NJ/UPGMA inference), and seamless conversion between common phylogenetic file formats.

## Core CLI Usage and Patterns

### General Syntax
Most `phyx` tools follow a standard naming convention starting with `px`. You can access help for any specific tool using the `-h` flag:
```bash
pxcat -h
```

### Chaining Commands (Piping)
The primary strength of `phyx` is its ability to pipe data between tools.
*   **Example: Clean an alignment and then convert it to Phylip format:**
    ```bash
    pxclsq -s alignment.fa -p 0.2 | pxs2phy > cleaned_alignment.phy
    ```

### Common Sequence Operations
*   **Concatenation**: Combine multiple alignments using `pxcat`.
    ```bash
    pxcat -s seq1.fa seq2.fa seq3.fa -o combined.fa
    ```
*   **Cleaning**: Remove sites with high missing data using `pxclsq`.
*   **Translation**: Convert nucleotide sequences to amino acids with `pxtlate`.
*   **Reverse Complement**: Use `pxrevcomp` for quick sequence orientation fixes.

### Common Tree Operations
*   **Inference**: Generate quick trees using Neighbor-Joining (`pxnj`) or UPGMA (`pxupgma`).
*   **Rerooting**: Reroot a tree file using `pxrr`.
*   **Pruning**: Remove specific taxa from a tree using `pxrmt`.
*   **Subtree Extraction**: Extract an induced subtree from a larger phylogeny using `pxtrt`.

### Format Conversion
`phyx` provides dedicated tools to move between Fasta, Nexus, and Phylip:
*   `pxs2fa`: Convert to Fasta.
*   `pxs2nex`: Convert to Nexus.
*   `pxs2phy`: Convert to Phylip.
*   `pxt2new`: Convert a tree to Newick format.

## Expert Tips and Best Practices

### Handling "Illegal" Characters
Phylogenetic file formats (Nexus/Newick) have strict rules about taxon names. Characters like `()[]{}/,;:=*'"+-<>` can cause programs to crash or truncate results.
*   **Solution**: Wrap taxon names containing these characters in single or double quotes within your input files.

### Line Ending Consistency
`phyx` is designed for Unix environments and expects Unix line endings (`\n`).
*   If your data originated on Windows, use `dos2unix` to convert the files before processing to prevent piping errors or unexpected crashes.

### Data Integrity
*   **Compositional Homogeneity**: Use `pxcomp` to test if your sequence data meets the stationarity assumptions required by many phylogenetic models.
*   **Bipartition Analysis**: Use `pxbp` to summarize bipartitions and support values from a set of trees (e.g., from a bootstrap or MCMC run).

### Resource Efficiency
Because `phyx` tools are written in C++ and focus on specific tasks, they are generally more memory-efficient than monolithic alternatives. When working with extremely large alignments, prefer piping (`|`) over writing intermediate files to disk to reduce I/O overhead.

## Reference documentation
- [Phyx GitHub Repository](./references/github_com_FePhyFoFum_phyx.md)
- [Phyx Wiki Home](./references/github_com_FePhyFoFum_phyx_wiki.md)