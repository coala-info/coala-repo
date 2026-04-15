---
name: bioconductor-proteasy
description: bioconductor-proteasy maps peptide termini to known protease cleavage sites using data from the MEROPS database. Use when user asks to identify potential proteases for specific substrates, find substrates for a given protease, or map experimental peptide sequences to proteolytic events.
homepage: https://bioconductor.org/packages/3.16/bioc/html/proteasy.html
---

# bioconductor-proteasy

name: bioconductor-proteasy
description: Mapping peptide termini to known protease cleavage sites using MEROPS data. Use this skill to identify potential proteases for specific substrates, find substrates for a given protease, and analyze proteolytic events in proteomics data.

# bioconductor-proteasy

## Overview

The `proteasy` package provides tools for retrieving and analyzing protease-substrate interactions by leveraging data from the MEROPS database. It is particularly useful for "degradomics" and peptide-centric analyses where researchers need to identify which enzymes might be responsible for observed endogenous cleavage products.

## Installation

Install the package via BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("proteasy")
library(proteasy)
```

## Core Workflows

### 1. Finding Proteases for a Substrate
Use `searchSubstrate()` to identify proteases known to cleave a specific protein.

```r
# Get a simple vector of reviewed proteases for a UniProt ID
proteases <- searchSubstrate(protein = "P01042", summarize = TRUE)

# Get a detailed data.table of all cleaving events (reviewed and unreviewed)
details <- searchSubstrate(protein = "P01042", summarize = FALSE)
```

### 2. Finding Substrates for a Protease
Use `searchProtease()` to find all proteins targeted by a specific protease.

```r
# Find substrates for MMP-12 (P39900)
substrates_list <- searchProtease(protein = "P39900", summarize = TRUE)
```

### 3. Mapping Peptides to Proteases
The `findProtease()` function is the primary tool for experimental peptide data. It maps a peptide sequence to its host protein and checks MEROPS for matching cleavage sites at the N- or C-terminus.

```r
# Input vectors of protein IDs and peptide sequences
res <- findProtease(protein = c("P02671", "P68871"),
                    peptide = c("FEEVSGNVSPGTR", "LLVVYPW"),
                    organism = "Homo sapiens")

# Access results using S4 accessor functions:
substrates(res) # Sequence and position data
proteases(res)  # Metadata about the identified proteases
cleavages(res)  # Specific details of the proteolytic events
```

### 4. Manual Lookup
To view the full MEROPS entry for a protease in a web browser:

```r
browseProtease("P07339", keytype = "UniprotID")
```

## Data Handling Tips

*   **Organism Constraints:** `proteasy` currently supports one organism at a time. Ensure the `organism` parameter matches your data (e.g., "Homo sapiens").
*   **Sequence Matching:** If `start_pos` and `end_pos` are not provided to `findProtease()`, the package matches the peptide to the first instance found in the protein sequence.
*   **Filtering Results:** The `cleavages()` output is a `data.table`. You can easily filter for "reviewed" proteases or "physiological" cleavage types:
    ```r
    cl <- cleavages(res)
    reviewed_cl <- cl[`Protease status` == "reviewed"]
    ```
*   **Visualization:** Results can be integrated with `igraph` for network analysis or `ComplexHeatmap` for sequence similarity studies.

## Reference documentation

- [Using proteasy to Retrieve and Analyze Protease Data](./references/proteasy.Rmd)
- [Using proteasy to Retrieve and Analyze Protease Data](./references/proteasy.md)