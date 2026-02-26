---
name: gubbins
description: Gubbins identifies recombinant regions in bacterial genome alignments and constructs a phylogeny based on non-recombinant point mutations. Use when user asks to identify recombination events, mask horizontal gene transfer, or build a recombination-aware phylogenetic tree for bacterial sequences.
homepage: https://github.com/nickjcroucher/gubbins
---


# gubbins

## Overview
Gubbins (Genealogies Unbiased By recomBinations In Nucleotide Sequences) is an iterative algorithm designed to handle the high rates of horizontal gene transfer common in bacterial evolution. It identifies genomic regions with elevated densities of base substitutions—marking them as recombinations—and constructs a phylogeny based on the remaining point mutations. This tool is essential when working with large samples of closely related bacterial genomes where standard phylogenetic methods would be biased by recombinant DNA.

## Usage Instructions

### Basic Execution
The primary command for running the analysis is `run_gubbins.py`. The only required input is a multiple sequence alignment in FASTA format.

```bash
run_gubbins.py [input_alignment.fasta]
```

### Common CLI Patterns
While the default settings are suitable for many analyses, specific flags can optimize the run based on your dataset size and required precision:

*   **Tree Building:** Gubbins supports multiple phylogenetic software backends. You can specify the tree builder depending on your need for speed (e.g., FastTree) or accuracy (e.g., RAxML or IQTree).
*   **Multithreading:** For large alignments, use the threading options to parallelize the recombination search and tree construction.
*   **Iterations:** The algorithm is iterative. If the phylogeny does not converge, you may need to adjust the number of iterations.

### Expert Tips and Best Practices
*   **Input Preparation:** Ensure your input FASTA is a high-quality multiple sequence alignment. Gubbins is designed for short-term bacterial evolution; highly divergent sequences may lead to over-masking.
*   **Software Selection:** 
    *   Use **IQTree2** or **RAxML-NG** for the most accurate ancestral sequence reconstruction.
    *   Use **FastTree** or **Rapidnj** if you are processing hundreds of sequences and need a rapid initial assessment.
*   **Output Interpretation:** Gubbins produces several files, including the final phylogenetic tree and GFF files containing the coordinates of predicted recombination events. These GFF files can be visualized in tools like Phandango or Artemis to see where recombination is occurring across the genome.
*   **Rerooting:** Note that in certain versions, trees may not be midpoint rerooted by default. Always check the orientation of your output tree before downstream analysis.

## Reference documentation
- [Gubbins GitHub Repository](./references/github_com_nickjcroucher_gubbins.md)
- [Gubbins Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gubbins_overview.md)