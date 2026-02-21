---
name: bioconductor-genega
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GeneGA.html
---

# bioconductor-genega

name: bioconductor-genega
description: Optimize gene expression by balancing codon bias and mRNA secondary structure using Genetic Algorithms (GA). Use this skill when you need to perform codon optimization for heterologous gene expression, calculate Codon Adaptation Index (CAI), or minimize mRNA folding energy (MFE) for specific gene sequences in R.

## Overview

GeneGA is a Bioconductor package designed to optimize gene sequences for high-level protein expression. Unlike tools that only consider codon bias, GeneGA uses a Genetic Algorithm to optimize the trade-off between the Codon Adaptation Index (CAI) and mRNA minimum free energy (MFE). It supports specific optimizations for "ramp" regions (the first 30-50 codons) to reduce ribosomal traffic jams and allows for organism-specific optimization using a built-in dataset of ~200 genomes.

## Core Workflows

### 1. Sequence Preparation
Input sequences should be character strings or loaded from FASTA files. Ensure the sequence is an Open Reading Frame (ORF) and the length is a multiple of three.

```r
library(GeneGA)
library(seqinr)

# Load sequence from FASTA
seqfile <- system.file("sequence", "EGFP.fasta", package="GeneGA")
seq <- unlist(getSequence(read.fasta(seqfile), as.string=TRUE))
```

### 2. Running Optimization
There are three primary optimization functions depending on the objective:

*   `GeneGA()`: Optimizes both CAI and MFE.
*   `GeneFoldGA()`: Optimizes only for the largest MFE (least stable secondary structure).
*   `GeneCodon()`: Optimizes only for codon bias.

```r
# Optimize the first 60 bp for E. coli ('ec')
result <- GeneGA(sequence = seq, 
                 popSize = 40, 
                 iters = 150, 
                 crossoverRate = 0.3, 
                 mutationChance = 0.05, 
                 region = c(1, 60), 
                 organism = "ec")
```

### 3. Analyzing Results
Use `show()` to view the top three optimized sequences and `plotGeneGA()` to visualize the GA convergence.

```r
# Display top sequences, CAI, and MFE values
show(result)

# Plotting options:
# type=1: Evaluation values vs Generation
# type=2: CAI and MFE vs Generation
# type=3: CAI vs MFE
plotGeneGA(result, type = 1)
```

### 4. Customizing Codon Weights (w table)
If the target organism is not in `wSet`, calculate a custom `w` table using highly expressed genes.

```r
# Example logic for custom w table calculation
# 1. Calculate RSCU for highly expressed genes
# 2. Normalize RSCU by the maximum RSCU for that amino acid
# 3. Use the resulting vector as the 'w' table
```

## Key Parameters

*   `region`: A vector `c(start, end)` specifying which part of the gene to optimize via GA. Outside this region, the most preferred codons are used.
*   `ramp`: If TRUE, optimizes the first 30-50 codons to have lower translation efficiency (lower CAI) to prevent ribosomal jams.
*   `organism`: String code (e.g., "ec" for E. coli, "sc" for S. cerevisiae). See `data(wSet)` for available genomes.
*   `frontSeq`: Allows adding a 5' regulatory sequence that is considered during MFE calculation but not mutated.

## Tips for Success

*   **External Dependency**: This package requires the **Vienna RNA Package** (specifically the `fold` function) to be installed on the system path to calculate MFE.
*   **Convergence**: For longer sequences or regions, increase `popSize` and `iters`.
*   **Ramp Region**: If the `region` and `ramp` intersect, GeneGA automatically adjusts the objective function to favor lower CAI in the ramp and higher CAI elsewhere, while maintaining high MFE throughout.

## Reference documentation
- [Optimizing gene expression with GeneGA](./references/GeneGA.md)