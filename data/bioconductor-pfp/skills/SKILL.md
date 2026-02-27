---
name: bioconductor-pfp
description: Bioconductor-pfp performs pathway fingerprint analysis to identify biomarkers and functional characteristics of gene expression data by integrating KEGG network topology. Use when user asks to calculate pathway-based scores, rank pathways by importance, identify key biomarkers, or visualize disease fingerprints from differential expression results.
homepage: https://bioconductor.org/packages/3.13/bioc/html/PFP.html
---


# bioconductor-pfp

name: bioconductor-pfp
description: Pathway Fingerprint (PFP) analysis for biomarker discovery and functional characterization of gene expression data. Use this skill when you need to calculate pathway-based scores, identify key biomarkers using KEGG topology, and visualize disease fingerprints to compare normal and disease states.

## Overview

The `PFP` package provides a quantitative method to evaluate the importance of gene sets within KEGG pathways by considering network topology. Unlike traditional enrichment tools, PFP generates a "pathway fingerprint" that helps identify fatal pathways and biomarkers with high stability. It is particularly useful for analyzing microarray or RNA-seq data (processed via limma or edgeR) to move beyond simple differential expression to mechanistic insights.

## Core Workflows

### 1. Data Preparation and Scoring
The primary workflow involves mapping a list of differentially expressed genes (DEGs) to KEGG pathway networks and calculating the PFP score.

```r
library(PFP)

# Load required reference data (Human example)
data("gene_list_hsa")   # Your list of ENTREZ IDs
data("PFPRefnet_hsa")  # KEGG reference network

# Calculate PFP scores
PFP_test <- calc_PFP_score(genes = gene_list_hsa, PFPRefnet = PFPRefnet_hsa)

# Rank pathways by score (higher score = more relevant to the gene set)
# thresh_value filters the results
ranked_pfp <- rank_PFP(object = PFP_test, total_rank = TRUE, thresh_value = 0.5)

# View summary
show(ranked_pfp)
```

### 2. Target Pathway and Network Analysis
After identifying top-ranked pathways, you can extract specific gene scores and analyze co-expression edges.

```r
# Extract the ID of the top-ranked pathway
pathway_id <- refnet_info(ranked_pfp)[1, "id"]

# Get gene scores for that specific pathway
gene_scores <- pathways_score(ranked_pfp)$genes_score[[pathway_id]]

# Analyze co-expression (requires a standardized expression matrix 'data_std')
edges_coexp <- get_exp_cor_edges(gene_scores$ENTREZID, data_std)

# Find associated KEGG edges and build the network
edges_kegg <- get_bg_related_kegg(unique(c(edges_coexp$source, edges_coexp$target)), 
                                  PFPRefnet = PFPRefnet_hsa)

# Generate the associated network (requires org.Hs.eg.db)
library(org.Hs.eg.db)
net_result <- get_asso_net(edges_coexp = edges_coexp, 
                           edges_kegg = edges_kegg, 
                           if_symbol = TRUE, 
                           gene_info_db = org.Hs.eg.db)
```

### 3. Visualization
PFP provides a specialized plotting function to visualize the "fingerprint" of the pathways.

```r
# Plot the fingerprint of all calculated scores
plot_PFP(PFP_test)

# Plot only the ranked/filtered pathways
plot_PFP(ranked_pfp)
```

## Key Classes and Methods

### PFP Class
Stores the calculated scores and provides methods for manipulation:
- `genes_score()`: Access gene-level scores within pathways.
- `sub_PFP()`: Subset the results by group, ID, or name.
- `rank_PFP()`: Rank pathways based on P-values and PFP scores.

### PFPRefnet Class
Stores the reference KEGG network information:
- `network()`: Access the underlying KEGG network.
- `net_info()`: Get metadata about the pathways.
- `subnet()`: Extract specific portions of the reference network.

## Tips for Success
- **Gene IDs**: Ensure your input gene list uses ENTREZ IDs, as the reference networks are typically built on these identifiers.
- **Reference Networks**: Use `data("PFPRefnet_hsa")` for human studies. If working with other organisms, you may need to construct a compatible `PFPRefnet` object from KGML files.
- **Filtering**: When using `rank_PFP`, adjust `thresh_value` to control the stringency of the pathways displayed in the fingerprint plot.

## Reference documentation
- [Pathway fingerprint: a tool for biomarker discovery based on gene expression data and pathway knowledge](./references/PFP.Rmd)
- [Pathway fingerprint: a tool for biomarker discovery based on gene expression data and pathway knowledge](./references/PFP.md)