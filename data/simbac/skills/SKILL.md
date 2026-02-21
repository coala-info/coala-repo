---
name: simbac
description: SimBac is a coalescent-based simulator designed specifically for bacterial genomes.
homepage: https://github.com/tbrown91/SimBac
---

# simbac

## Overview
SimBac is a coalescent-based simulator designed specifically for bacterial genomes. It models the clonal genealogy of a population while incorporating both internal (within-species) and external (between-species) recombination events. This allows for the generation of realistic genomic data that reflects the mosaic nature of bacterial evolution, providing not just the final sequences but also the underlying tree structures and recombination logs.

## Installation
The most efficient way to install SimBac is via Bioconda:
```bash
conda install bioconda::simbac
```

## Command Line Usage

### Basic Simulation
To simulate a standard population (e.g., 100 isolates, 1Mbp genome, standard mutation and recombination rates):
```bash
SimBac -N 100 -B 1000000 -R 0.01 -T 0.01 -o output.fasta -c clonal_frame.nwk
```

### Key Parameters
- `-N [INT]`: Number of isolates (default: 100).
- `-B [INT]`: Genome length or fragment lengths (default: 10000).
- `-T [FLOAT]`: Site-specific mutation rate $\theta$ (default: 0.01).
- `-R [FLOAT]`: Internal recombination rate $R_i$ (default: 0.01).
- `-D [INT]`: Average length of internal recombinant intervals $\delta_i$ (default: 500).
- `-r [FLOAT]`: External recombination rate $R_e$ (default: 0).
- `-e [INT]`: Average length of external recombinant intervals $\delta_e$ (default: 500).

### Modeling Linear Genomes
By default, SimBac approximates circular-like behavior. To simulate a linear genome, use the `-G` flag to place a large gap at the end of the ancestral block, preventing recombination events from wrapping around the start and end of the sequence:
```bash
# 100kbp linear genome with a 1Mbp gap
SimBac -N 100 -B 100000 -G 1000000 -o genomes.fasta -c clonal_frame.nwk
```

### Tracking Recombination and Ancestry
SimBac provides detailed logs of the evolutionary process:
- **Local Trees**: Use `-l [FILE]` to output the specific tree for each non-recombined block in Newick format.
- **Recombination Intervals**: Use `-b` (internal) and `-f` (external) to log the locations of recombinant segments.
- **ARG Visualization**: Use `-d [FILE].dot` to export the Ancestral Recombination Graph.
  - **Note**: Use the `-a` flag to include ancestral material in the DOT graph.
  - **Warning**: DOT file generation is only recommended for small populations or short sequences due to complexity.

## Best Practices
- **Mutation Divergence**: When modeling external recombination, use `-m` and `-M` to set the lower and upper bounds of site-mutation (divergence) for the incoming external DNA.
- **Reproducibility**: Always specify a seed using `-s [INT]` to ensure simulations can be replicated.
- **Fragmented Genomes**: You can simulate multiple genomic fragments by providing a comma-separated list to `-B` (e.g., `-B 5000,3000,2000`). If you do this, you must provide a matching number of gap sizes using `-G`.

## Reference documentation
- [SimBac GitHub Repository](./references/github_com_tbrown91_SimBac.md)
- [Bioconda SimBac Overview](./references/anaconda_org_channels_bioconda_packages_simbac_overview.md)