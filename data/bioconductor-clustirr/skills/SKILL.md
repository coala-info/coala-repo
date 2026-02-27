---
name: bioconductor-clustirr
description: Bioconductor-clustirr analyzes T-cell and B-cell receptor repertoires using sequence clustering and Bayesian differential abundance models. Use when user asks to cluster immune receptors by sequence similarity, construct similarity graphs, detect receptor communities, or perform differential community occupancy analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/ClustIRR.html
---


# bioconductor-clustirr

name: bioconductor-clustirr
description: Analyze T-cell and B-cell receptor (TCR/BCR) repertoires using sequence clustering and Bayesian differential abundance models. Use this skill to identify specificity-associated receptor communities, construct similarity graphs, and perform Differential Community Occupancy (DCO) analysis across biological conditions or time points.

# bioconductor-clustirr

## Overview
ClustIRR is a Bioconductor package designed for the quantitative analysis of immune receptor repertoires (IRRs). It addresses the challenges of extreme receptor diversity and "privacy" (low overlap between individuals) by clustering clonotypes based on CDR3 sequence similarity. It then employs Bayesian models to identify communities that are differentially abundant between samples or experimental groups.

## Core Workflow

### 1. Data Preparation
Input data should be a data frame where each row is a clonotype. Required columns typically include `CDR3a` and/or `CDR3b` (amino acid sequences) and `clone_size`.

```r
library(ClustIRR)
# Combine multiple repertoires into one data frame
tcr_reps <- rbind(rep_a, rep_b, rep_c)
# Combine corresponding metadata
meta <- rbind(meta_a, meta_b, meta_c)
```

### 2. Similarity Clustering and Graph Construction
The `clustirr()` function computes sequence similarities (using BLAST via the `blaster` package) and constructs a joint similarity graph ($J$).

```r
# gmi: global matching identity threshold (default 0.8)
cl <- clustirr(s = tcr_reps, meta = meta, control = list(gmi = 0.8))

# Inspect the joint graph (igraph object)
cl$graph
```

### 3. Community Detection
Identify clusters of similar receptors using algorithms like Leiden, Louvain, or InfoMap.

```r
gcd <- detect_communities(graph = cl$graph, 
                          algorithm = "leiden",
                          weight = "ncweight", # normalized core weight
                          chains = c("CDR3a", "CDR3b"))

# Access the community occupancy matrix (counts per community per sample)
head(gcd$community_occupancy_matrix)
```

### 4. Differential Community Occupancy (DCO)
Apply a Bayesian model to find communities that expand or contract between samples or groups.

```r
# For individual repertoire comparisons
d <- dco(community_occupancy_matrix = gcd$community_occupancy_matrix)

# For group-based comparisons (e.g., Condition 1 vs Condition 2)
d_group <- dco(community_occupancy_matrix = gcd$community_occupancy_matrix,
               groups = c(1, 1, 1, 2, 2, 2)) # Assign samples to groups
```

## Visualization and Inspection

### Interactive Graphs
Visualize the similarity network. Nodes can be colored by antigen specificity if database annotations are available.

```r
# Generate visNetwork object
g <- plot_graph(cl, select_by = "Ag_species", as_visnet = TRUE)
# Save as HTML
save_interactive_graph(g, file_name = "tcr_network")
```

### Community Abundance
Use honeycomb plots to qualitatively compare community occupancy between pairs of repertoires.

```r
honeycomb <- get_honeycombs(com = gcd$community_occupancy_matrix)
library(patchwork)
wrap_plots(honeycomb)
```

### Model Results
Inspect the posterior distributions of the $\beta$ (occupancy) and $\delta$ (differential occupancy) parameters.

```r
# Plot differential occupancy (delta)
library(ggplot2)
ggplot(d$posterior_summary$delta, aes(x = community, y = mean)) +
    geom_point() +
    facet_wrap(~contrast)
```

## Tips for Success
- **Custom Inputs**: If you have already clustered your data using other tools (e.g., GLIPH2, TCRdist3), you can pass a custom occupancy matrix directly to `dco()`.
- **Chain Selection**: You can restrict analysis to a single chain by setting `chains = "CDR3b"` in `detect_communities`.
- **Core vs. Full**: `ncweight` refers to normalized alignment scores of the CDR3 core (trimmed ends), which often better represents antigen-binding specificity than the full sequence (`nweight`).
- **MCMC Control**: For large datasets, adjust `mcmc_control` in `dco()` (e.g., `mcmc_iter`, `mcmc_warmup`) to balance speed and convergence.

## Reference documentation
- [Decoding T- and B-cell receptor repertoires with ClustIRR](./references/User_manual.md)
- [Exporting an interactive ClustIRR graph](./references/User_manual_exportGraph.Rmd)
- [Finding biological condition-specific changes in T- and B-cell receptor repertoires with ClustIRR](./references/User_manual_groups.Rmd)
- [Decoding T- and B-cell receptor repertoires with ClustIRR](./references/User_manual_introduction.Rmd)