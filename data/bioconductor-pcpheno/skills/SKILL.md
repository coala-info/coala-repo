---
name: bioconductor-pcpheno
description: This tool performs statistical analysis to determine if phenotypic data is significantly associated with cellular organizational units like protein complexes or pathways. Use when user asks to analyze yeast phenotypic datasets, test for phenotype enrichment in protein complexes or KEGG pathways, and perform global association tests using density estimation or graph theory.
homepage: https://bioconductor.org/packages/3.6/bioc/html/PCpheno.html
---


# bioconductor-pcpheno

name: bioconductor-pcpheno
description: Statistical analysis of the relationship between phenotypic data and cellular organizational units (protein complexes, pathways). Use this skill when analyzing yeast phenotypic datasets, testing if specific phenotypes are associated with multi-protein complexes or KEGG pathways, and performing global association tests using density estimation or graph theory.

# bioconductor-pcpheno

## Overview

The `PCpheno` package provides tools to assess whether phenotypic changes (e.g., sensitivity to a drug or environmental condition) are significantly associated with specific cellular organizational units. Instead of focusing on individual genes, it treats multi-protein complexes or pathways as the primary functional units. It includes several built-in yeast phenotypic datasets and integrates with interactome data (like `ScISI`) and KEGG pathways.

## Typical Workflow

### 1. Data Preparation
The package requires phenotypic data (usually a binary matrix or a list of sensitive genes) and an interactome (an adjacency matrix where rows are genes and columns are organizational units).

```R
library(PCpheno)
library(ScISI)
library(org.Sc.sgd.db)

# Load example phenotypic data (Dudley et al.)
data(DudleyPhenoM)

# Extract genes sensitive to a specific condition (e.g., paraquat)
paraquat_genes <- names(which(DudleyPhenoM[, "Paraq"] == 1))

# Load or build an interactome (e.g., ScISI curated complexes)
data(ScISIC)
```

### 2. Global Association Testing
Before identifying specific complexes, use global tests to determine if the phenotype is randomly distributed across the interactome.

**Density Estimation:**
Visualizes the distribution of phenotypic genes across all units compared to a null distribution.
```R
# perm should be higher (e.g., 1000) for publication-quality results
parDensity <- densityEstimate(genename = paraquat_genes, interactome = ScISIC, perm = 100)
plot(parDensity, main = "Density Estimate: Paraquat")
```

**Graph Theory Approach:**
Tests if genes associated with a phenotype cluster together within the organizational units more than expected by chance.
```R
parGraph <- graphTheory(genename = paraquat_genes, interactome = ScISIC, perm = 100)
plot(parGraph, main = "Graph Theory: Paraquat")
```

### 3. Identifying Specific Units (Hypergeometric Test)
To find which specific complexes or pathways are enriched with the phenotype:

```R
params <- new("CoHyperGParams",
              geneIds = paraquat_genes,
              universeGeneIds = rownames(ScISIC),
              annotation = "org.Sc.sgd",
              categoryName = "ScISIC",
              pvalueCutoff = 0.01,
              testDirection = "over")

results <- hyperGTest(params)
summary(results)
```

### 4. Annotation and Interpretation
Classify and annotate the significant units found in the hypergeometric test.

```R
# Identify significant complexes
status <- complexStatus(data = results, phenotype = paraquat_genes, 
                        interactome = ScISIC, threshold = 0.01)

# Get descriptions for GO or MIPS categories
descr <- getDescr(status$A, database = c("GO", "MIPS"))
final_table <- data.frame(descr, pvalues = results@pvalues[status$A])
```

## Key Functions
- `densityEstimate`: Computes smoothed histograms of phenotypic gene proportions across units.
- `graphTheory`: Uses graph intersection and permutation to test for non-random association.
- `hyperGTest`: Performs hypergeometric enrichment analysis (standard Bioconductor pattern).
- `complexStatus`: Categorizes complexes based on significance and phenotypic presence.
- `getDescr`: Retrieves functional descriptions for organizational unit IDs.

## Reference documentation
- [PCpheno](./references/PCpheno.md)