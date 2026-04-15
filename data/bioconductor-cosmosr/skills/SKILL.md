---
name: bioconductor-cosmosr
description: This tool integrates multi-omics data using causal reasoning and prior knowledge networks to connect signaling pathways with metabolic changes. Use when user asks to integrate transcriptomics and metabolomics data, connect signaling to metabolism, perform meta-footprint analysis, or generate mechanistic sub-networks.
homepage: https://bioconductor.org/packages/release/bioc/html/cosmosR.html
---

# bioconductor-cosmosr

name: bioconductor-cosmosr
description: Integration of multi-omics data (transcriptomics, metabolomics, proteomics) using causal reasoning and prior knowledge networks (PKN). Use this skill to estimate transcription factor and kinase activities, connect signaling pathways to metabolic networks, and generate mechanistic hypotheses for experimental observations.

## Overview
COSMOS (Causal Oriented Search of Multi-Omic Space) is a Bioconductor package designed to bridge the gap between different omic layers. It leverages prior knowledge from databases like OmniPath, STITCH, and Recon3D to find the most parsimonious and mechanistically coherent sub-network that explains observed changes in multi-omics data. It supports both traditional Integer Linear Programming (ILP) via CARNIVAL and the newer Meta-Footprint Analysis (MOON) for network scoring.

## Core Workflows

### 1. Signaling to Metabolism (Forward)
Connects upstream signaling (TFs/Kinases) to downstream metabolic changes.
- **Pre-process**: Use `preprocess_COSMOS_signaling_to_metabolism`.
- **Run**: Use `run_COSMOS_signaling_to_metabolism`.
- **Format**: Use `format_COSMOS_res`.

### 2. Metabolism to Signaling (Backward)
Connects metabolic changes to upstream signaling regulation.
- **Pre-process**: Use `preprocess_COSMOS_metabolism_to_signaling`.
- **Run**: Use `run_COSMOS_metabolism_to_signaling`.

### 3. MOON (Meta-Footprint Analysis)
A newer, faster approach for scoring mechanistic networks without requiring heavy ILP solvers for every step.
- **Workflow**: Prune PKN based on expressed genes -> Filter controllable/observable neighbors -> Compress network -> Run `moon()` -> Decompress and reduce.

## Key Functions and Usage

### Solver Configuration
COSMOS requires an optimization solver. While `lpSolve` is included for testing, `CPLEX` or `CBC` are required for real-world datasets.
```r
CARNIVAL_options <- default_CARNIVAL_options(solver = "cplex")
CARNIVAL_options$solverPath <- "path/to/cplex"
CARNIVAL_options$timelimit <- 3600
CARNIVAL_options$mipGAP <- 0.05
```

### Data Preparation
- **Metabolites**: Must be mapped to HMDB or BIGG IDs with compartment codes (e.g., `Metab__HMDB0000190_c`). Use `prepare_metab_inputs(metab_data, c("c", "m"))`.
- **Signaling**: Typically TF or Kinase activity scores (e.g., from decoupleR or DoRothEA).
- **RNA**: Used to filter the PKN for expressed genes.

### Network Pruning and Compression
To improve performance and relevance, prune the PKN before running the optimization:
```r
# Filter for expressed genes
meta_network <- filter_pkn_expressed_genes(names(RNA_input), meta_pkn = meta_network)

# Keep reachable nodes (e.g., within 6 steps)
meta_network <- keep_controllable_neighbours(meta_network, n_steps = 6, names(sig_input))

# Compress redundant paths
compressed_list <- compress_same_children(meta_network, sig_input, metab_input)
```

### Visualization
Visualize the resulting sub-network around a specific node:
```r
display_node_neighboorhood(central_node = 'Metab__D-Glucitol_c', 
                           sif = full_sif, 
                           att = full_attributes, 
                           n = 7)
```

## Tips for Success
- **Solver Choice**: Always use CPLEX for publication-quality results. `lpSolve` often fails to find optimal solutions for large networks.
- **Network Depth**: `maximum_network_depth` (usually 4-7) significantly impacts runtime. Start small.
- **Incoherence Filtering**: Use `filter_tf_gene_interaction_by_optimization = TRUE` during preprocessing to remove TF-target interactions that contradict your transcriptomic data.
- **MOFA Integration**: COSMOS can be used to interpret MOFA factors by using factor weights as inputs for signaling and metabolic layers.

## Reference documentation
- [MOFA to COSMOS tutorial](./references/MOFA_to_COSMOS.md)
- [NCI60 tutorial](./references/net_compr_MOON.md)
- [COSMOS-tutorial](./references/tutorial.md)