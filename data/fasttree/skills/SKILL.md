---
name: fasttree
description: FastTree is a specialized tool designed for high-throughput phylogenetics.
homepage: https://morgannprice.github.io/fasttree
---

# fasttree

## Overview

FastTree is a specialized tool designed for high-throughput phylogenetics. It infers approximately-maximum-likelihood trees by combining heuristic neighbor-joining, minimum evolution rearrangements, and maximum likelihood profile-based moves. It is significantly faster than standard ML tools while maintaining comparable accuracy, making it the standard choice for massive genomic datasets.

## Common CLI Patterns

### Basic Usage
FastTree automatically detects protein sequences. For nucleotide sequences, the `-nt` flag is mandatory.

*   **Protein Alignment:**
    `fasttree alignment.fasta > tree.nwk`
*   **Nucleotide Alignment:**
    `fasttree -nt alignment.fasta > tree.nwk`

### Evolutionary Models
*   **Nucleotides:** Default is Jukes-Cantor. Use `-gtr` for the Generalized Time-Reversible model.
    `fasttree -nt -gtr < alignment.fasta > tree.nwk`
*   **Proteins:** Default is JTT (Jones-Taylor-Thornton). Use `-wag` or `-lg` for Whelan-Goldman or Le-Gascuel models.
    `fasttree -lg alignment.fasta > tree.nwk`

### Performance and Parallelization
If the multi-threaded version (`FastTreeMP`) is installed, use the `OMP_NUM_THREADS` environment variable to control CPU usage.

```bash
export OMP_NUM_THREADS=8
FastTreeMP -nt alignment.fasta > tree.nwk
```

### Handling Large Datasets
For alignments with >50,000 sequences, use the `-fastest` flag to speed up the neighbor-joining phase and reduce the number of local searches.

`fasttree -nt -fastest alignment.fasta > tree.nwk`

## Expert Tips

*   **Branch Support:** FastTree provides SH-like (Shimodaira-Hasegawa) local support values by default. These are visible as node labels in the resulting Newick file.
*   **Gamma Distribution:** FastTree uses the "CAT" approximation (20 discrete rates) for speed. To obtain more accurate branch lengths and likelihoods after the tree topology is fixed, you can re-run with the `-gamma` flag.
*   **Input Formats:** While FASTA is common, FastTree also accepts interleaved Phylip format.
*   **Bootstrapping:** For traditional bootstrapping, use a tool like `seqboot` to generate multiple alignments, then run FastTree with the `-n` flag:
    `fasttree -nt -n 100 bootstrapped_alignments.fasta > trees.nwk`
*   **Constraints:** If you have a starting topology, use `-intree` to provide a Newick file as a starting point for optimization.

## Reference documentation
- [FastTree 2.2: Approximately-Maximum-Likelihood Trees for Large Alignments](./references/morgannprice_github_io_fasttree.md)
- [FastTree Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fasttree_overview.md)