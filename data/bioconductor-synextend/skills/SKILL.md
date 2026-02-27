---
name: bioconductor-synextend
description: bioconductor-synextend provides tools for orthology prediction, synteny analysis, and genomic rearrangement estimation using DECIPHER synteny objects. Use when user asks to identify orthologous gene pairs, calculate percent identity between linked features, or cluster genes into single-linkage groups based on syntenic k-mer overlaps.
homepage: https://bioconductor.org/packages/release/bioc/html/SynExtend.html
---


# bioconductor-synextend

name: bioconductor-synextend
description: Tools for orthology prediction, synteny analysis, and genomic rearrangement estimation using DECIPHER synteny objects. Use this skill when you need to identify orthologous gene pairs, calculate Percent Identity (PID) between linked features, or cluster genes into single-linkage groups based on syntenic k-mer overlaps.

# bioconductor-synextend

## Overview

`SynExtend` is an R package designed to extend the functionality of `DECIPHER` by mapping genomic features (like genes) onto synteny maps. It identifies "links" between features based on shared k-mers and provides a framework for predicting orthologs and extracting sequences for comparative genomics.

## Core Workflow

### 1. Generate Synteny Object
`SynExtend` works on `Synteny` objects created by `DECIPHER::FindSynteny`.

```r
library(SynExtend)
library(DECIPHER)

# Assuming a DECIPHER SQLite database exists
db <- "path/to/database.sqlite"
syn <- FindSynteny(dbFile = db)
```

### 2. Prepare Gene Calls
To map genes to the synteny map, you must provide gene calls as a named list of DataFrames. The names must match the `dimnames` of the `Synteny` object.

```r
# Import from GFF
gene_calls <- gffToDataFrame(GFF = "path/to/annotation.gff.gz")

# Ensure it is a named list matching the Synteny object
# GeneCalls <- list("Genome1" = df1, "Genome2" = df2)
```

### 3. Identify Linked Pairs
Use `NucleotideOverlap` to find where shared k-mers overlap with defined gene boundaries.

```r
links <- NucleotideOverlap(SyntenyObject = syn, 
                           GeneCalls = gene_calls)
```

### 4. Summarize and Predict Orthologs
`PairSummaries` converts the raw links into a data frame of predicted pairs. It can calculate PIDs (Percent Identity) via alignment or use a faster "Global" model.

```r
# Fast prediction using the Global model
pairs_df <- PairSummaries(SyntenyLinks = links, 
                          DBPATH = db, 
                          PIDs = FALSE)

# Detailed prediction with actual alignments (slower)
pairs_detailed <- PairSummaries(SyntenyLinks = links, 
                                DBPATH = db, 
                                PIDs = TRUE,
                                IgnoreDefaultStringSet = FALSE)
```

### 5. Clustering and Sequence Extraction
Once pairs are identified, you can group them into clusters (e.g., pangenome ortholog groups) and extract the sequences.

```r
# Generate single-linkage clusters
clusters <- DisjointSet(Pairs = pairs_df)

# Extract sequences for specific clusters (e.g., first 5)
seq_sets <- ExtractBy(x = pairs_df, 
                      y = db, 
                      z = clusters[1:5])
```

## Key Functions

- `gffToDataFrame()`: Converts GFF files into the specific DataFrame format required by `SynExtend`.
- `NucleotideOverlap()`: The core engine that maps `Synteny` hits to `GeneCalls`.
- `PairSummaries()`: The primary tool for orthology prediction and PID calculation.
- `DisjointSet()`: Clusters pairwise data into larger groups (connected components).
- `ExtractBy()`: Helper to pull sequences from the database based on cluster assignments.

## Tips for Success

- **Naming Consistency**: The names of your `GeneCalls` list must exactly match the names in your `Synteny` object (check `dimnames(syn)[[1]]`).
- **Alignment Space**: By default, `PairSummaries` attempts to align in amino acid space if the features are coding. Use `IgnoreDefaultStringSet = TRUE` to force nucleotide alignment.
- **Memory Management**: For very large comparative sets, use `PIDs = FALSE` first to filter candidates before committing to computationally expensive alignments.

## Reference documentation

- [Using SynExtend](./references/UsingSynExtend.md)