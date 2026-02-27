---
name: bioconductor-rhinotyper
description: This tool automates rhinovirus genotyping and classification using the VP4/2 genomic region. Use when user asks to assign rhinovirus genotypes, align sequences to prototype references, calculate genetic distances, or visualize rhinovirus sequence data.
homepage: https://bioconductor.org/packages/release/bioc/html/rhinotypeR.html
---


# bioconductor-rhinotyper

name: bioconductor-rhinotyper
description: Automate rhinovirus genotyping using the VP4/2 genomic region. Use this skill to perform distance computation, genotype assignment, and visualization of rhinovirus sequence data. It supports both in-R alignment workflows and external alignment integration.

# bioconductor-rhinotyper

## Overview
The `rhinotypeR` package streamlines the identification and classification of rhinoviruses from sequence data. It specifically targets the VP4/2 region (typically ~420 bp). The package automates the comparison of user sequences against standard prototype strains to assign genotypes based on genetic distance thresholds.

## Core Workflows

### 1. Data Preparation and Alignment
Genotype assignment requires an alignment that includes both your query sequences and the package's prototype references.

**Option A: Aligning in R (Recommended for automation)**
Use `alignToRefs()` to automatically append prototypes and align.
```r
library(rhinotypeR)
data(rhinovirusVP4, package = "rhinotypeR")

aln <- alignToRefs(
  seqData   = rhinovirusVP4,
  method    = "ClustalW", # Options: "ClustalW", "ClustalOmega", "Muscle"
  trimToRef = TRUE,       # Crops alignment to the reference span
  refName   = "JN855971.1_A107"
)
```

**Option B: Aligning Externally**
If you prefer external tools (MAFFT, MUSCLE), export the prototypes first.
```r
# Export prototypes to a directory
getPrototypeSeqs("path/to/directory") 

# After external alignment, read back into R
library(Biostrings)
aln_curated <- readDNAStringSet("path/to/aligned_file.fasta")
```

### 2. Genotype Assignment
The `assignTypes()` function is the primary tool for classification.
```r
# Default threshold is 0.105 (10.5% distance)
results <- assignTypes(aln, model = "IUPAC", threshold = 0.105)

# View results: query ID, assignedType, distance, and reference used
head(results)
```

### 3. Distance Analysis
Calculate genetic diversity within your dataset.
```r
# Pairwise distance matrix
dist_matrix <- pairwiseDistances(rhinovirusVP4, model = "IUPAC")

# Overall mean distance (diversity metric)
mean_dist <- overallMeanDistance(rhinovirusVP4, model = "IUPAC")
```

### 4. Visualization
`rhinotypeR` provides several plotting functions for results and quality control.
```r
# Frequency of assigned genotypes
plotFrequency(results)

# Heatmap of pairwise distances
plotDistances(dist_matrix)

# Phylogenetic tree from distances
plotTree(dist_matrix)

# SNP visualization (Nucleotide level)
SNPeek(rhinovirusVP4)

# Amino Acid visualization (Requires AAStringSet)
# Note: Use Biostrings::translate() on gap-free DNA first
plotAA(aa_aln)
```

## Tips and Troubleshooting
- **Sequence Length:** Ensure sequences are homologous and ideally ≥350 bp.
- **Missing Prototypes:** `assignTypes()` will fail if prototypes are not in the alignment. Always use `alignToRefs()` or manually merge prototypes using `getPrototypeSeqs()`.
- **Trimming:** Use `trimToRef = TRUE` in `alignToRefs()` to remove flanking regions that might interfere with distance calculations.
- **Global Gaps:** Use `deleteMissingDataSites()` or the `deleteGapsGlobally = TRUE` argument in functions to perform global gap deletion if gaps are distorting distances.

## Reference documentation
- [Introduction to rhinotypeR](./references/rhinotypeR.md)
- [rhinotypeR Vignette Source](./references/rhinotypeR.Rmd)