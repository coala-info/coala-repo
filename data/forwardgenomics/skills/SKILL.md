---
name: forwardgenomics
description: Forward Genomics is a computational framework designed to identify genomic regions responsible for specific traits by looking for "use it or lose it" evolutionary signatures.
homepage: https://github.com/hillerlab/ForwardGenomics
---

# forwardgenomics

## Overview
Forward Genomics is a computational framework designed to identify genomic regions responsible for specific traits by looking for "use it or lose it" evolutionary signatures. When a trait is repeatedly lost in independent lineages, the underlying genetic information often diverges or disappears due to the lack of purifying selection. 

This skill enables the use of three primary methods:
1. **Perfect Match**: Finds regions where all trait-loss species are more diverged than all trait-preserving species.
2. **GLS (Generalized Least Squares)**: Controls for phylogenetic relatedness and evolutionary rate differences.
3. **Branch Method**: Uses per-branch divergence values to provide the highest statistical power, especially when distinguishing between coding (CDS) and non-coding (CNE) elements.

## Prerequisites
*   **R Environment**: Version 3.02 or later with packages `caper`, `xtermStyle`, `phangorn`, `weights`, and `isotone`.
*   **Phast Package**: The `tree_doctor` utility must be in your `$PATH`.
*   **Ancestral Naming**: All internal nodes in your phylogenetic tree must be named. Use `tree_doctor -a` if they are missing.

## Input File Requirements
The tool requires four specific input formats:
1.  **Phylogenetic Tree**: Newick format with branch lengths and named ancestors.
2.  **Element IDs**: A simple list of genomic region identifiers to process.
3.  **Phenotype List**: A space-separated file with header `species pheno`. Use `1` for trait presence and `0` for loss.
4.  **Identity Values**:
    *   **Global**: Space-separated table (Element ID vs. Species) for GLS.
    *   **Local**: Space-separated file with header `branch id pid` for the Branch method.

## Command Line Usage

### Standard Analysis
To run all three methods (Perfect Match, GLS, and Branch) simultaneously:
```bash
forwardGenomics.R --tree=tree.nh --elementIDs=IDlist.txt --listPheno=phenotype.txt --globalPid=globalPercentID.txt --localPid=localPercentID.txt --outFile=results.txt
```

### Method Selection
If you only have global data or only want to run specific tests, use the `--methods` flag:
*   **GLS only**: `--methods=GLS`
*   **Branch only**: `--methods=branch`
*   **Perfect Match only**: `--methods=perfectMatch`

### Analyzing Non-Coding Regions (CNE)
By default, the branch method assumes coding regions (CDS). For non-coding regions, you must specify the appropriate lookup data:
```bash
forwardGenomics.R --tree=tree.nh --elementIDs=IDlist.txt --listPheno=phenotype.txt --localPid=localPercentID.txt --weights=lookUpData/branchWeights_CNE.txt --expectedPerIDs=lookUpData/expPercentID_CNE.txt --outFile=cne_results.txt
```

## Expert Tips & Best Practices
*   **Evolutionary Rates**: Always prefer the **GLS** or **Branch** methods over Perfect Match for real biological data, as they account for the fact that some species naturally evolve faster than others.
*   **Independent Losses**: By default, GLS only considers elements implying at least 2 independent loss events. This prevents false positives driven by a single lineage-specific event.
*   **Data Preparation**: If you need to generate the element ID list from your global identity file, use:
    `tail -n +2 globalPid.file | cut -f1 -d " " > IDlist.txt`
*   **Branch Method Power**: The Branch method is the most sensitive but requires high-quality local (per-branch) sequence identity data. Ensure your alignment and branch-length estimations are robust before using this method.

## Reference documentation
- [ForwardGenomics GitHub README](./references/github_com_hillerlab_ForwardGenomics.md)
- [ForwardGenomics Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_forwardgenomics_overview.md)