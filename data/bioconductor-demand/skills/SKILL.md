---
name: bioconductor-demand
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DeMAND.html
---

# bioconductor-demand

## Overview

DeMAND (Detecting Mechanism of Action based Network Dysregulation) is an algorithm used to identify the mechanism of action of a compound by interrogating a tissue-specific regulatory network. It operates on the hypothesis that while a drug may not change the mRNA levels of its direct targets, it will dysregulate the interactions between those targets and their downstream effectors. 

The tool computes the Kullback-Leibler (KL) divergence of the two-dimensional probability distribution of gene expression levels between control and perturbed states for every edge in a provided interactome. It then performs an enrichment analysis to identify genes whose local network is significantly dysregulated.

## Workflow and Usage

### 1. Data Preparation
DeMAND requires three primary inputs:
*   **Expression Matrix (`exp`)**: A numeric matrix of gene expression (probes/genes as rows, samples as columns).
*   **Annotation (`anno`)**: A 2-column character matrix mapping the expression row names (e.g., probe IDs) to the network node names (e.g., Gene Symbols).
*   **Network (`network`)**: A character matrix where the first two columns represent interacting gene pairs (the interactome).

### 2. Initializing the DeMAND Object
Use the `demandClass` constructor to bundle the input data.

```r
library(DeMAND)

# Load example data or provide your own
data(inputExample)

# Create the object
dobj <- demandClass(exp=bcellExp, anno=bcellAnno, network=bcellNetwork)

# Check object status
printDeMAND(dobj)
```

### 3. Running the Analysis
The `runDeMAND` function performs the KL divergence calculation and statistical testing. You must provide the column indices for the treated (case) and control (background) samples.

```r
# fgIndex: indices for drug-treated samples (N > 3)
# bgIndex: indices for control samples (N > 3)
dobj <- runDeMAND(dobj, fgIndex=caseIndex, bgIndex=controlIndex)
```

### 4. Interpreting Results
After running the analysis, the `demand` object is updated with MoA predictions.

*   **MoA Genes**: Access the ranked list of candidate mechanism of action genes using `dobj@moa`. Results include P-values and FDR.
*   **Edge Dysregulation**: Access the dysregulation scores for individual interactions using `dobj@KLD`.

```r
# View top candidate MoA genes
head(dobj@moa)

# View dysregulated edges
head(dobj@KLD)
```

## Implementation Tips
*   **Sample Size**: Ensure at least 4 samples per condition (case and control) for reliable estimation of the probability distributions.
*   **Network Selection**: The accuracy of DeMAND is highly dependent on the quality and context-specificity of the input interactome. Use tissue-specific networks (e.g., from ARACNe) when possible.
*   **Gene Identifiers**: Ensure the second column of the `anno` matrix perfectly matches the naming convention used in the `network` matrix.

## Reference documentation
- [DeMAND](./references/DeMAND.md)