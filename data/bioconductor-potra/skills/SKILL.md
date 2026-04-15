---
name: bioconductor-potra
description: PoTRA identifies dysregulated biological pathways by analyzing changes in the topological importance of genes within gene-gene correlation networks using the PageRank algorithm. Use when user asks to detect disease-involved pathways, identify hub genes, or compare pathway topological ranks between normal and disease phenotypes.
homepage: https://bioconductor.org/packages/3.9/bioc/html/PoTRA.html
---

# bioconductor-potra

## Overview

PoTRA (Pathways of Topological Rank Analysis) is an R package used to identify pathways involved in disease by analyzing the topological importance of genes within biological networks. It utilizes the PageRank algorithm to measure the relative rank of genes in a pathway. 

The package provides two primary statistical methods to detect dysregulation:
1. **Fisher's Exact Test**: Determines if the number of "hub genes" (top-ranked genes) in a pathway significantly changes between normal and disease states.
2. **Kolmogorov-Smirnov (KS) Test**: Detects shifts in the overall distribution of gene topological ranks within a pathway between two phenotypes.

PoTRA is compatible with major pathway databases including KEGG, Reactome, BioCarta, NCI, SMPDB, and PharmGKB via the `graphite` library.

## Core Workflow

### 1. Data Requirements
*   **Expression Data**: A dataframe where rows are genes (Entrez IDs) and columns are samples.
*   **Sample Distribution**: Samples should be ordered with control/normal samples first, followed by case/disease samples. A minimum of 50 samples per group is recommended for statistical power.
*   **Gene Coverage**: A minimum of 18,000 genes is recommended.

### 2. Loading Pathway Databases
PoTRA relies on the `graphite` package to provide pathway topologies.

```r
library(PoTRA)
library(graphite)

# Load human KEGG pathways
pathway_db <- pathways("hsapiens", "kegg")
```

### 3. Running the Analysis
The main function is `PoTRA.corN`. It constructs gene-gene correlation networks for each phenotype and calculates topological ranks.

```r
# Example execution
results <- PoTRA.corN(mydata = expression_df, 
                      genelist = entrez_vector, 
                      Num.sample.normal = 113, 
                      Num.sample.case = 113, 
                      Pathway.database = pathway_db[1:20], 
                      PR.quantile = 0.95)
```

**Key Parameters:**
*   `mydata`: The gene expression dataframe.
*   `genelist`: Vector of Entrez gene identifiers.
*   `Num.sample.normal`: Integer count of control samples.
*   `Num.sample.case`: Integer count of disease samples.
*   `Pathway.database`: A list of pathways from `graphite`.
*   `PR.quantile`: The percentile cutoff for defining hub genes (default 0.95).

### 4. Interpreting Results
The output is a list containing several vectors:
*   `Fishertest.p.value`: P-values indicating if the proportion of hub genes changed.
*   `KStest.p.value`: P-values indicating if the rank distribution changed.
*   `PathwayName`: The names of the analyzed pathways.
*   `TheNumberOfHubGenes.normal/case`: Counts of hub genes identified in each state.
*   `TheNumberOfEdges.normal/case`: Network density in each state.

## Advanced Usage: Meta-Analysis
When working with multiple cohorts or datasets, you can aggregate PoTRA results:
1.  **Rank Averaging**: Calculate the average rank of pathways across different runs.
2.  **P-value Integration**: Use the `metap` package (e.g., `sumlog`) to combine Fisher's Exact Test p-values from multiple cohorts to find consistently dysregulated pathways.

## Tips for Success
*   **Gene IDs**: Ensure your row names and `genelist` are Entrez IDs, as most `graphite` databases use this format by default.
*   **Computational Cost**: Running `PoTRA.corN` on hundreds of pathways can be time-consuming because it builds correlation matrices for every pathway. Consider filtering the `Pathway.database` list to relevant pathways if performance is an issue.
*   **Hub Gene Sensitivity**: If the Fisher's test returns many `NA` values or 1.0, consider adjusting the `PR.quantile`.

## Reference documentation
- [PoTRA](./references/PoTRA.md)