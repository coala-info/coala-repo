---
name: bioconductor-mirsm
description: The miRSM package identifies and analyzes miRNA sponge modules by integrating expression data with miRNA-target binding information. Use when user asks to identify miRNA sponge modules, infer sample-specific modules, or perform functional and co-expression analysis on identified gene modules.
homepage: https://bioconductor.org/packages/release/bioc/html/miRSM.html
---


# bioconductor-mirsm

name: bioconductor-mirsm
description: Identify and analyze miRNA sponge (ceRNA) modules in heterogeneous data using the miRSM R package. Use this skill to infer gene modules, discover miRNA sponge modules at single-sample or multi-sample levels, and perform functional, cancer, and co-expression analysis on identified modules.

## Overview

The `miRSM` package identifies miRNA sponge modules (groups of RNAs competing for the same miRNAs) by integrating expression data with miRNA-target binding information. It supports both external competition (e.g., lncRNA vs. mRNA) and internal competition (e.g., mRNA vs. mRNA). The workflow typically involves identifying candidate gene modules, filtering them into miRNA sponge modules using sensitivity correlation methods, and performing downstream modular analysis.

## Typical Workflow

### 1. Load Data and Identify Gene Modules
Start by loading matched expression data (miRNA, ceRNA, mRNA) and putative miRNA-target binding information. Use one of the seven module identification functions to find candidate gene modules.

```r
library(miRSM)
data(BRCASampleData)

# Identify modules using WGCNA (example)
modulegenes_WGCNA <- module_WGCNA(ceRExp, mRExp)

# Other methods include:
# module_igraph(ceRExp, mRExp, method = "greedy")
# module_clust(ceRExp, mRExp, method = "kmeans")
# module_biclust(ceRExp, mRExp, method = "fabia")
```

### 2. Discover miRNA Sponge Modules
Filter the candidate gene modules into miRNA sponge modules using the `miRSM` function. This requires miRNA expression data and target information.

```r
# Identify modules using Sensitivity RV Coefficient (SRVC)
miRSM_SRVC <- miRSM(miRExp, ceRExp, mRExp, miRTarget,
                    modulegenes_WGCNA,
                    num_shared_miRNAs = 3,
                    method = "SRVC",
                    SMC.cutoff = 0.01)
```
Available methods for `miRSM`: "SCC", "SDC", "SRVC", "SSI", "SGCD", "SCRC", and "SM".

### 3. Infer Sample-Specific Modules
To identify modules unique to specific samples, use a statistical perturbation strategy (comparing all samples vs. all samples except sample k).

```r
# After generating modules for 'all' and 'except_k' cases:
Modules_SS <- miRSM_SS(Modulegenes_all, Modulegenes_exceptk)
```

### 4. Modular Analysis
Perform downstream analysis to validate and characterize the identified modules.

*   **Functional Analysis**: Perform Enrichment (FEA) or Disease (DEA) analysis.
    ```r
    fea_results <- module_FA(miRSM_SRVC[[2]], Analysis.type = 'FEA')
    ```
*   **Cancer Enrichment**: Test if modules are associated with specific cancer genes.
    ```r
    cea_pvals <- module_CEA(ceRExp, mRExp, BRCA_genes, miRSM_SRVC[[2]])
    ```
*   **Co-expression Analysis**: Verify if ceRNA-mRNA pairs are significantly co-expressed.
    ```r
    coexp_results <- module_Coexpress(ceRExp, mRExp, miRSM_SRVC[[2]], resample = 100)
    ```
*   **Validation**: Compare against groundtruth databases (miRSponge, LncACTdb).
    ```r
    groundtruth <- read.csv("Groundtruth_high.csv")
    validation <- module_Validate(miRSM_SRVC[[2]], groundtruth)
    ```

### 5. Extract Interactions
Extract specific miRNA-target or miRNA-sponge interactions from the modules.

```r
# Identify sharing miRNAs
shared <- share_miRs(miRExp, miRTarget, miRSM_SRVC[[2]])

# Predict miRNA-target interactions
targets <- module_miRtarget(shared, miRSM_SRVC[[2]])

# Extract miRNA sponge interactions
sponge_int <- module_miRsponge(miRSM_SRVC[[2]])
```

## Tips for Success
*   **Method Selection**: `module_igraph` and `module_ProNet` are network-based; `module_clust` and `module_biclust` are clustering-based. Choose based on whether you expect overlapping modules (biclustering) or distinct partitions.
*   **Data Matching**: Ensure the column names (samples) and row names (genes/miRNAs) match across the expression matrices and the target binding list.
*   **Memory Management**: For large datasets, use `module_WGCNA` or `module_igraph` as they are generally more computationally efficient than `module_GFA` or certain biclustering methods.

## Reference documentation
- [miRSM: inferring miRNA sponge modules in heterogeneous data](./references/miRSM.md)