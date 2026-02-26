---
name: bioconductor-clonotyper
description: "bioconductor-clonotyper analyzes and compares T cell antigen receptor clonotypes from high-throughput sequence libraries. Use when user asks to process TCR sequences, generate clonotype count tables, identify shared or private clonotypes, and apply Yassai nomenclature."
homepage: https://bioconductor.org/packages/3.6/bioc/html/clonotypeR.html
---


# bioconductor-clonotyper

name: bioconductor-clonotyper
description: Analysis of T cell antigen receptor (TCR) sequences using the clonotypeR Bioconductor package. Use this skill when processing, quantifying, and comparing V-CDR3-J clonotypes from multiple sequence libraries. It supports reading clonotype data, generating count tables, identifying common/private clonotypes, and applying the Yassai nomenclature for TCR sequences.

# bioconductor-clonotyper

## Overview
The `clonotypeR` package is designed for the high-throughput analysis of T cell antigen receptor (TCR) sequences. It focuses on the CDR3 loop—the hyper-variable region created by somatic recombination of V, (D), and J segments. The package allows users to process millions of sequences to identify, quantify, and compare clonotypes across different biological libraries.

## Core Workflow

### 1. Loading Data
Data is typically loaded from a tabulation-delimited text file containing extracted clonotypes.

```r
library(clonotypeR)
# Load clonotypes from a file
clonotypes <- read_clonotypes("clonotypes.txt.gz")

# Inspect the data frame
head(clonotypes)
```

The resulting data frame includes columns for library name (`lib`), V/J segments, alignment scores, DNA/amino acid sequences, and flags for unproductive or ambiguous sequences.

### 2. Creating Count Tables
The `clonotype_table` function aggregates raw sequence data into a matrix of counts.

```r
# Create a table of clonotypes (V + peptide + J)
# By default, unproductive and ambiguous sequences are filtered out
counts <- clonotype_table(data = clonotypes)

# Count specific features, like J segments only
j_counts <- clonotype_table(libs = levels(clonotypes$lib), feats = "J", data = clonotypes)

# Normalize to parts per million (PPM)
counts_ppm <- prop.table(as.matrix(counts), 2) * 1000000
```

### 3. Comparative Analysis
Identify clonotypes shared between libraries or unique to specific samples.

*   **Common Clonotypes**: Find overlaps between groups.
```r
# List clonotypes found in both Library A and Library B
shared <- common_clonotypes(group1 = "LibA", group2 = "LibB", data = counts)

# Generate a pairwise overlap matrix (count mode)
overlap_matrix <- common_clonotypes(data = counts, mode = "count")
```

*   **Unique and Private Clonotypes**:
```r
# List all unique clonotypes in Library A
unique_A <- unique_clonotypes("LibA", data = counts)

# List clonotypes found ONLY in Library C
private_C <- private_clonotypes("LibC", data = counts)
```

### 4. Quality Control and Filtering
Identify sequences that are likely non-functional due to stop codons or frame shifts.

```r
# Check for unproductive sequences
unproductive_flags <- is_unproductive(clonotypes)

# Filter during table creation using custom thresholds
clean_table <- clonotype_table(data = clonotypes, minscore = 50, minqual = 20)
```

### 5. TCR Nomenclature (Yassai Identifier)
Generate standardized TCR identifiers based on the Yassai et al. nomenclature.

```r
# Generate identifiers for the dataset
ids <- yassai_identifier(clonotypes)

# Use 'long' mode to avoid collisions in ambiguous cases
ids_long <- yassai_identifier(clonotypes, long = TRUE)
```

## Tips and Best Practices
*   **Library Names**: Ensure library names in your input file are unique and consistent.
*   **Filtering**: `clonotype_table` automatically filters unproductive rearrangements by default. If you need to include them for specific analyses (e.g., studying recombination patterns), adjust the `filter` argument.
*   **Memory**: For very large datasets (millions of reads), ensure your R environment has sufficient memory, as `read_clonotypes` loads the full table into a data frame.

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)