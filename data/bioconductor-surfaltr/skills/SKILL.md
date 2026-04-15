---
name: bioconductor-surfaltr
description: The surfaltr package compares cell surface protein isoforms by predicting membrane topology and visualizing structural differences caused by alternative splicing. Use when user asks to match alternative isoforms to principal ones, predict transmembrane topology, rank isoforms by structural changes, or visualize protein domain differences through plots and multiple sequence alignments.
homepage: https://bioconductor.org/packages/release/bioc/html/surfaltr.html
---

# bioconductor-surfaltr

## Overview
The `surfaltr` package facilitates the comparison of cell surface protein isoforms. It automates the process of matching alternative isoforms to principal ones (using APPRIS annotations), predicting their membrane topology (inside, outside, or transmembrane), and visualizing these differences. This is particularly useful for identifying how alternative splicing might alter the druggable portion of a protein or its cellular localization.

## Typical Workflow

### 1. Data Preparation
Input data must be a CSV file in one of two formats:
- **Transcript IDs:** Columns `gene_name` and `transcript`.
- **Amino Acid Sequences:** Columns `external_gene_name`, `transcript_id`, and `protein_sequence`.

### 2. Rapid Analysis (Consensus Functions)
Use these functions to perform pairing, prediction, and plotting in a single step.

```r
library(surfaltr)

# From Transcript IDs (Human)
graph_from_ids(
  data_file = "path/to/ids.csv",
  organism = "human",
  mode = "phobius",
  rank = "combo",
  n_prts = 20
)

# From Amino Acid Sequences (Mouse)
graph_from_aas(
  data_file = "path/to/sequences.csv",
  organism = "mouse",
  mode = "phobius",
  rank = "TM"
)
```

### 3. Step-by-Step Processing
For more control or intermediate outputs, use the modular functions:

**Pairing and FASTA generation:**
```r
# if_aa = TRUE for sequence input, FALSE for ID input
AA_lst <- get_pairs(data_file = "input.csv", if_aa = TRUE, organism = "mouse")
```

**Topology Prediction:**
- **Phobius (Recommended):** Uses an API; detects signal peptides.
- **TMHMM:** Requires local standalone installation; more conservative.

```r
# Using Phobius
mem_topo <- run_phobius(AA_seq = AA_lst, fasta_file_name = "output/AA.fasta")

# Using TMHMM (requires path to local installation)
mem_topo <- get_tmhmm(fasta_file_name = "AA.fasta", tmhmm_folder_name = "~/TMHMM2.0c")
```

**Ranking and Plotting:**
Rank isoforms by `length`, `TM` (difference in TM domains), or `combo` (weighted metric).
```r
plot_isoforms(topo = mem_topo, AA_seq = AA_lst, rank = "combo", n_prts = 15)
```

### 4. Multiple Sequence Alignment (MSA)
To visualize specific sequence changes alongside topology plots:
```r
# Single organism
align_prts(gene_names = c("Crb1"), data_file = "input.csv", if_aa = TRUE, organism = "mouse")

# Cross-organism (Human vs Mouse)
align_org_prts(gene_names = c("GPR125"), hs_data_file = "human.csv", mm_data_file = "mouse.csv")
```

## Key Parameters and Tips
- **Organism Support:** Currently supports "human" (GRCh38.p13) and "mouse" (GRCm39).
- **Prediction Modes:** 
    - `phobius`: Faster, includes signal peptides (`s`).
    - `tmhmm`: Local/private, no signal peptide detection.
- **Ranking Logic:** 
    - `TM`: Prioritizes isoforms that gain TM domains (positive difference).
    - `combo`: Prioritizes isoforms with high differences in both length and TM count.
- **Plotting:** If plotting many proteins (>20), decrease `size_txt` (e.g., 1.5) and increase `space_left` (e.g., -500) to prevent label overlapping.
- **Interpretation:** Phobius labels proteins with no TM/signal peptide as "internal"; TMHMM labels them "extracellular." Treat both as "unknown" without experimental validation.

## Reference documentation
- [Rapid Comparison of Surface Protein Isoform Membrane Topologies Through surfaltr](./references/surfaltr_vignette.md)