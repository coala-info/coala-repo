---
name: bioconductor-panomir
description: PanomiR identifies and prioritizes miRNA regulators by analyzing their targeting of coordinated biological pathway clusters. Use when user asks to perform pathway summarization from gene expression, detect differentially activated pathways, cluster pathways using co-expression networks, or prioritize miRNAs based on pathway targeting.
homepage: https://bioconductor.org/packages/release/bioc/html/PanomiR.html
---

# bioconductor-panomir

name: bioconductor-panomir
description: Analysis and prioritization of miRNA regulators based on their targeting of coordinated biological pathways. Use this skill when you need to perform pathway summarization from gene expression, detect differentially activated pathways, cluster pathways using co-expression networks (PCxN), and prioritize miRNAs that target these pathway clusters.

## Overview

PanomiR (Pathway networks of miRNA Regulation) is a systems biology framework used to discover miRNA regulators by analyzing how they target groups of coordinated pathways rather than isolated genes. It integrates gene expression data, pathway definitions, and miRNA-mRNA interaction data to identify miRNAs associated with specific disease states or biological conditions.

## Core Workflow

### 1. Pathway Summarization
Convert gene expression matrices into pathway activity profiles.

```r
library(PanomiR)
data("path_gene_table") # Default MSigDB V6.2 pathways

# Generate activity summaries (z-normalized average rank-squared)
summaries <- pathwaySummary(
  geneCounts = exp_matrix, 
  pathways = path_gene_table, 
  method = "x2", 
  zNormalize = TRUE, 
  id = "ENSEMBL" # Match rownames of exp_matrix
)
```

### 2. Differential Pathway Analysis
Identify pathways that are significantly dysregulated between conditions.

```r
output_de <- differentialPathwayAnalysis(
  geneCounts = exp_matrix,
  pathways = path_gene_table,
  covariates = metadata_df,
  condition = 'group_column' # The factor to contrast
)

de_paths <- output_de$DEP
```

### 3. Pathway Clustering
Group differentially activated pathways using the Pathway Co-expression Network (PCxN).

```r
# Map pathways to clusters based on co-expression
pathway_clusters <- mappingPathwaysClusters(
  pcxn = miniTestsPanomiR$miniPCXN, 
  dePathways = de_paths,
  topPathways = 200,
  clusteringFunction = "cluster_louvain",
  correlationCutOff = 0.1
)

# View cluster assignments
head(pathway_clusters$Clustering)
```

### 4. miRNA Prioritization
Rank miRNAs based on their targeting of the identified pathway clusters.

```r
# Prioritize miRNAs for a specific cluster (e.g., Cluster 1)
mir_priority <- prioritizeMicroRNA(
  enriches0 = miniTestsPanomiR$miniEnrich, # miRNA-pathway enrichment ref
  pathClust = pathway_clusters$Clustering,
  topClust = 1,
  sampRate = 500, # Recommended 500-1000 for publication
  method = "aggInv",
  saveSampling = FALSE
)

# Results contain p-values and FDR for miRNAs
head(mir_priority$Cluster1)
```

## Customization and Data Preparation

### Creating Custom Enrichment Tables
It is recommended to create enrichment tables tailored to the genes expressed in your specific experiment.

```r
data("msigdb_c2")
data("targetScan_03")

custom_enrich <- miRNAPathwayEnrichment(
  mirSets = targetScan_03,
  pathwaySets = msigdb_c2,
  geneSelection = rownames(exp_matrix),
  fromID = "ENSEMBL",
  toID = "ENTREZID"
)

# Generate a readable report
report <- reportEnrichment(custom_enrich)
```

### Using External Gene Sets
To use custom pathways (e.g., from a GMT file), convert them to the PanomiR table format.

```r
library(GSEABase)
gsc <- getGmt("path/to/your.gmt")
custom_path_table <- tableFromGSC(gsc)
```

## Tips for Success
- **ID Mapping**: Ensure `id` (ENSEMBL, SYMBOL, etc.) matches your expression data rownames in `pathwaySummary`.
- **Contrasts**: `differentialPathwayAnalysis` uses `limma` logic. If your condition has more than two levels, ensure you specify the contrast or format the covariate as a factor.
- **Sampling Rate**: For exploratory analysis, `sampRate = 50` is fast; use `500-1000` for final results to ensure stable p-values.
- **PCxN Versions**: While a mini version is provided in the package, consider using the full PCxN data from Bioconductor (`pcxn` and `pcxnData` packages).

## Reference documentation
- [miRNA and pathway analysis with PanomiR](./references/PanomiR.md)