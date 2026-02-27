---
name: bioconductor-lymphoseq
description: This tool analyzes high-throughput sequencing data of T-cell and B-cell receptors to characterize immune repertoires. Use when user asks to import ImmunoSEQ or MiXCR data, calculate repertoire diversity metrics like clonality and Gini coefficients, track clones across samples, or analyze V(D)J gene usage.
homepage: https://bioconductor.org/packages/release/bioc/html/LymphoSeq.html
---


# bioconductor-lymphoseq

name: bioconductor-lymphoseq
description: Analyze high-throughput sequencing of T and B cell receptors (TCR/BCR). Use this skill to import ImmunoSEQ or MiXCR data, calculate repertoire diversity (clonality, Gini coefficient), track clones across samples, perform sequence alignments, and search for published sequences with known antigen specificity.

# bioconductor-lymphoseq

## Overview
LymphoSeq is a Bioconductor package designed for the analysis of T-cell receptor (TCR) and B-cell receptor (BCR) repertoires. It primarily supports data from Adaptive Biotechnologies' ImmunoSEQ assay but is adaptable to other platforms like MiXCR or IMGT/HighV-QUEST. The package facilitates workflows for data cleaning, diversity analysis, comparative immunology, and visualization.

## Typical Workflow

### 1. Data Import
Import `.tsv` files (ImmunoSEQ v2 format).
```r
library(LymphoSeq)
# Path to directory containing .tsv files
path <- system.file("extdata", "TCRB_sequencing", package = "LymphoSeq")
study_list <- readImmunoSeq(path = path)
```

### 2. Data Cleaning and Subsetting
Filter for productive sequences (in-frame, no stop codons) and aggregate by amino acid or nucleotide.
```r
# Aggregate by amino acid to sum counts of identical CDR3s
productive_aa <- productiveSeq(file.list = study_list, aggregate = "aminoAcid")

# Subset list based on sample names
sub_list <- study_list[grep("CD8", names(study_list))]
```

### 3. Repertoire Diversity
Calculate summary statistics including Shannon entropy, clonality, and Gini coefficient.
```r
stats <- clonality(file.list = study_list)
# Visualize with a Lorenz curve
lorenzCurve(samples = names(productive_aa), list = productive_aa)
```

### 4. Comparative Analysis
Compare repertoires between samples using overlap metrics or differential abundance.
```r
# Pairwise similarity matrix
sim_matrix <- similarityMatrix(productive.seqs = productive_aa)
pairwisePlot(matrix = sim_matrix)

# Differential abundance between two timepoints
diff_exp <- differentialAbundance(list = productive_aa, 
                                  sample1 = "Day0", 
                                  sample2 = "Day100", 
                                  type = "aminoAcid")
```

### 5. Sequence Tracking and Searching
Track specific clones across multiple samples or search against known databases.
```r
# Search for a specific CDR3
searchSeq(list = productive_aa, sequence = "CASSPVSNEQFF", type = "aminoAcid")

# Search for published sequences with known antigen specificity
published <- searchPublished(list = productive_aa)

# Track clones across samples
seq_matrix <- seqMatrix(productive.aa = productive_aa, sequences = uniqueSeqs(productive_aa)$aminoAcid)
cloneTrack(sequence.matrix = seq_matrix, productive.aa = productive_aa)
```

### 6. V(D)J Gene Usage
Analyze and visualize gene frequency and associations.
```r
v_genes <- geneFreq(productive.nt = study_list, locus = "V", family = TRUE)

# Chord diagram for VJ associations
top_seqs <- topSeqs(productive.seqs = study_list, top = 1)
chordDiagramVDJ(sample = top_seqs, association = "VJ")
```

## Tips and Best Practices
- **File Formats**: Ensure non-ImmunoSEQ files have identical column names to the ImmunoSEQ v2 standard.
- **Aggregation**: Use `aggregate = "aminoAcid"` in `productiveSeq` when focusing on functional protein products, as multiple nucleotide sequences can encode the same CDR3.
- **Memory Management**: For very large datasets, import only necessary columns using the `columns` parameter in `readImmunoSeq`.
- **Visualization**: Most plots are built on `ggplot2` and can be further customized using standard ggplot layers (e.g., `+ theme_bw()`).

## Reference documentation
- [Analysis of high-throughput sequencing of T and B cell receptors with LymphoSeq](./references/LymphoSeq.md)