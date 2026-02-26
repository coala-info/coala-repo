---
name: picrust2
description: PICRUSt2 predicts the functional potential of microbial communities by reconstructing unobserved states from marker gene data. Use when user asks to predict metabolic functions from amplicon sequences, infer KEGG or MetaCyc pathway abundances, or perform hidden-state prediction for microbial samples.
homepage: https://github.com/picrust/picrust2
---


# picrust2

## Overview
PICRUSt2 (Phylogenetic Investigation of Communities by Reconstruction of Unobserved States) is a bioinformatics framework that predicts the functional content of a microbial community based on marker gene data. It improves upon the original version by allowing for sequence placement into a massive reference tree, expanding the reference genome database (PICRUSt2-SC), and utilizing more rigorous pathway inference via MinPath. It is the standard tool for researchers who have amplicon data but require insights into the potential metabolic functions (KEGG Orthologs, EC numbers, MetaCyc pathways) of their samples.

## Installation and Setup
The most reliable way to install PICRUSt2 is via Bioconda to ensure all dependencies (EPA-NG, Gappa, Castor, MinPath) are correctly configured.

```bash
conda install -c bioconda picrust2
```

## Common CLI Patterns

### 1. The Full Pipeline
The `picrust2_pipeline.py` script is the most common entry point, executing sequence placement, hidden-state prediction, metagenome prediction, and pathway inference in one command.

```bash
picrust2_pipeline.py \
  -s study_seqs.fna \
  -i study_abundance.biom \
  -o picrust2_output \
  -p 4 \
  --hsp_method pic \
  --max_nsti 2.0
```
*   `-s`: FASTA file of representative sequences (ASVs/OTUs).
*   `-i`: Abundance table in BIOM, TSV, or MOTU format.
*   `-p`: Number of processes/cores to use.
*   `--hsp_method`: Hidden State Prediction method (default is `mp` for maximum parsimony; `pic` for phylogenetic independent contrasts).

### 2. Adding Functional Descriptions
Output tables often contain IDs (e.g., K00001). Use `add_descriptions.py` to make the results human-readable.

```bash
add_descriptions.py \
  -i picrust2_output/pathways_out/path_abun_unstrat.tsv.gz \
  -m METACYC \
  -o picrust2_output/pathways_out/path_abun_unstrat_desc.tsv.gz
```

### 3. Stratified vs. Unstratified Outputs
*   **Unstratified**: Provides the total abundance of a function across the entire community.
*   **Stratified**: Breaks down the functional abundance by the contributing sequences (taxa). Use the `--stratified` flag in the main pipeline if you need to know "who is doing what," though this significantly increases file size and runtime.

## Expert Tips and Best Practices
*   **Input Quality**: Use Amplicon Sequence Variants (ASVs) from DADA2 or Deblur rather than 97% OTUs. ASVs provide better resolution for phylogenetic placement.
*   **NSTI Scores**: Always check the Weighted Nearest Sequenced Taxon Index (NSTI) in the output. High NSTI scores (e.g., > 0.15 in human samples or > 0.5 in diverse environmental samples) indicate that your sequences are distantly related to available reference genomes, making predictions less reliable.
*   **Custom Databases**: While PICRUSt2-SC is the default, you can use `place_seqs.py` and `hsp.py` independently with custom reference trees and trait tables for non-standard marker genes.
*   **Normalization**: PICRUSt2 automatically normalizes for 16S rRNA gene copy number. Do not pre-normalize your abundance table for copy number before inputting it.

## Reference documentation
- [PICRUSt2 Wiki](./references/github_com_picrust_picrust2_wiki.md)
- [PICRUSt2 GitHub Repository](./references/github_com_picrust_picrust2.md)
- [Bioconda PICRUSt2 Overview](./references/anaconda_org_channels_bioconda_packages_picrust2_overview.md)