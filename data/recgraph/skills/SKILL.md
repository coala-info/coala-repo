---
name: recgraph
description: RecGraph is a high-performance sequence-to-graph aligner written in Rust.
homepage: https://github.com/AlgoLab/RecGraph
---

# recgraph

## Overview
RecGraph is a high-performance sequence-to-graph aligner written in Rust. Unlike many heuristic-based aligners, RecGraph implements an exact dynamic programming algorithm to find optimal alignments between a query string and a variation graph. Its most distinctive capability is "recombination mode," which allows the aligner to find optimal paths through the graph that are not explicitly represented in the input pangenome, effectively modeling genetic recombinations.

## Installation and Setup
RecGraph can be accessed via multiple methods. The bioconda package is the most common for bioinformatics workflows.

*   **Conda**: `conda install -c bioconda recgraph`
*   **Docker**: `docker pull algolab/recgraph`
*   **Cargo**: `cargo install --git https://github.com/AlgoLab/RecGraph`

## Command Line Usage
The basic syntax requires a FASTA file of reads and a GFA file of the variation graph. Output is redirected to a GAF (Graph Alignment Format) file.

```bash
recgraph [options] <reads.fa> <graph.gfa> > <alignments.gaf>
```

### Alignment Modes (-m)
Selecting the correct mode is critical for the desired biological context:
*   **Standard POA (Partial Order Alignment)**:
    *   `-m 0`: Global alignment.
    *   `-m 1`: Local alignment.
    *   `-m 2`: Global alignment with affine gap penalties.
    *   `-m 3`: Local alignment with affine gap penalties.
*   **Pathwise Mode** (Aligns strictly to existing paths in the graph):
    *   `-m 4`: Global pathwise alignment.
    *   `-m 5`: Semiglobal pathwise alignment.
*   **Recombination Mode** (Allows weighted recombinations between paths):
    *   `-m 8`: Global recombination alignment.
    *   `-m 9`: Semiglobal recombination alignment.

### Scoring Parameters
Fine-tune the alignment sensitivity using the following flags:
*   `-M, --match <INT>`: Match score (default: 2).
*   `-X, --mismatch <INT>`: Mismatch penalty (default: 4).
*   `-O, --gap-open <INT>`: Gap opening penalty (default: 4).
*   `-E, --gap-ext <INT>`: Gap extension penalty (default: 2).
*   `-t, --matrix <FILE>`: Use a custom scoring matrix file (overrides -M and -X).

### Recombination Tuning
When using modes 8 or 9, recombination costs are calculated as `R + r * (displacement_length)`:
*   `-R, --base-rec-cost <FLOAT>`: Base cost for a recombination event (default: 4).
*   `-r, --multi-rec-cost <FLOAT>`: Multiplier for the displacement length (default: 0.1).
*   `-B, --rec-band-width <INT>`: Band width for recombination search (default: 1).

### Performance Optimization (Banding)
For long sequences or large graphs, use adaptive banding to reduce computation time:
*   `-b, --extra-b <INT>`: First adaptive banding parameter. Set < 0 to disable (default: 1).
*   `-f, --extra-f <FLOAT>`: Second adaptive banding parameter. Adds `b + f * L` bases to the band, where L is sequence length (default: 0.01).

## Expert Tips
*   **Output Interpretation**: RecGraph outputs in GAF format. If using recombination modes, the GAF path may represent a synthetic path created by the recombination logic.
*   **Memory Management**: For very large pangenome graphs, ensure the system has sufficient RAM as RecGraph performs exact DP, which is more memory-intensive than heuristic seed-and-extend methods.
*   **Experimental Features**: Modes `-m 6` and `-m 7` provide affine gap penalties in pathwise mode but are currently experimental and should be used with caution.

## Reference documentation
- [RecGraph GitHub Repository](./references/github_com_AlgoLab_RecGraph.md)
- [Bioconda RecGraph Package](./references/anaconda_org_channels_bioconda_packages_recgraph_overview.md)