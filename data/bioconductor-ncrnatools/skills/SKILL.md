---
name: bioconductor-ncrnatools
description: ncRNAtools provides a comprehensive toolkit for identifying non-coding RNAs and predicting their secondary structures using various algorithms. Use when user asks to search the RNAcentral database, predict RNA secondary structures with or without pseudoknots, visualize base pair probability matrices, or read and write RNA structure file formats.
homepage: https://bioconductor.org/packages/release/bioc/html/ncRNAtools.html
---

# bioconductor-ncrnatools

## Overview
The `ncRNAtools` package provides a comprehensive toolkit for the identification and structural analysis of non-coding RNAs (ncRNAs). It integrates with the RNAcentral database for sequence retrieval and utilizes the rtools web server for secondary structure predictions. Key capabilities include keyword and coordinate-based searches, prediction of canonical and alternative secondary structures, and robust I/O support for common RNA structure formats like CT and Dot-Bracket.

## Core Workflows

### 1. Searching RNAcentral
You can search for ncRNA entries using either text queries or genomic coordinates.

**Keyword Search:**
```r
library(ncRNAtools)
# Search by name or specific fields (use capitalized logical operators)
ids <- rnaCentralTextSearch("HOTAIR AND species:\"Homo sapiens\"")

# Retrieve detailed metadata for a specific accession
entry <- rnaCentralRetrieveEntry(ids[1])
# Access sequence: entry$sequence
```

**Genomic Coordinate Search:**
Requires a `GRanges` object and the scientific name of the organism.
```r
library(GenomicRanges)
query_range <- GRanges(seqnames = "chrC", ranges = IRanges(200000, 300000))
hits <- rnaCentralGenomicCoordinatesSearch(query_range, "Yarrowia lipolytica")
```

### 2. Predicting Secondary Structure
The package supports multiple prediction algorithms via the `predictSecondaryStructure` function.

*   `centroidFold`: General purpose centroid estimator.
*   `centroidHomFold`: Uses homologous sequence information for better accuracy.
*   `IPknot`: Fast prediction that **supports pseudoknots**.

```r
seq <- "UGCGAGAGGCACAGGGUUCGAUUCCCUGCAUCUCCA"

# Predict canonical structure
fold <- predictSecondaryStructure(seq, method = "IPknot")
# fold$secondaryStructure contains the Dot-Bracket string

# Predict alternative structures (RintW method)
alt_folds <- predictAlternativeSecondaryStructures(seq)
```

### 3. Visualizing Base Pair Probabilities
You can assess structural confidence by plotting probability matrices.

```r
# Generate matrix from prediction results
prob_mat <- generatePairsProbabilityMatrix(fold$basePairProbabilities)

# Plot heatmap
plotPairsProbabilityMatrix(prob_mat)

# Composite plot: Probabilities (top-right) vs. Predicted Structure (bottom-left)
paired <- findPairedBases(sequence = seq, secondaryStructureString = fold$secondaryStructure)
plotCompositePairsMatrix(prob_mat, paired)
```

### 4. File I/O and Format Conversion
`ncRNAtools` handles the two most common RNA structure formats.

**Dot-Bracket (.dot):**
```r
# Reading
db_data <- readDotBracket("path/to/file.dot")

# Writing
writeDotBracket("output.dot", sequence = seq, secondaryStructure = ".((...)).", sequenceName = "RNA_ID")

# Flattening extended Dot-Bracket (removes pseudoknot notation for compatibility)
simple_db <- flattenDotBracket("...((..[[..))..]]")
```

**Connect Table (.ct):**
```r
# Reading (provide sequence if the CT file only contains paired bases)
ct_data <- readCT("path/to/file.ct", sequence = seq)

# Convert pairs table to Dot-Bracket string
db_string <- pairsToSecondaryStructure(ct_data$pairsTable, sequence = seq)

# Writing
writeCT("output.ct", sequence = seq, secondaryStructure = db_string, sequenceName = "RNA_ID")
```

## Tips and Best Practices
*   **Pseudoknots:** Always use `method = "IPknot"` if you suspect the RNA contains pseudoknots (nested structures).
*   **RNAcentral Fields:** When using `rnaCentralTextSearch`, ensure logical operators (AND, OR, NOT) are capitalized.
*   **Coordinate Formats:** For genomic searches, ensure chromosome names follow the `chr?` or `?` format (e.g., "chr1" or "1"). Use "MT" for mitochondrial DNA.
*   **Web Dependency:** Prediction functions and RNAcentral searches require an active internet connection as they query external servers (rtools and RNAcentral API).

## Reference documentation
- [ncRNAtools](./references/ncRNAtools.md)
- [ncRNAtools Vignette](./references/ncRNAtools.Rmd)