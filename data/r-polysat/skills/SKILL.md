---
name: r-polysat
description: The r-polysat tool provides a suite of R functions for analyzing polyploid microsatellite data with ambiguous allele copy numbers and mixed ploidy levels. Use when user asks to import or export microsatellite data, estimate ploidy, calculate genetic distances using Bruvo or Lynch metrics, estimate allele frequencies, or assign alleles to isoloci in allopolyploids.
homepage: https://cloud.r-project.org/web/packages/polysat/index.html
---

# r-polysat

name: r-polysat
description: Tools for polyploid microsatellite analysis in R. Use this skill when you need to import, export, or analyze microsatellite data with ambiguous allele copy numbers, mixed ploidy, or allopolyploid/autopolyploid inheritance. It supports data formats like GeneMapper, Structure, SPAGeDi, and GenoDive, and provides methods for genetic distance (Bruvo, Lynch), allele frequency estimation (de Silva), and assigning alleles to isoloci in allopolyploids.

# r-polysat

## Overview
The `polysat` package is designed for microsatellite data where allele copy number is unknown (e.g., a tetraploid genotype "100/104" could be 100/104/104/104, 100/100/104/104, or 100/100/100/104). It handles any ploidy level and mixed-ploidy populations.

## Installation
```R
install.packages("polysat")
library(polysat)
```

## Core Workflow

### 1. Data Import and Setup
`polysat` uses the `genambig` S4 class to store genotypes, ploidy, and population metadata.
- **Import Functions**: `read.GeneMapper()`, `read.Structure()`, `read.GenoDive()`, `read.SPAGeDi()`, `read.POPDIST()`, and `read.STRand()`.
- **Manual Setup**:
```R
# Create a new genambig object
mydata <- new("genambig", samples=c("S1", "S2"), loci=c("L1", "L2"))
# Assign metadata
PopNames(mydata) <- c("North", "South")
PopInfo(mydata) <- c(1, 2)
Ploidies(mydata) <- 4
Usatnts(mydata) <- c(2, 2) # Repeat lengths (e.g., dinucleotide)
```

### 2. Estimating Ploidy
If ploidy is unknown, use `estimatePloidy` to view the maximum number of alleles per sample and assign ploidy values.
```R
mydata <- estimatePloidy(mydata)
```

### 3. Genetic Distances
Calculate pairwise distances between individuals.
- **Bruvo's Distance**: Best for autopolyploids; accounts for mutation (requires `Usatnts`).
- **Lynch's Distance**: Simple band-sharing (presence/absence).
```R
# Bruvo distance matrix
dist_mat <- meandistance.matrix(mydata, distmetric=Bruvo.distance)
# Principal Coordinate Analysis (PCoA)
pca <- cmdscale(dist_mat)
plot(pca[,1], pca[,2])
```

### 4. Allele Frequencies and Differentiation
- **simpleFreq**: Fast, but biased (assumes equal probability for ambiguous copies).
- **deSilvaFreq**: Iterative EM algorithm; more accurate for even-numbered ploidies with known selfing rates.
```R
# Estimate frequencies
freqs <- deSilvaFreq(mydata, self=0.1)
# Calculate Fst, Gst, or Jost's D
fst <- calcPopDiff(freqs, metric="Fst")
```

## Allopolyploid Analysis (Isoloci Assignment)
For allopolyploids, use the `polysat` algorithm to split markers into isoloci (e.g., treating an allotetraploid as two diploid loci).

1. **Correlation Analysis**: Identify negative correlations between alleles.
2. **Assignment**: Use `processDatasetAllo` to test parameter sets.
3. **Recoding**: Create a new diploidized dataset.

```R
# Run the assignment algorithm
myassign <- processDatasetAllo(mydata, n.subgen=2, SGploidy=2, usePops=TRUE)
# Recode the dataset based on best assignments
recodedData <- recodeAllopoly(mydata, myassign$bestAssign)
```

## Tips for Success
- **Data Hygiene**: Remove duplicate genotypes and samples with more alleles than the expected ploidy before analysis.
- **Mixed Ploidy**: `meandistance.matrix2` is recommended for mixed-ploidy Bruvo distances as it models allele copy number probabilities.
- **Exporting**: Use `write.Structure()`, `write.GenoDive()`, or `write.GeneMapper()` to share data with other software.

## Reference documentation
- [Assigning alleles to isoloci in polysat](./references/allopolyVignette.md)
- [polysat Tutorial Manual](./references/polysattutorial.md)