---
name: phyloacc
description: PhyloAcc is a Bayesian framework that identifies genomic elements with accelerated evolutionary rates in specific lineages by comparing substitution rates across a phylogeny. Use when user asks to identify accelerated evolution in non-coding DNA, detect shifts in evolutionary constraints, or account for gene tree discordance when testing for rate changes.
homepage: https://github.com/phyloacc/PhyloAcc
---


# phyloacc

## Overview
PhyloAcc is a Bayesian framework designed to identify genomic elements that have undergone changes in evolutionary constraints. By comparing substitution rates across different branches of a species tree, it distinguishes between elements that are consistently conserved and those that show evidence of accelerated evolution in specific "target" lineages. It accounts for phylogenetic relationships and can incorporate gene tree-species tree discordance to provide more robust estimates of rate shifts in non-coding DNA.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::phyloacc
# or using mamba
mamba install phyloacc
```

## Core Command Line Usage

### Required Inputs
To run `phyloacc.py`, you must provide:
1.  **Model File (`-m`)**: A `.mod` file from `phyloFit` containing the background substitution rate matrix and species tree.
2.  **Sequence Data**: Either a concatenated FASTA (`-a`) with a corresponding BED file (`-b`), or a directory of individual FASTA files (`-d`).
3.  **Target Species (`-t`)**: A semicolon-separated list of tip labels representing the lineages to test for acceleration.

### Common CLI Patterns

**1. Standard Species Tree Model (Concatenated Input)**
Use this for a basic search for accelerated regions using the species tree topology.
```bash
phyloacc.py -a alignment.fa -b regions.bed -m background.mod -t "species1;species2;species3" -r st
```

**2. Gene Tree Model (Accounting for ILS)**
Use this when analyzing regions where incomplete lineage sorting (ILS) is expected. This requires a tree with branch lengths in coalescent units (`-l`) or the `--theta` flag to estimate them.
```bash
phyloacc.py -a alignment.fa -b regions.bed -m background.mod -t "species1;species2" -r gt -l coal_tree.txt
```

**3. Running on a Subset of Loci**
If you have a large BED file but only want to test specific elements, use an ID file.
```bash
phyloacc.py -a alignment.fa -b regions.bed -i target_ids.txt -m background.mod -t "species1;species2"
```

**4. Using an Alignment Directory**
If your data is already split into individual files per locus:
```bash
phyloacc.py -d ./aln_dir/ -m background.mod -t "species1;species2"
```

## Expert Tips and Best Practices

*   **Target Selection**: Ensure the species names in your `-t` string exactly match the tip labels in the `.mod` file. Use semicolons to separate multiple targets.
*   **Model Choice (`-r`)**: 
    *   `st`: Faster, assumes the species tree is the true genealogy for all loci.
    *   `gt`: More accurate for regions with high ILS but requires more computational resources.
    *   `adaptive`: A hybrid approach that uses the gene tree model only on loci with low site concordance factors (sCF).
*   **The Dollo Assumption**: By default, PhyloAcc allows for "regain" of conservation. Use the `--dollo` flag to enforce a Dollo-like assumption where a loss of conservation (acceleration) is irreversible.
*   **Handling Softmasking**: If your alignments contain softmasked (lowercase) bases that should be treated as valid data, use the `--softmask` flag (available in v2.4.5+).
*   **Theta Estimation**: If you do not have a coalescent tree for the gene tree model, use `--theta`. Note that this invokes IQ-TREE and ASTRAL, significantly increasing runtime.
*   **Output Interpretation**: PhyloAcc produces log Bayes Factors (logBF). Typically, a logBF1 > 0 indicates evidence for acceleration in the target lineages compared to a null model of constant conservation.

## Reference documentation
- [PhyloAcc GitHub Repository](./references/github_com_phyloacc_PhyloAcc.md)
- [PhyloAcc Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phyloacc_overview.md)