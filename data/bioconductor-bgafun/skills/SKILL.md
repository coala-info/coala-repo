---
name: bioconductor-bgafun
description: This tool identifies functional residues in protein alignments using Between Group Analysis to differentiate protein subfamilies. Use when user asks to identify residues that differentiate protein subfamilies, perform Between Group Analysis on multiple sequence alignments, or encode alignments using binary and amino acid properties.
homepage: https://bioconductor.org/packages/3.5/bioc/html/bgafun.html
---

# bioconductor-bgafun

name: bioconductor-bgafun
description: Identify functional residues in protein alignments using Between Group Analysis (BGA). Use this skill when you need to perform supervised multivariate statistical analysis on multiple sequence alignments (MSA) to find residues that differentiate protein subfamilies (e.g., LDH vs. MDH). It supports binary and Amino Acid Properties (AAP) encoding, gap removal, and visualization of group separation.

# bioconductor-bgafun

## Overview

The `bgafun` package applies Between Group Analysis (BGA) to protein sequence alignments. It helps identify specific amino acid positions (residues) that are statistically significant in defining the differences between predefined groups of proteins (e.g., different substrate specificities). The workflow involves converting alignments into numerical matrices (Binary or AAP factors), performing ordination (PCA or Correspondence Analysis), and identifying the top contributing residues.

## Core Workflow

### 1. Data Input and Group Definition
Read sequences using `seqinr` and define a factor for grouping.

```r
library(bgafun)
library(seqinr)

# Read alignment
aln <- read.alignment(file = "path/to/file.fasta", format = "fasta")

# Convert to matrix to extract names for grouping
aln_mat <- convert_aln_amino(aln)
groups <- ifelse(grepl("Group1", rownames(aln_mat)), "Group1", "Group2")
groups <- as.factor(groups)
```

### 2. Matrix Encoding Schemes
Choose between Binary encoding (presence/absence) or Amino Acid Properties (AAP) encoding (biophysical factors).

**Binary Encoding:**
Best for Correspondence Analysis (CA).
```r
# Convert and remove gaps
amino_mat <- convert_aln_amino(aln)
amino_gapless <- remove_gaps_groups(amino_mat, groups, threshold = 0.05)

# Add pseudocounts (essential to prevent zero-dominance)
amino_pseudo <- add_pseudo_counts(amino_gapless, groups)
```

**AAP Encoding:**
Uses 5 biophysical factors (Polarity, Secondary Structure, Size, Charge, Codon diversity). Best for PCA.
```r
# Convert to AAP
aap_mat <- convert_aln_AAP(aln)

# Replace gaps with subfamily average for that column
aap_ave <- average_cols_aap(aap_mat, groups)
```

### 3. Running Between Group Analysis (BGA)
Use `run_between_pca` for continuous data (AAP) or `bga` for integer data (Binary).

```r
# For AAP data (PCA)
# Requires a binary matrix for sequence weights and the AAP matrix for analysis
bga_results <- run_between_pca(amino_gapless, aap_ave, groups)

# For Binary data (CA)
# Note: Input matrix usually needs to be transposed
bga_binary <- bga(t(amino_pseudo), groups)
```

### 4. Identifying Important Residues
Extract the residues that contribute most to the separation between groups.

```r
# Identify top residues for 2 groups
top_res <- top_residues_2_groups(bga_binary)

# Clean names (remove 'X' prefix often added by R)
names(top_res) <- sub("X", "", names(top_res))

# Create profile strings to see amino acid distribution at these positions
profiles <- create_profile_strings(amino_mat, groups)
important_profiles <- profiles[, colnames(profiles) %in% names(top_res)]
```

### 5. Visualization
Visualize the separation of groups and the contribution of residues using `made4` plotting functions.

```r
plot(bga_results)
```

## Tips and Best Practices
- **Pseudocounts**: Always use `add_pseudo_counts` or add 1 to the binary matrix. Without this, the absence of an amino acid in a column can disproportionately skew the BGA.
- **Gap Removal**: Use `remove_gaps_groups` to filter out columns that are mostly gaps within a specific group, as these are often uninformative for functional residue identification.
- **Ordination Choice**: Use PCA for AAP encoding (continuous variables) and Correspondence Analysis (CA) for Binary encoding (count/integer data).

## Reference documentation
- [bgafun](./references/bgafun.md)