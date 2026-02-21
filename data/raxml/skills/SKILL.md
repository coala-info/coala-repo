---
name: raxml
description: RAxML is a high-performance tool designed for phylogenetic tree inference under the Maximum Likelihood (ML) criterion.
homepage: http://sco.h-its.org/exelixis/web/software/raxml/index.html
---

# raxml

## Overview
RAxML is a high-performance tool designed for phylogenetic tree inference under the Maximum Likelihood (ML) criterion. It is particularly optimized for large datasets, offering a balance between computational efficiency and tree search thoroughness. This skill provides the necessary command-line patterns to execute standard workflows, including rapid bootstrapping, model selection, and memory estimation.

## Core CLI Patterns

### Standard ML Tree Search
To find the best-scoring ML tree for a DNA alignment:
`raxmlHPC -m GTRGAMMA -p 12345 -s input.phy -n result_name`

- `-m`: Substitution model (e.g., `GTRGAMMA` for DNA, `PROTGAMMAWAG` for Protein).
- `-p`: Random number seed for parsimony starting trees.
- `-s`: Input alignment in PHYLIP format.
- `-n`: Suffix for output files.

### Rapid Bootstrapping and Best ML Tree
To perform a complete analysis (ML search + bootstrapping) in a single run:
`raxmlHPC -f a -m GTRGAMMA -p 12345 -x 12345 -# 100 -s input.phy -n analysis`

- `-f a`: Rapid Bootstrap analysis and search for the best-scoring ML tree in one program run.
- `-x`: Rapid bootstrap random number seed.
- `-#`: Number of bootstrap replicates (or use `autoMRE` for convergence criteria).

### Working with Partitions
For multi-gene alignments, define partitions in a separate file (e.g., `partitions.txt`):
`DNA, gene1 = 1-500`
`DNA, gene2 = 501-1000`

Execute using the `-q` flag:
`raxmlHPC -m GTRGAMMA -p 12345 -q partitions.txt -s input.phy -n partitioned_run`

## Expert Tips & Best Practices

### Memory Estimation
Before running large datasets, estimate memory requirements to avoid crashes.
- **DNA + GAMMA**: `(taxa - 2) * patterns * 128 bytes`
- **AA + GAMMA**: `(taxa - 2) * patterns * 640 bytes`
*Note: "patterns" refers to the number of distinct site patterns, not the total alignment length.*

### Executable Selection
RAxML comes in different versions depending on your hardware:
- `raxmlHPC`: Standard sequential version.
- `raxmlHPC-PTHREADS`: Use for multi-core machines (specify threads with `-T`).
- `raxmlHPC-MPI`: Use for distributed computing clusters.

### Model Selection
- For Protein data, use the `ProteinModelSelection.pl` script or the `-m PROTGAMMAAUTO` flag to let RAxML automatically determine the best-fit substitution model (WAG, LG, JTT, etc.).
- Use `GAMMA` models over `CAT` for datasets with fewer than 500 taxa to ensure stable likelihood values.

### Convergence Criteria
Instead of guessing the number of bootstrap replicates, use the bootstopping criteria:
`raxmlHPC -f a -m GTRGAMMA -p 12345 -x 12345 -# autoMRE -s input.phy -n convergence_test`

## Reference documentation
- [RAxML Web Home and Documentation](./references/cme_h-its_org_exelixis_web_software_raxml_index.html.md)
- [Bioconda RAxML Package Overview](./references/anaconda_org_channels_bioconda_packages_raxml_overview.md)