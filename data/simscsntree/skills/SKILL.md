---
name: simscsntree
description: SimSCSnTree is a specialized simulation framework designed to produce realistic single-cell DNA sequencing datasets.
homepage: https://github.com/compbiofan/SimSCSnTree
---

# simscsntree

## Overview

SimSCSnTree is a specialized simulation framework designed to produce realistic single-cell DNA sequencing datasets. It functions through a two-step process: first, it constructs a phylogenetic tree where genomic variations (CNAs and SNVs) are assigned to edges; second, it simulates the sequencing of reads from the genomes of selected nodes. This tool is essential for benchmarking single-cell variant callers and phylogenetic reconstruction algorithms by providing a known ground truth for clonal evolution and technical artifacts.

## Installation and Setup

Install the package via BioConda to automatically manage dependencies like `numpy` and `anytree`:

```bash
conda install bioconda::simscsntree
```

If using the BioConda installation, invoke the tool using `python -m SimSCSnTree`. If running from a cloned repository, use the script names directly (e.g., `python main.par.overlapping.py`).

## Step 1: Tree and Variation Generation

Generate the phylogenetic tree and impute variations using `main.par.overlapping.py`. This step produces `.npy` files containing the tree structure and variation data.

### Core Parameters
- `-r, --directory`: Output directory for simulated data (will be overwritten if it exists).
- `-t, --template-ref`: Path to the reference genome (e.g., `hg19.fa`).
- `-n, --cell-num`: Total number of cells to sequence.
- `-F`: Mean number of subclones (tree width).
- `-G`: Mean tree depth.

### Controlling Tree Topology
The simulator uses a Beta-splitting model to determine how branches split.
- **Balanced Trees**: Set `-A` (Alpha) and `-B` (Beta) to similar values (e.g., `0.5`).
- **Unbalanced Trees**: Set `-A` and `-B` to disparate values within the `[0, 1]` range.
- **Fixed Width**: Set `-H` (standard deviation of width) to a very small value like `0.0001` to ensure the tree has exactly the number of subclones specified by `-F`.

## Step 2: Read Sampling

Once the tree is generated, sample reads to mimic specific sequencing technologies or biological scenarios.

### Common Simulation Scenarios
- **DOP-PCR/MALBAC**: Simulate the read depth fluctuations characteristic of these single-cell amplification methods.
- **Bulk Sequencing**: Simulate bulk data by sampling from multiple nodes to represent a mixed population.
- **Clonal Populations**: Group cells into clones by sampling multiple cells from the same leaf nodes.

## Best Practices and Expert Tips

- **Reference Genome**: Ensure the reference FASTA file is accessible. The tool handles non-human genomes by calculating coverage based on the provided reference size rather than hard-coded values.
- **Tree Depth Constraints**: Avoid setting the mean depth (`-G`) to more than twice the tree width (`-F`), as this may prevent the tree from reaching the desired depth.
- **Parallelization**: Use the `-p` flag to specify the number of processes for parallelized cell sequencing, which significantly reduces runtime for large datasets.
- **Ground Truth Extraction**:
    - Use `read_tree.py` to convert the internal `.npy` format to a standard Newick tree string.
    - Extract CNA and SNV lists from the output directory to use as the gold standard for evaluation.

## Reference documentation
- [SimSCSnTree BioConda Overview](./references/anaconda_org_channels_bioconda_packages_simscsntree_overview.md)
- [SimSCSnTree GitHub Documentation](./references/github_com_compbiofan_SimSCSnTree.md)