---
name: bioconductor-starbiotrek
description: This tool analyzes biological pathway activity and cross-talk by integrating gene expression data with KEGG and GeneMania networks. Use when user asks to measure pathway activity scores, calculate pathway cross-talk indexes, identify driver genes, or classify samples based on pathway profiles in R.
homepage: https://bioconductor.org/packages/3.6/bioc/html/StarBioTrek.html
---

# bioconductor-starbiotrek

name: bioconductor-starbiotrek
description: Analysis of biological pathways and cross-talk using KEGG, GeneMania, and TCGA data. Use this skill when you need to measure pathway activity, identify driver genes (IPPI), calculate pathway cross-talk indexes (Euclidean distance or discriminating scores), or classify samples based on pathway profiles in R.

## Overview
StarBioTrek is a Bioconductor package designed to move beyond gene-level analysis by focusing on pathway activity and the interactions (cross-talk) between pathways. It integrates gene expression data (typically from TCGA) with functional pathway information from KEGG and network data from GeneMania. It is particularly useful for identifying pathway-based signatures that are more robust than individual gene markers in cancer research.

## Core Workflows

### 1. Data Acquisition
Retrieve pathway and network data to build the foundation for analysis.

```r
library(StarBioTrek)

# Get KEGG pathway data by functional group (e.g., "Transcript", "Carb_met", "sign_transd")
pathways <- getKEGGdata(KEGG_path = "Transcript")

# Get network data from GeneMania (e.g., "PHint" for physical interactions, "SHpd" for shared protein domains)
net_data <- getNETdata(network = "PHint", organism = "homo_sapiens")
```

### 2. Pathway-Network Integration
Map network interactions onto specific pathways to identify interacting genes within those pathways.

```r
# Create a network of interacting genes for each pathway
network_path <- path_net(pathway = pathways, data = net_data)

# Get a list of genes that have interactions within their respective pathways
list_path <- list_path_net(lista_net = network_path, pathway = pathways)
```

### 3. Pathway Activity Scoring
Calculate summary statistics for pathways based on a gene expression matrix (rows = genes, columns = samples).

```r
# Filter expression matrix for genes in pathways
ge_matrix <- GE_matrix(DataMatrix = exp_data, pathway = pathways)

# Calculate average expression per pathway
pathway_means <- average(dataFilt = exp_data, pathway = pathways)

# Calculate standard deviation per pathway
pathway_sd <- st_dv(DataMatrix = exp_data, pathway = pathways)
```

### 4. Pathway Cross-Talk Analysis
Measure the relationship between pairs of pathways.

```r
# Euclidean distance between pathways
euc_dist <- euc_dist_crtlk(dataFilt = exp_data, pathway = pathways)

# Discriminating score (|M1-M2| / (S1+S2))
ds_score <- ds_score_crtlk(dataFilt = exp_data, pathway = pathways)
```

### 5. Classification and Selection
Identify which pathway pairs best differentiate between conditions (e.g., Tumor vs. Normal) using SVM.

```r
# Perform SVM classification with 10-fold cross-validation
# nfs: percentage of data for training (e.g., 60)
res_class <- svm_classification(
  TCGA_matrix = euc_dist, 
  nfs = 60, 
  normal = colnames(normal_samples), 
  tumour = colnames(tumor_samples)
)

# Select pathway pairs with AUC > 0.80
better_perf <- select_class(auc.df = res_class, cutoff = 0.80)

# Extract matrix for the best performing pathway pairs
matrix_best <- process_matrix(measure = euc_dist, list_perf = better_perf)
```

### 6. Driver Gene Identification (IPPI)
Identify potential driver genes within pathways by integrating pathway and network data.

```r
driver_genes <- IPPI(patha = pathways, netwa = net_data)
```

## Tips and Best Practices
- **KEGG Groups**: Use specific strings for `getKEGGdata` like `cell_grow_d` (Cell growth/death), `imm_syst` (Immune system), or `Lip_met` (Lipid metabolism) to focus your analysis.
- **Data Harmonization**: When comparing different pathway sets (e.g., Metabolism vs. Cellular Processes), use `process_matrix_cell_process` to ensure the matrices are compatible for correlation analysis.
- **Visualization**: Use `plotting_cross_talk` to format data for the `qgraph` package to visualize gene correlations within pathways.

## Reference documentation
- [Working with StarBioTrek package](./references/StarBioTrek.Rmd)
- [StarBioTrek: Application Examples](./references/StarBioTrek_Application_Examples.Rmd)
- [StarBioTrek: Application Examples (Markdown)](./references/StarBioTrek_Application_Examples.md)