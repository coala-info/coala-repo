---
name: forwardgenomics
description: Forward Genomics identifies genomic regions associated with the loss of specific traits by comparing divergence patterns across a phylogenetic tree. Use when user asks to link phenotypic trait loss to genomic changes, prepare phylogenetic input files, or execute the Perfect Match, GLS, and Branch analysis methods.
homepage: https://github.com/hillerlab/ForwardGenomics
---


# forwardgenomics

## Overview

Forward Genomics is a computational framework designed to link the repeated loss of a specific trait across different species to the underlying genomic changes. It operates on the principle that when a trait is no longer under selection (trait loss), the genetic information required for that trait will accumulate mutations and diverge over time. By comparing trait-loss lineages with trait-preserving lineages across a phylogenetic tree, the tool identifies genomic regions that show a signature of conservation in preserving species and divergence in loss species.

This skill provides guidance on preparing the necessary phylogenetic and genomic input files and executing the three primary analysis methods: Perfect Match, Generalized Least Squares (GLS), and the Branch Method.

## Input File Requirements

Before running the analysis, ensure the following four inputs are formatted correctly:

1.  **Phylogenetic Tree**: A Newick format file with branch lengths. All ancestral nodes must be named.
    *   *Tip*: Use `tree_doctor -a` from the PHAST package to automatically name internal nodes if they are missing.
2.  **Element Identifiers**: A simple text file listing the IDs of genomic regions (e.g., genes or enhancers) to be processed, one per line.
3.  **Phenotype List**: A space-separated file with a header `species pheno`.
    *   `1`: Trait present.
    *   `0`: Trait lost.
    *   *Note*: Only include species present in the tree.
4.  **Divergence Data (%id)**:
    *   **Global %id**: For GLS/Perfect Match. A table with `species` as the first header, followed by species names. Rows start with the element ID.
    *   **Local %id**: For the Branch Method. A table with header `branch id pid` listing per-branch divergence.

## Command Line Usage

The primary interface is the `forwardGenomics.R` script.

### Basic Execution
To run all three methods (Perfect Match, GLS, and Branch) simultaneously:

```bash
forwardGenomics.R --tree=path/to/tree.nh \
                  --elementIDs=path/to/IDlist.txt \
                  --listPheno=path/to/phenotype.txt \
                  --globalPid=path/to/globalPid.txt \
                  --localPid=path/to/localPid.txt \
                  --outFile=results.txt
```

### Method Selection
Use the `--method` flag to limit the analysis type, which can save significant computation time if you only have specific data types:

*   **Branch Method only**: Requires `--localPid`.
    ```bash
    forwardGenomics.R [paths] --method='branch'
    ```
*   **GLS/Perfect Match only**: Requires `--globalPid`.
    ```bash
    forwardGenomics.R [paths] --method='GLS'
    ```

### Analyzing Non-Coding Regions (CNEs)
By default, the Branch Method assumes coding sequences (CDS). If analyzing non-coding regions, you must point to the appropriate lookup data:

```bash
forwardGenomics.R [paths] \
                  --weights=lookUpData/branchWeights_CNE.txt \
                  --expectedPerIDs=lookUpData/expPercentID_CNE.txt
```

## Expert Tips and Best Practices

*   **Phylogenetic Control**: Prefer the **Branch Method** or **GLS** over "Perfect Match" for publication-quality results. Perfect Match is highly restrictive and does not account for phylogenetic relatedness or varying evolutionary rates, whereas the other two methods do.
*   **Data Normalization**: By default, the GLS method normalizes %id values to control for differences in neutral evolutionary rates across the tree.
*   **Handling Missing Data**: The tool automatically handles genome gaps. If a genomic element is missing in some species, it will prune the tree for that specific element. However, it requires at least 2 trait-loss and 2 trait-preserving species to remain after pruning to process the element.
*   **Ancestral Naming**: The most common cause of execution failure is unnamed internal nodes in the Newick tree. Always verify your tree with `tree_doctor -p` before starting.



## Subcommands

| Command | Description |
|---------|-------------|
| forwardGenomics.R | Forward Genomics: bold [0m |
| tree_doctor | Scale, prune, merge, and otherwise tweak phylogenetic trees. Expects input to be a tree model (.mod) file unless filename ends with '.nh' or -n option is used, in which case it will be expected to be a tree file in Newick format. |

## Reference documentation
- [Forward Genomics README](./references/github_com_hillerlab_ForwardGenomics_blob_master_README.md)
- [Forward Genomics Main Script](./references/github_com_hillerlab_ForwardGenomics_blob_master_forwardGenomics.R.md)
- [Full Analysis Logic](./references/github_com_hillerlab_ForwardGenomics_blob_master_forwardGenomics_fullAnalysis.R.md)