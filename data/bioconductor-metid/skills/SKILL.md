---
name: bioconductor-metid
description: bioconductor-metid identifies metabolites in LC-MS data using a network-based probabilistic scoring framework. Use when user asks to prioritize putative metabolite identifications, calculate probability scores for known-unknown ions, or identify metabolites using biochemical network relationships.
homepage: https://bioconductor.org/packages/release/bioc/html/MetID.html
---

# bioconductor-metid

name: bioconductor-metid
description: Network-based approach for metabolite identification in LC-MS metabolomics. Use this skill to prioritize putative metabolite IDs for "known-unknown" ions by exploiting biochemical network relationships and probabilistic scoring.

# bioconductor-metid

## Overview

The `MetID` package implements a network-based probabilistic framework to identify metabolites from LC-MS data. It addresses the challenge of "known-unknowns"—ions that have putative identifications but require prioritization. By leveraging knowledge from biochemical networks (KEGG, PubChem) and pathway inter-dependencies, it assigns scores to candidate metabolites to help determine the most likely identity of a detected peak.

## Core Workflow

The primary function in this package is `get_scores_for_LC_MS()`.

### 1. Data Preparation

The input data must be a data frame or a path to a `.csv` or `.txt` file. Crucially, the column names must match the package's expected schema exactly.

**Required Column Names:**
- `metid`: Unique identifiers for the peaks/ions.
- `query_m.z`: The observed mass-to-charge ratio from the MS instrument.
- `exact_m.z`: The theoretical exact mass of the putative metabolite identification.
- `kegg_id`: The KEGG Database ID for the candidate metabolite.
- `pubchem_cid`: The PubChem Compound ID for the candidate metabolite.

### 2. Running the Scoring Algorithm

Use `get_scores_for_LC_MS()` to calculate the probability scores.

```r
library(MetID)

# Example using a data frame
# Ensure colnames match: c('query_m.z', 'name', 'formula', 'exact_m.z', 'pubchem_cid', 'kegg_id')
results <- get_scores_for_LC_MS(
  data = my_metabolite_data, 
  type = 'data.frame', 
  na = '-', 
  mode = 'POS' # or 'NEG' for ionization mode
)
```

### 3. Parameters
- `data`: The input dataset (data.frame or file path).
- `type`: The format of the input (`'data.frame'`, `'csv'`, or `'txt'`).
- `na`: The character used to represent missing values in the input (e.g., `'-'` or `NA`).
- `mode`: The ionization mode, either `'POS'` (positive) or `'NEG'` (negative).

## Usage Tips

- **Dataset Size:** The probabilistic scoring algorithm relies on network relationships. Scores are most meaningful when applied to large datasets with many compounds; results on very small datasets (like `demo1`) may not be statistically robust.
- **Column Mapping:** If your raw data has different headers (e.g., "Query.Mass" instead of "query_m.z"), you must rename them using `colnames(df) <- ...` before calling the scoring function.
- **Missing Data:** Ensure that missing KEGG or PubChem IDs are represented by the character string specified in the `na` argument so the package can handle them correctly during network construction.

## Reference documentation

- [Introduction to MetID](./references/Introduction_to_MetID.md)
- [Introduction to MetID (RMarkdown)](./references/Introduction_to_MetID.Rmd)