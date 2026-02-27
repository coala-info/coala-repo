---
name: bioconductor-pcxndata
description: This tool provides pre-computed correlation coefficients and p-values between gene sets from major collections like MSigDB and Pathprint. Use when user asks to retrieve pathway correlation data, account for shared genes between pathway pairs, or perform pathway network analysis.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/pcxnData.html
---


# bioconductor-pcxndata

name: bioconductor-pcxndata
description: Access and utilize the pcxnData package, which provides correlation coefficients and p-values between pre-defined gene sets (MSigDB Hallmark, C2 CP, C5 GO BP, and Pathprint). Use this skill when a user needs to retrieve pathway correlation data, account for shared genes between pathway pairs (adjusted vs. unadjusted), or perform pathway network analysis in R using the pcxn ecosystem.

## Overview

The `pcxnData` package is a data experiment package for Bioconductor that serves as the data backbone for the `pcxn` (Pathway Co-expression Network) analysis framework. It contains pre-computed correlation matrices for several major gene set collections. A key feature of this data is the availability of "adjusted" correlations, which account for the bias introduced by shared gene members between different pathways, providing a more accurate measure of biological co-expression.

## Loading Data

To use the data, you must load both the data package and the analysis engine (`pcxn`).

```R
library(pcxn)
library(pcxnData)

# List of available datasets in pcxnData
ds <- c("pathCor_CPv5.1_dframe", 
        "pathCor_GOBPv5.1_dframe", 
        "pathCor_Hv5.1_dframe", 
        "pathCor_pathprint_v1.2.3_dframe",
        "pathCor_CPv5.1_unadjusted_dframe",
        "pathCor_GOBPv5.1_unadjusted_dframe",
        "pathCor_Hv5.1_unadjusted_dframe",
        "pathCor_pathprint_v1.2.3_unadjusted_dframe")

# Load specific datasets into the environment
data(list = ds)
```

## Typical Workflows

### 1. Exploring Pathway Neighbors
Use `pcxn_explore` to find the most correlated neighbors for a specific query pathway within a collection (e.g., "pathprint", "cp", "go", or "h").

```R
pcxn.obj <- pcxn_explore(collection = "pathprint",
                         query_geneset = "Alzheimer's disease (KEGG)",
                         adj_overlap = FALSE,
                         top = 10,
                         min_abs_corr = 0.05,
                         max_pval = 0.05)
```

### 2. Analyzing Relationships Between Groups
Use `pcxn_analyze` to study correlations between two sets of pathways (e.g., pathways enriched in different experimental phenotypes).

```R
pcxn.obj <- pcxn_analyze(collection = "pathprint",
                         phenotype_0_genesets = c("ABC transporters (KEGG)", "ACE Inhibitor Pathway (Wikipathways)"),
                         phenotype_1_genesets = c("DNA Repair (Reactome)"),
                         adj_overlap = FALSE,
                         top = 10)
```

### 3. Visualization and Gene Membership
Once a `pcxn` object is created, you can visualize the network as a heatmap or extract the specific genes belonging to a pathway.

```R
# Generate a heatmap
hm <- pcxn_heatmap(pcxn.obj, cluster_method = "complete")

# Get Entrez IDs and Symbols for a pathway
gene_members <- pcxn_gene_members(pathway_name = "Alzheimer's disease (KEGG)")
```

## Tips for Usage
- **Adjusted vs. Unadjusted**: Use `adj_overlap = TRUE` (default in many functions) to use correlations that have been adjusted for shared gene content. This is generally preferred for biological interpretation.
- **Collection Names**: Ensure the `collection` parameter matches the loaded data (e.g., "h" for Hallmark, "cp" for Canonical Pathways, "go" for Gene Ontology, "pathprint" for Pathprint).
- **Data Frames**: The data is stored as data frames containing columns for the two pathways, their correlation, p-value, and adjusted p-value.

## Reference documentation
- [Using pcxnData with pcxn](./references/usingpcxnData.md)