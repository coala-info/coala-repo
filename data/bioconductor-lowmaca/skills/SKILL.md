---
name: bioconductor-lowmaca
description: LowMACA identifies functional protein regions and mutation hotspots by aggregating and analyzing mutation data across protein families or Pfam domains using consensus alignment. Use when user asks to identify conserved mutation clusters, perform consensus alignment of protein families, calculate mutation entropy scores, or visualize mutation distribution across protein domains.
homepage: https://bioconductor.org/packages/3.8/bioc/html/LowMACA.html
---


# bioconductor-lowmaca

## Overview

LowMACA (Low frequency Mutation Analysis via Consensus Alignment) is a statistical framework for identifying functional regions in proteins by aggregating mutation data across protein families. By aligning similar proteins (e.g., the RAS family) or proteins sharing a Pfam domain, LowMACA can identify "hotspots" that are infrequently mutated in a single gene but highly conserved and frequently mutated across the entire family.

## System Requirements

LowMACA requires two external tools to be available in your system PATH:
- **Clustal Omega (clustalo)**: For sequence alignment.
- **Ghostscript (gs)**: For generating logo plots and grImport graphics.

If `clustalo` is not in your PATH, set it manually:
```r
lmParams(lm)$clustal_cmd <- "/path/to/clustalo"
```

## Core Workflow

### 1. Object Initialization
Create a LowMACA object by specifying genes, a Pfam domain, or both.
- If only `genes` are provided: Analyzes the entire protein sequences.
- If only `pfam` is provided: Analyzes all proteins containing that domain.
- If both are provided: Analyzes the specified domain within the specified genes.

```r
library(LowMACA)
# Example: Homeodomain fold
Genes <- c("ADNP", "ALX1", "ALX4", "ARGFX")
Pfam <- "PF00046"
lm <- newLowMACA(genes=Genes, pfam=Pfam)
```

### 2. Parameter Configuration
Adjust parameters such as mutation types (default: "missense") or tumor types.
```r
# View defaults
lmParams(lm)

# Filter for specific tumors (use showTumorType() for codes)
lmParams(lm)$tumor_type <- c("skcm", "luad", "brca")

# Include sequences even with 0 mutations
lmParams(lm)$min_mutation_number <- 0
```

### 3. Setup (Alignment and Data Retrieval)
The `setup` function is a wrapper that runs `alignSequences`, `getMutations`, and `mapMutations` in sequence.
- **Note**: If you don't have Clustal Omega installed locally, provide an email to use the EBI web service.

```r
# Standard setup
lm <- setup(lm)

# Using web service and custom local mutation data
# repos must be a data.frame with columns: Entrez, Gene_Symbol, Amino_Acid_Letter, 
# Amino_Acid_Position, Amino_Acid_Change, Mutation_Type, Sample, Tumor_Type
lm <- setup(lm, mail="your@email.com", repos=myCustomData)
```

### 4. Statistical Analysis
Calculate the entropy score to identify non-random mutation clustering.
```r
lm <- entropy(lm)

# Retrieve significant mutations (Low Frequency Mutations)
sig_muts <- lfm(lm)
```

### 5. Visualization
LowMACA provides several plotting methods to interpret the consensus alignment and mutation distribution.

```r
# Barplot of mutations across the consensus
bpAll(lm)

# Comprehensive 4-layer plot (Mutations, P-values, Conservation, Logo)
lmPlot(lm)

# Protter-style sequence structure plot (requires internet)
protter(lm, filename="output.png")
```

## Data-Driven Workflow
To analyze an entire dataset of mutations and automatically identify all enriched Pfams:
```r
# myData is a data.frame of mutations
results <- allPfamAnalysis(repos=myData)

# results$AlignedSequence contains significant mutations from family analysis
# results$SingleSequence contains significant mutations from single gene analysis
```

## Reference documentation
- [LowMACA: Low frequency Mutation Analysis via Consensus Alignment](./references/LowMACA.md)