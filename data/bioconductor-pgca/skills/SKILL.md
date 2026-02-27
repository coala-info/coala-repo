---
name: bioconductor-pgca
description: This tool implements the Protein Group Code Algorithm to merge protein summaries from multiple MS/MS experimental runs into a consistent global mapping. Use when user asks to create a global protein group dictionary, map local protein groups to global identifiers, or harmonize protein group codes across different proteomics experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/pgca.html
---


# bioconductor-pgca

name: bioconductor-pgca
description: Protein Group Code Algorithm (PGCA) for merging protein summaries from multiple MS/MS experimental runs. Use this skill to create a global mapping (dictionary) of protein groups across different experiments, ensuring consistent protein group identifiers (PGC) for downstream comparative analysis. Ideal for shotgun proteomics workflows where protein inference varies between batches.

# bioconductor-pgca

## Overview

The `pgca` package implements the Protein Group Code Algorithm, which addresses the challenge of inconsistent protein grouping across multiple mass spectrometry (MS/MS) experimental runs. In shotgun proteomics, different runs often assign the same peptides to different protein groups (local groups). PGCA connects these groups by identifying overlapping accession numbers across runs and creating "global" protein groups. This allows researchers to compare protein levels across different batches or multiplexed experiments using a unified Protein Group Code (PGC).

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pgca")
library(pgca)
```

## Core Workflow

### 1. Prepare Input Data
Input data should be data frames or text files containing at least:
- A local group identifier (typically named `N`).
- Protein accession numbers (typically named `Accession`).
- Optional metadata like Gene Symbols or Protein Names.

### 2. Build the Global Dictionary
Use `pgcaDict` to create a mapping between local groups and global groups.

```r
# From data frames
dict <- pgcaDict(run1_df, run2_df, run3_df)

# From file paths
dict <- pgcaDict("path/to/run1.txt", "path/to/run2.txt")

# From a directory containing only MS/MS summary files
dict <- pgcaDict("path/to/data_directory/")

# Retaining specific columns (e.g., Gene Symbols)
dict <- pgcaDict(run1_df, run2_df, col.mapping = c(gene.symbol = "Gene_Symbol"))
```

### 3. Apply the Dictionary
Use `applyDict` to append the Protein Group Code (PGC) to your datasets. This ensures that the same protein group has the same ID across all files.

```r
# Returns a list of data frames with an added 'PGC' column
translated_data <- applyDict(run1_df, run2_df, dict = dict)

# Access specific translated run
run1_translated <- translated_data[[1]]
```

### 4. Save the Dictionary
The dictionary can be exported for future use or documentation.

```r
saveDict(dict, file = "global_protein_dictionary.txt")
```

## Key Functions and Parameters

- **`pgcaDict(...)`**:
  - `...`: Data frames, character strings (file paths), or a directory path.
  - `col.mapping`: A named character vector to map internal names to your data's column names (e.g., `c(gene.symbol = "My_Gene_Col")`).
- **`applyDict(...)`**:
  - `dict`: The dictionary object returned by `pgcaDict`.
  - `outdir`: (Optional) If provided, saves the translated files to this directory instead of returning a list.

## Tips for Success
- **Consistency**: Ensure that accession numbers are in the same format across all input files (e.g., all IPI or all UniProt).
- **Memory**: For very large studies, building the dictionary from file paths or directories is more memory-efficient than loading all data frames into the R environment first.
- **Interpretation**: If a protein group in the dictionary contains multiple gene symbols, it indicates that those proteins were indistinguishable based on the identified peptides across the experiments.

## Reference documentation

- [Introduction to the PGCA Package](./references/intro.md)