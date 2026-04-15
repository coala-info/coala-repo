---
name: bioconductor-spia
description: The SPIA package implements the Signaling Pathway Impact Analysis algorithm to identify significant pathways by combining gene enrichment with pathway topology and expression magnitude. Use when user asks to perform pathway analysis using gene fold changes, calculate pathway perturbation p-values, or incorporate network topology into enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/SPIA.html
---

# bioconductor-spia

## Overview

The `SPIA` package implements the Signaling Pathway Impact Analysis algorithm. Unlike standard enrichment methods that only look at gene counts (ORA), SPIA incorporates the magnitude of expression changes (log2 fold changes) and the topology of the pathway (how genes interact). It calculates two independent p-values: `pNDE` (enrichment based on the number of DE genes) and `pPERT` (enrichment based on the amount of perturbation accumulation in the network), which are then combined into a global p-value (`pG`).

## Core Workflow

### 1. Data Preparation
SPIA requires two specific input vectors:
- **de**: A named numeric vector of log2 fold changes for differentially expressed genes. Names must be **Entrez IDs**.
- **all**: A character vector of Entrez IDs for all genes tested in the experiment (the "background" or "universe").

```r
library(SPIA)

# Example: Creating the 'de' vector
# tg1 is a data frame of DEGs with 'logFC' and 'ENTREZ' columns
de_vector <- tg1$logFC
names(de_vector) <- as.character(tg1$ENTREZ)

# Example: Creating the 'all' vector
all_genes <- as.character(top_table$ENTREZ)
```

### 2. Running SPIA
The `spia` function is the primary interface.

```r
res <- spia(de = de_vector, 
            all = all_genes, 
            organism = "hsa", 
            nB = 2000,           # Number of bootstrap iterations
            plots = FALSE,       # Set TRUE to generate perturbation plots
            combine = "fisher")  # "fisher" or "norminv"
```

### 3. Interpreting Results
The output is a data frame ranked by significance. Key columns include:
- `pNDE`: P-value for over-representation.
- `pPERT`: P-value for pathway perturbation.
- `pG`: Combined global p-value.
- `pGFdr` / `pGFWER`: Adjusted global p-values.
- `Status`: Indicates if the pathway is "Activated" or "Inhibited" based on the net perturbation accumulation (`tA`).

### 4. Visualization
Use `plotP` to visualize the distribution of pathways based on the two types of evidence.

```r
# Plot all pathways; significant ones (after Bonferroni) are in red
plotP(res, threshold = 0.05)

# Highlight a specific pathway (e.g., Colorectal cancer ID "05210")
points(I(-log(pPERT)) ~ I(-log(pNDE)), 
       data = res[res$ID == "05210", ], 
       col = "green", pch = 19, cex = 1.5)
```

## Advanced Usage

### Custom KEGG Data
Since KEGG requires a license for up-to-date FTP access, you can parse your own downloaded KGML (XML) files:

```r
# Parse KGML files in a directory
makeSPIAdata(kgml.path = "./my_kgml_files", organism = "hsa", out.path = "./")

# Run SPIA using the local data
res <- spia(de = de_vector, all = all_genes, organism = "hsa", data.dir = "./")
```

### Adjusting Interaction Weights
SPIA uses `beta` coefficients to weight different types of interactions (e.g., phosphorylation, inhibition). You can view or modify these:

```r
# Default weights
rel <- c("activation", "inhibition")
beta <- c(1, -1)
names(beta) <- rel

# Pass to spia function
res <- spia(..., beta = beta)
```

## Tips
- **Entrez IDs**: SPIA is strictly designed for Entrez Gene IDs. Ensure your annotation step is accurate.
- **nB Parameter**: For publication-quality results, use `nB >= 2000`.
- **Organism Codes**: Use standard KEGG three-letter codes (e.g., "hsa" for human, "mmu" for mouse, "rno" for rat).

## Reference documentation
- [SPIA](./references/SPIA.md)