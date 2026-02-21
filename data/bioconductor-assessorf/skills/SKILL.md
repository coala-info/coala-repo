---
name: bioconductor-assessorf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/AssessORF.html
---

# bioconductor-assessorf

name: bioconductor-assessorf
description: Assessment of gene predictions (ORFs) using proteomics and evolutionary conservation data. Use this skill to map evidence to a central genome, categorize predicted genes based on supporting or contradictory evidence, and compare different gene prediction sets (e.g., Prodigal vs. GeneMarkS-2).

# bioconductor-assessorf

## Overview

AssessORF is a tool for evaluating the quality of ab initio gene predictions in prokaryotic genomes. It uses two primary forms of evidence:
1. **Proteomics**: Mapping peptide sequences to the genome to confirm translation and identify start site contradictions.
2. **Evolutionary Conservation**: Aligning related genomes to check if predicted starts and stops are conserved across strains.

The workflow involves creating a "mapping object" (data alignment) and then a "results object" (gene categorization).

## Workflow and Key Functions

### 1. Data Preparation
Genomes must be stored in a SQL database using the `DECIPHER` package.

```r
library(DECIPHER)
library(AssessORF)

db <- tempfile()
# Add central genome (ID "1") and related genomes (IDs "2", "3", etc.)
Seqs2DB("path/to/central.fasta", "FASTA", db, "1")
Seqs2DB("path/to/related_1.fasta", "FASTA", db, "2")
```

### 2. Creating the Mapping Object
The `MapAssessmentData` function aligns evidence to the genome. This object is independent of specific gene predictions and can be reused.

```r
myMapObj <- MapAssessmentData(
  databaseFile = db,
  central_ID = "1",
  related_IDs = c("2", "3"),
  speciesName = "Species Name",
  useProt = FALSE # Set to TRUE if providing protHits_Seqs and protHits_Scores
)
```

### 3. Generating the Results Object
Map your predicted genes (from Prodigal, Glimmer, etc.) to the mapping object using `AssessGenes`.

```r
# Genes must be parsed into left, right, and strand vectors
# Note: left/right are always forward strand coordinates
myResObj <- AssessGenes(
  geneLeftPos = left_vector,
  geneRightPos = right_vector,
  geneStrand = strand_vector, # "+" or "-"
  inputMapObj = myMapObj,
  geneSource = "Prodigal"
)
```

### 4. Viewing and Interpreting Results
AssessORF provides several visualization methods:

*   **Summary**: `print(myResObj)` shows accuracy scores and counts for categories like `Y CS+ PE+` (Strongly supported) or `Y CS! PE+` (Likely incorrect).
*   **Distribution**: `plot(myResObj)` creates a bar chart of category assignments.
*   **Genome Viewer**: `plot(myMapObj, myResObj)` shows evidence alignment (magenta: starts, cyan: stops, blue/red: proteomics). Use `interactive_GV = TRUE` for navigation.
*   **Length Analysis**: `mosaicplot(myResObj)` shows how accuracy varies by gene length.

### 5. Comparing Prediction Sets
To determine which gene finder performed better on a specific genome:

```r
CompareAssessmentResults(resObj_Prodigal, resObj_GeneMark)
```

## Tips for Success
*   **Coordinate System**: Ensure gene boundaries are 1-based. For reverse strand genes, the "left" position is the stop codon and the "right" position is the start codon (in forward strand terms).
*   **Related Genomes**: For evolutionary conservation, use at least a few dozen non-partial genomes from the same genus for best results.
*   **Reusability**: Save your mapping objects (`saveRDS`) to avoid re-running the computationally expensive alignment step when testing different gene prediction parameters.

## Reference documentation
- [Using AssessORF](./references/UsingAssessORF.md)