---
name: bioconductor-srgnet
description: SRGnet analyzes synergistic responses to gene mutations by inferring integrated networks from transcriptomics data. Use when user asks to identify cooperation response genes, analyze regulatory modules downstream of mutations, or infer networks of synergistic gene interactions.
homepage: https://bioconductor.org/packages/3.8/bioc/html/SRGnet.html
---


# bioconductor-srgnet

name: bioconductor-srgnet
description: Analysis of synergistic response to gene mutations (SRG) from transcriptomics data. Use this skill to identify Cooperation Response Genes (CRGs), analyze regulatory modules downstream of CRGs, and infer integrated networks of synergistic gene interactions in R.

# bioconductor-srgnet

## Overview
The `SRGnet` package is designed to study how cooperating oncogenic mutations regulate genes synergistically—where the combined effect of mutations is greater than the sum of individual effects. It provides a pipeline to investigate the network interactions between Cooperation Response Genes (CRGs) and differentially expressed genes (DEGs) to identify downstream regulatory modules and cellular control points.

## Workflow and Usage

### 1. Data Preparation
SRGnet requires three specific inputs to be loaded into the R environment. The package expects these to follow a specific structure:
- **CRG List**: A list of cooperation response genes.
- **DEG List**: Differentially expressed genes and their mean expression values.
- **Transcriptomic Profile**: Expression data across single and combined mutation treatments (e.g., Control, Mutation A, Mutation B, Mutation A+B).

### 2. Loading Example Data
To explore the package functionality using the built-in murine colon cancer model (p53/Ras):
```r
library(SRGnet)
data(Differentially_expressed_genes)
data(Transcriptomics)
data(PLCRG)
```

### 3. Inferring the SRG Network
The primary interface is the `SRGnet()` function. It operates in two modes:
- **Fast Mode ("F")**: Omit the Expectation-Maximization (EM) step for hyperparameter estimation. Recommended for quick iterations.
- **Slow Mode ("S")**: Includes the EM step for more rigorous estimation.

```r
# Run in Fast mode
SRGnet("F")

# Run in Slow mode
SRGnet("S")
```

### 4. Interpreting Results
- **Network Topology**: The function generates the topology of the synergistic response network.
- **Output Files**: Results are typically saved as text files in the working directory, detailing the interactions and integrated network structure.
- **Biological Context**: Use the output to identify which DEGs are regulated by the synergistic action of the input CRGs.

## Tips for Success
- **Input Naming**: Ensure your custom input objects match the naming conventions expected by the function if you are replacing the example datasets.
- **Experimental Design**: The package is optimized for a 2x2 factorial design (Control, Mut1, Mut2, Mut1+Mut2) to properly calculate synergistic effects.
- **Network Inference**: The method uses differential coexpression and discriminant analysis with backward screening to limit complexity and focus on synergistic patterns.

## Reference documentation
- [SRGnet Vignette](./references/vignette.md)