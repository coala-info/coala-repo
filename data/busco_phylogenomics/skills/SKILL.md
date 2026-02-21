---
name: busco_phylogenomics
description: The `busco_phylogenomics` tool streamlines the transition from genomic quality assessment to evolutionary analysis.
homepage: https://github.com/jamiemcg/BUSCO_phylogenomics
---

# busco_phylogenomics

## Overview
The `busco_phylogenomics` tool streamlines the transition from genomic quality assessment to evolutionary analysis. It automates the identification of complete, single-copy orthologs across multiple BUSCO runs, performs sequence alignment and trimming, and produces the necessary files for phylogenetic inference. This skill helps you manage the workflow of extracting shared markers from diverse datasets, handling missing data through occupancy thresholds, and choosing between supermatrix or gene-tree-based approaches.

## Core Workflow

### 1. Data Preparation
Before running the pipeline, collect all completed BUSCO output directories into a single parent directory. The tool identifies samples based on the subfolder names within this input directory.

### 2. Assessing Marker Occupancy
Use the `count_buscos.py` utility to determine how many BUSCOs are shared across your samples. This helps you decide on a reasonable threshold for missing data.

```bash
python count_buscos.py -i /path/to/busco_results_dir
```
*   **Output**: A summary of how many BUSCOs are present in what percentage of samples and a presence/absence table.

### 3. Constructing the Phylogeny
Run the main pipeline to generate alignments and trees.

```bash
python BUSCO_phylogenomics.py -i BUSCO_results -o output_dir -t 8
```

#### Key Parameters:
*   `-psc [0-100]`: Percent Single-Copy. Use this to include markers that are not present in 100% of species (e.g., `-psc 70` for 70% occupancy).
*   `--supermatrix_only`: Skips individual gene tree generation to save time.
*   `--gene_trees_only`: Skips the concatenated alignment.
*   `--nt`: Aligns nucleotide sequences instead of amino acids (Default is protein).
*   `--trimal_strategy`: Choose trimming rigor (`automated1`, `gappyout`, `strict`, `strictplus`).

## Expert Tips and Best Practices

*   **Nucleotide Mode Warning**: Do not use the `--nt` flag if your BUSCO runs were performed using `miniprot`, as `miniprot` only generates amino acid sequences.
*   **Handling Patchy Datasets**: If your samples have varying assembly quality, start with a lower `-psc` (e.g., 50-70) to increase the number of markers in your supermatrix, then refine based on the resulting alignment length and tree support.
*   **Tree Inference Engines**: While the tool defaults to `fasttree` for speed, you can specify `--gene_tree_program iqtree` for more robust (though slower) maximum likelihood inference.
*   **Legacy Support**: If your BUSCO results were generated with BUSCO version 3, you must include the `--busco_version_3` flag due to differences in the output directory structure compared to versions 4 and 5.
*   **Resource Management**: The `-t` (threads) parameter controls parallel alignment and trimming jobs. Ensure your memory allocation is sufficient for the number of threads, especially when using `iqtree`.

## Reference documentation
- [Bioconda busco_phylogenomics Overview](./references/anaconda_org_channels_bioconda_packages_busco_phylogenomics_overview.md)
- [BUSCO Phylogenomics GitHub Documentation](./references/github_com_jamiemcg_BUSCO_phylogenomics.md)