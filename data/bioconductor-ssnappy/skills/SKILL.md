---
name: bioconductor-ssnappy
description: This tool performs single-sample directional pathway perturbation analysis on RNA-seq data by incorporating pathway topology. Use when user asks to compute pathway perturbation scores, test significance via sample permutation, or visualize pathway activation and inhibition as networks or heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/sSNAPPY.html
---


# bioconductor-ssnappy

name: bioconductor-ssnappy
description: Perform single-sample directional pathway perturbation analysis (sSNAPPY) on RNA-seq data. Use this skill to compute pathway perturbation scores that incorporate topology, test significance via sample permutation, and visualize results as networks or heatmaps.

# bioconductor-ssnappy

## Overview

The `sSNAPPY` package implements a method for Single Sample directioNAl Pathway Perturbation analYsis. Unlike standard gene set enrichment methods, it incorporates pathway topology (gene-gene interactions) to propagate expression changes down a signaling pathway. This allows for the calculation of directional scores (activation or inhibition) for individual samples. It is particularly useful for datasets with complex experimental designs, small sample sizes, or when seeking to understand inter-patient heterogeneity in pathway response.

## Core Workflow

### 1. Data Preparation
Input data should be a normalized logCPM matrix with Entrez IDs as row names.

```r
library(sSNAPPY)
# Load example data
data(logCPM_example)
data(metadata_example)

# Ensure treatment is a factor with the control as the reference level
metadata_example$treatment <- factor(metadata_example$treatment, levels = c("Vehicle", "R5020", "E2+R5020"))
```

### 2. Compute Weighted Single-Sample logFC (ssLogFC)
The `weight_ss_fc` function calculates logFCs for treated samples relative to their matched controls (e.g., same patient) and applies weights to account for the mean-variance relationship in RNA-seq data.

```r
weightedFC <- weight_ss_fc(logCPM_example, 
                           metadata = metadata_example,
                           groupBy = "patient", 
                           sampleColumn = "sample", 
                           treatColumn = "treatment")
# Returns a list: weightedFC$weighted_logFC and weightedFC$weight
```

### 3. Retrieve Pathway Topologies
Retrieve and convert pathway information from databases like KEGG, Reactome, or WikiPathways into weighted adjacency matrices.

```r
# Retrieve all KEGG human pathways
gsTopology <- retrieve_topology(database = "kegg", species = "hsapiens")

# Or filter by keyword
gsTopology_sub <- retrieve_topology(database = "kegg", species = "hsapiens", keyword = "metabolism")
```

### 4. Scoring Perturbation
Calculate gene-wise perturbation scores and aggregate them into pathway-level scores.

```r
# Gene-level scores
genePertScore <- raw_gene_pert(weightedFC$weighted_logFC, gsTopology)

# Pathway-level scores
pathwayPertScore <- pathway_pert(genePertScore, weightedFC$weighted_logFC)
```

### 5. Significance Testing (Permutation)
Generate null distributions to calculate empirical p-values and robust z-scores.

```r
# Generate null distributions (NB = number of permutations)
set.seed(123)
permutedScore <- generate_permuted_scores(expreMatrix = logCPM_example, 
                                          gsTopology = gsTopology, 
                                          weight = weightedFC$weight,
                                          NB = 1000)

# Normalize scores and get p-values
normalisedScores <- normalise_by_permu(permutedScore, pathwayPertScore, sortBy = "pvalue")
```

## Visualization Functions

### Pathway Networks
Visualize overlap between significantly perturbed pathways. Edges represent shared genes.

```r
# Plot network colored by direction (robustZ)
plot_gs_network(normalisedScores[normalisedScores$adjPvalue < 0.05, ], 
                gsTopology = gsTopology, 
                colorBy = "robustZ")
```

### Gene Contributions
Identify which specific genes are driving a pathway's perturbation score using a heatmap.

```r
# Plot top 10 genes contributing to a specific pathway
plot_gene_contribution(genePertMatr = genePertScore$`kegg.Estrogen signaling pathway`,
                       filterBy = "mean", 
                       topGene = 10,
                       mapEntrezID = entrez2name) # entrez2name is a mapping df
```

### Community Detection
Group perturbed pathways into functional communities to summarize high-level biological changes.

```r
plot_community(normalisedScores[normalisedScores$adjPvalue < 0.05, ], 
               gsTopology = gsTopology, 
               colorBy = "community")
```

## Tips for Success
- **Entrez IDs**: The package strictly requires Entrez IDs (formatted as `ENTREZID:XXXX`) because the underlying topology databases use them. Use `AnnotationDbi` to convert symbols if necessary.
- **Control Reference**: Always ensure the `treatColumn` factor levels have the control group as the first level.
- **Computational Cost**: The `generate_permuted_scores` step is computationally intensive. For large datasets, consider running this on a high-performance computing cluster or reducing the number of pathways analyzed.
- **Directionality**: A positive `robustZ` score indicates pathway activation, while a negative score indicates inhibition.

## Reference documentation
- [sSNAPPY: Single Sample Directional Pathway Perturbation Analysis](./references/sSNAPPY.Rmd)
- [sSNAPPY: Single Sample Directional Pathway Perturbation Analysis](./references/sSNAPPY.md)