---
name: bioconductor-bionero
description: BioNERO performs comprehensive biological network analysis including gene coexpression and regulatory network inference, module detection, and network comparison. Use when user asks to preprocess expression data, infer gene coexpression or regulatory networks, identify hub genes, perform module-trait associations, or compare network preservation across species.
homepage: https://bioconductor.org/packages/release/bioc/html/BioNERO.html
---


# bioconductor-bionero

name: bioconductor-bionero
description: Comprehensive biological network analysis including gene coexpression network (GCN) inference, gene regulatory network (GRN) inference, and network comparison (consensus modules and preservation). Use when Claude needs to perform systems biology workflows in R, such as data preprocessing, module detection, hub gene identification, enrichment analysis, and cross-species network comparison.

# bioconductor-bionero

## Overview

BioNERO is an all-in-one R package designed to streamline biological network analysis. It integrates state-of-the-art algorithms (like WGCNA, GENIE3, and NetRep) into a cohesive workflow. The package excels at transforming raw or normalized expression data into functional modules, identifying key regulators (hubs), and comparing network architectures across different conditions or species.

## Core Workflows

### 1. Data Preprocessing
BioNERO provides a unified wrapper for cleaning expression data (SummarizedExperiment or matrix).

```r
library(BioNERO)

# Automatic one-step preprocessing
# vstransform = TRUE if using raw counts
final_exp <- exp_preprocess(
    my_se_object, 
    min_exp = 10, 
    variance_filter = TRUE, 
    n = 2000
)

# Exploratory Analysis
plot_PCA(final_exp)
plot_heatmap(final_exp, type = "samplecor")
```

### 2. Gene Coexpression Network (GCN) Inference
Based on the WGCNA algorithm to find undirected modules.

```r
# 1. Find optimal beta power for scale-free topology
sft <- SFT_fit(final_exp, net_type = "signed hybrid", cor_method = "pearson")
power <- sft$power

# 2. Infer GCN
net <- exp2gcn(final_exp, net_type = "signed hybrid", SFTpower = power)

# 3. Visualize
plot_dendro_and_colors(net)
plot_ngenes_per_module(net)
```

### 3. Gene Regulatory Network (GRN) Inference
Uses the "wisdom of the crowds" principle (GENIE3, ARACNE, CLR) to find directed interactions.

```r
# Requires a vector of regulator IDs (e.g., TFs or miRNAs)
grn <- exp2grn(exp = final_exp, regulators = my_tfs_vector)

# Identify top 10% most connected regulators
grn_hubs <- get_hubs_grn(grn)
plot_grn(grn)
```

### 4. Functional Analysis and Visualization
Once modules are identified, use these functions to interpret biological meaning.

*   **Module-Trait Association:** `module_trait_cor(exp, MEs = net$MEs)`
*   **Enrichment:** `module_enrichment(net, background_genes, annotation)`
*   **Hub Identification (GCN):** `get_hubs_gcn(final_exp, net)`
*   **Subgraphs:** `get_edge_list(net, module = "blue", filter = TRUE)`
*   **Network Plotting:** `plot_gcn(edgelist, net, color_by = "module", hubs = hubs)`

### 5. Network Comparison
Compare networks across tissues (consensus) or species (preservation).

*   **Consensus Modules:** Use `consensus_SFT_fit()` and `consensus_modules()` on a list of expression sets.
*   **Module Preservation:** Use `module_preservation(list_exp, ref_net, test_net, algorithm = "netrep")`.
*   **Interspecies:** Use `exp_genes2orthogroups()` to collapse gene-level data to orthogroup-level before comparison.

## Tips and Best Practices

*   **Input Format:** While matrices are supported, `SummarizedExperiment` objects are preferred for Bioconductor interoperability.
*   **Scale-Free Topology:** Always visually inspect `sft$plot`. If the power is too low (e.g., < 6), the network might not satisfy biological assumptions.
*   **Filtering Edges:** When extracting edge lists for visualization, use `filter = TRUE` in `get_edge_list()` to remove weak correlations based on SFT fit.
*   **Parallelization:** Functions like `module_enrichment()` support `BiocParallel`. Pass a `bp_param` argument to speed up execution.
*   **Stability:** Use `module_stability()` to ensure detected modules aren't driven by a single outlying sample.

## Reference documentation

- [Gene coexpression network inference](./references/vignette_01_GCN_inference.md)
- [Gene regulatory network inference](./references/vignette_02_GRN_inference.md)
- [Network comparison: consensus modules and module preservation](./references/vignette_03_network_comparison.md)