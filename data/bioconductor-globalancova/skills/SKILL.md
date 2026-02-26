---
name: bioconductor-globalancova
description: This tool performs statistical testing of differential gene expression in groups of genes using a linear model framework. Use when user asks to perform global tests for association between gene expression profiles and clinical phenotypes, adjust for covariates, test specific pathways or GO terms, and generate diagnostic gene or subject plots.
homepage: https://bioconductor.org/packages/release/bioc/html/GlobalAncova.html
---


# bioconductor-globalancova

name: bioconductor-globalancova
description: Statistical testing of differential gene expression in groups of genes (pathways, GO terms, genomic regions) using Analysis of Covariance (ANCOVA). Use this skill to perform global tests for association between gene expression profiles and clinical phenotypes, adjust for covariates, perform hierarchical testing, and generate diagnostic plots (Gene and Subject plots).

# bioconductor-globalancova

## Overview
The `GlobalAncova` package provides a robust framework for testing whether groups of genes are differentially expressed across different biological conditions. Unlike single-gene tests, it evaluates the intersection of null hypotheses for all genes in a set, increasing power and reducing multiple testing burdens. It uses an extra sum of squares principle within a linear model framework, making it flexible enough to handle categorical groups, continuous variables, time trends, and gene-gene interactions.

## Core Workflow

### 1. Basic Global Testing
To test for differential expression between groups (e.g., ALL vs. AML) for all genes or a specific subset:

```R
library(GlobalAncova)

# Simple group comparison
# xx: expression matrix (genes in rows, samples in columns)
# group: vector defining clinical groups
ga.result <- GlobalAncova(xx = exprs(golubX), group = golubX$ALL.AML, perm = 1000)

# Testing a specific pathway (gene set)
# test.genes: vector of gene identifiers matching rownames of xx
ga.cc <- GlobalAncova(xx = exprs(golubX), group = gr, test.genes = cellcycle, method = "both")
```

### 2. General Linear Model Framework
For complex designs (multiple factors, interactions, or continuous covariates), use formula-based calls:

```R
# Compare a full model to a reduced model
# formula.full: model with the effect of interest
# formula.red: model without the effect of interest (null model)
ga.complex <- GlobalAncova(xx = vantVeer, 
                           formula.full = ~ metastases + ERstatus, 
                           formula.red = ~ ERstatus, 
                           model.dat = phenodata, 
                           test.genes = p53_pathway)
```

### 3. Testing Public Gene Sets (GO and Broad)
The package integrates with `globaltest` to facilitate testing of standard collections:

```R
# Gene Ontology (GO) with focus level procedure (hierarchical adjustment)
gago <- GAGO(xx = exprs(golubX), formula.full = ~ ALL.AML, 
             annotation = "hu6800", ontology = "BP", multtest = "focuslevel")

# Broad Institute Gene Sets (MSigDB)
# Requires loading Broad sets via GSEABase::getBroadSets
ga.broad <- GABroad(xx = exprs(golubX), formula.full = ~ ALL.AML, 
                    category = "c1", collection = broad_sets, annotation = "hu6800")
```

### 4. Diagnostic Visualizations
Use these plots to identify which genes or subjects drive the global significance:

*   **Gene Plot**: Shows the influence of individual genes on the test statistic.
    ```R
    Plot.genes(xx = vantVeer, group = metastases, test.genes = p53)
    ```
*   **Subjects Plot**: Visualizes how well individual samples fit the phenotype pattern.
    ```R
    Plot.subjects(xx = vantVeer, group = metastases, test.genes = p53)
    ```

### 5. Decomposition of Sum of Squares
For multi-factor models, use `GlobalAncova.decomp` to see the contribution of each term (Sequential or Type III):

```R
# Sequential decomposition (order matters)
GlobalAncova.decomp(xx = vantVeer, formula = ~ grade + metastases + ERstatus, 
                    model.dat = phenodata, method = "sequential")

# Type III decomposition (every term adjusted for all others)
GlobalAncova.decomp(xx = vantVeer, formula = ~ grade + metastases + ERstatus, 
                    model.dat = phenodata, method = "type3")
```

### 6. Generalized GlobalAncova (gGlobalAncova)
Use for non-quantitative data (e.g., SNPs, categorical variables) or mixed data types using a likelihood ratio approach:

```R
# Testing binary variables
g.res <- gGlobalAncova(X, formula.full = ~ group, model.dat = bindata, perm = 1000)

# Hierarchical testing (testing subclusters within a dendrogram)
res.hier <- gGlobalAncova.hierarchical(X, H = dendrogram, formula.full = ~ group, 
                                       model.dat = bindata, alpha = 0.05)
```

## Tips and Best Practices
*   **Missing Values**: `GlobalAncova` does not allow missing values in the expression matrix. Impute data or remove genes with NAs before analysis.
*   **P-value Methods**: 
    *   `method = "perm"`: Permutation-based (robust against non-normality/correlations).
    *   `method = "approx"`: Asymptotic approximation (faster for many tests, but limited to group sizes < 2500).
*   **Multiple Testing**: When testing many pathways simultaneously, use `GlobalAncova.closed` for a closed testing procedure that maintains the family-wise error rate without the stringency of Bonferroni.
*   **Global Covariates**: If you have "normal" tissue samples for the same subjects, use the `zz` argument in `GlobalAncova.decomp` to adjust for baseline patient variability.

## Reference documentation
- [GlobalAncova](./references/GlobalAncova.md)
- [GlobalAncovaDecomp](./references/GlobalAncovaDecomp.md)