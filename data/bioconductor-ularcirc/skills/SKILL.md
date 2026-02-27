---
name: bioconductor-ularcirc
description: Ularcirc provides a Shiny-based interface for the integrated analysis and visualization of canonical forward splice junctions and backsplice junctions to identify circRNAs. Use when user asks to identify circRNAs, visualize splicing patterns, predict open reading frames, or perform miRNA binding site analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/Ularcirc.html
---


# bioconductor-ularcirc

## Overview
Ularcirc is a Bioconductor package providing a Shiny-based interface for the integrated analysis of canonical forward splice junctions (FSJ) and backsplice junctions (BSJ). It enables researchers to identify circRNAs, visualize splicing patterns at specific gene loci, and perform downstream sequence analysis including Open Reading Frame (ORF) prediction and miRNA binding site identification.

## Installation and Setup
To use Ularcirc, you must install the core package and the relevant organism-specific annotation databases (BSgenome, TxDb, and OrgDb).

```r
# Install core package
if (!requireNamespace("BiocManager", quietly=TRUE)) install.packages("BiocManager")
BiocManager::install("Ularcirc")

# Example: Install hg38 annotation databases
BiocManager::install(c(
  "BSgenome.Hsapiens.UCSC.hg38",
  "TxDb.Hsapiens.UCSC.hg38.knownGene",
  "org.Hs.eg.db"
))
```

## Launching the Application
Ularcirc is primarily an interactive tool. Launch the interface using:

```r
library(Ularcirc)
Ularcirc()
```

## Workflow and Data Input

### 1. Data Preparation
Ularcirc requires specific file extensions to recognize input data:
- **STAR Aligner**: `SJ.out.tab` (FSJ) and `Chimeric.out.junction` (BSJ).
- **circExplorer2**: `.ce`
- **CIRI2**: `.ciri`
- **Regtools**: Supported for junction analysis.

**Note:** All files for a single project should be in one directory. Samples are identified by their common file prefix.

### 2. Loading and Filtering
- **Setup Tab**: Select the organism and load the transcript database.
- **Genomic Filters**: Set constraints for BSJ detection, such as "Same chromosome", "Same strand", and "Chimeric genomic distance" (default 200nt to 100,000nt).
- **circRNA Filters**: 
    - **RAD Score**: Ratio of type II to type III alignments (requires paired-end data).
    - **FSJ Support**: Checks if BSJ coordinates are utilized in canonical forward splicing.

### 3. Project Management
- Use the **Project Tab** to group samples for comparative analysis.
- Define the **Library Prep** (stranded vs. unstranded) to ensure correct sequence assembly.
- Save projects to a local directory to avoid re-processing raw junction files in future sessions.

### 4. Visualization and Analysis
- **Gene_View**: 
    - Select "Tabulated counts" to build BSJ tables.
    - Select "Display gene transcripts" to generate loop graphs and gene models showing integrated FSJ and BSJ data.
- **Junction_View**:
    - Analyze specific junctions selected from tables.
    - Predict circRNA sequences by concatenating exons within BSJ boundaries.
    - Perform **ORF Analysis** to find potential coding sequences.
    - Perform **miRNA Binding Site Analysis** using seed sequence matching (e.g., 7nt seeds).

## Reference documentation
- [Ularcirc: A shiny application for canonical and back splicing analysis](./references/Ularcirc.md)