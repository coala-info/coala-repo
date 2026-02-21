---
name: phyling
description: Phyling is a specialized tool designed for fast and scalable phylogenomic inference.
homepage: https://github.com/stajichlab/Phyling
---

# phyling

## Overview

Phyling is a specialized tool designed for fast and scalable phylogenomic inference. It streamlines the process of moving from annotated genomes to a species tree by identifying single-copy orthologs through Hidden Markov Model (HMM) searches against standardized marker sets. The tool is modular, allowing for flexible workflows that include marker acquisition, sequence alignment, quality filtering, and final tree reconstruction.

## Core Workflow

### 1. Marker Set Management
Before aligning sequences, you must obtain a relevant HMM marker set (typically from BUSCO).

- **List available sets**: Use `phyling download list` to see both online and locally cached datasets.
- **Download a set**: Use `phyling download [markerset_name]` (e.g., `fungi_odb10`).
- **Update markers**: Rerun the download command for a specific set to check for and install updates.

### 2. Ortholog Identification and Alignment
The `align` module performs HMM searches to find orthologs and then aligns them.

- **Basic alignment**: `phyling align -I [input_directory] -m [markerset_directory] -o [output_name]`
- **Input types**: Provide peptide sequences (.aa) or DNA coding sequences (.cds). If DNA is provided, Phyling translates to protein for alignment and back-translates for the final result.
- **Alignment methods**: The default is `hmmalign`. Use `-M muscle` if you prefer the MUSCLE algorithm.
- **Performance**: Use `-t [threads]` to parallelize. For more than 8 threads, use multiples of 4 to optimize the `pyhmmer` search performance.

### 3. Tree Construction
Once alignments are generated, use the `tree` module to build the phylogeny.

- **Concatenation**: Combines all markers into a single supermatrix to build one tree.
- **Consensus**: Builds individual trees for each marker and then generates a consensus species tree.

## Expert Tips and Best Practices

- **Sample Minimum**: Ensure you have at least 4 samples; this is the hard minimum required by Phyling to generate a valid tree.
- **Closely Related Species**: When working with very closely related taxa, provide DNA coding sequences (CDS) as input. The back-translation feature preserves nucleotide-level signal which may be lost in pure protein alignments.
- **Bitscore Cutoffs**: Phyling looks for a bitscore cutoff file within the HMM folder. If missing, it defaults to an E-value threshold (default 1e-10). You can adjust this with `-E [float]`.
- **Filtering**: Use the `filter` module before tree building to remove low-quality alignments based on treeness or RCV (Relative Composition Variability) scores.
- **Storage**: By default, markers are saved to `~/.phyling`. You can override this by setting the `$PHYLING_DB` environment variable.

## Reference documentation
- [Phyling GitHub Repository](./references/github_com_stajichlab_Phyling.md)
- [Phyling Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phyling_overview.md)