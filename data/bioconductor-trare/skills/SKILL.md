---
name: bioconductor-trare
description: This tool identifies transcriptional network disruptions and infers gene regulatory networks from RNA-Seq data using Bayesian machine learning. Use when user asks to infer module-based gene regulatory networks, perform phenotype-associated rewiring tests, or conduct multi-tier analysis of transcriptional disruptions.
homepage: https://bioconductor.org/packages/3.13/bioc/html/TraRe.html
---


# bioconductor-trare

name: bioconductor-trare
description: Identification of transcriptional network disruptions via Bayesian machine learning. Use this skill to infer module-based gene regulatory networks (GRNs) from RNA-Seq data, perform phenotype-associated rewiring tests to identify disrupted modules, and conduct three-tier analysis (gene, regulon, and transcriptional module levels).

# bioconductor-trare

## Overview
TraRe (Transcriptional Rewiring) is a Bioconductor package designed to identify disruptions in gene regulatory networks (GRNs) associated with specific phenotypes. It uses Bayesian machine learning (specifically Variational Bayes Spike Regression) to link regulators (e.g., Transcription Factors) to target gene modules. The core workflow involves preprocessing expression data, inferring GRN modules through bootstrapping, and testing for "rewiring"—significant changes in gene co-expression patterns between binary phenotype conditions (e.g., Responders vs. Non-responders).

## Core Workflow

### 1. Data Preparation
TraRe requires a log-normalized gene expression matrix and information identifying which genes are regulators (drivers).

```r
library(TraRe)
library(SummarizedExperiment)

# Create a SummarizedExperiment object
# counts: log-normalized expression (genes x samples)
# rowData: must contain a boolean column 'gene_info' (TRUE for regulators)
# colData: must contain a 'phenotype' column (binary factor)
se <- SummarizedExperiment(assays = list(counts = exp_matrix),
                           rowData = gene_info_df,
                           colData = phenotype_df)

# Preprocess to filter low variance genes/samples
trare_obj <- trare_preprocessing(data_matrix = se, verbose = TRUE)
```

### 2. GRN Inference (LINKER)
The `LINKER_run` function performs the primary network inference. It uses bootstrapping to ensure robustness.

```r
# link_mode and graph_mode: "VBSR" (recommended), "LASSOmin", "LASSO1se", or "LM"
linker_output <- LINKER_run(trare_obj,
                            link_mode = "VBSR",
                            graph_mode = "VBSR",
                            NrModules = 50,
                            Nr_bootstraps = 10)
```

### 3. Rewiring Test
Identify modules where the relationship between regulators and targets changes significantly between phenotypes.

```r
# Prepare the rewiring object
prew_output <- preparerewiring(name = "Analysis_Name", 
                               TraReObj = trare_obj,
                               linker_output = linker_output,
                               final_signif_thresh = 0.05,
                               outdir = "results/")

# Run the test and generate HTML reports/visualizations
runrewiring(prew_output)
```

### 4. Multi-tier Analysis
Analyze disruptions at specific biological resolutions.

*   **Gene Level**: Identify specific TFs significantly associated with rewired modules.
*   **Regulon Level**: Extract curated rewired regulons for specific TFs.

```r
# Gene level analysis
imp_genes <- rewiring_gene_level(linker_output = linker_output,
                                 TraReObj = trare_obj,
                                 fpath = "rewired_modules.txt")

# Regulon level analysis
regulons <- rewiring_regulon_level(linker_output = linker_output,
                                   TraReObj = trare_obj,
                                   fpath = "rewired_modules.txt")
```

## Visualization and Reporting
TraRe generates automated HTML reports during the rewiring step. You can also manually generate bipartite graphs for specific modules:

```r
# Generate a single GRN for a specific set of genes
graph <- NET_run(lognorm_est_counts = expression_subset,
                 target_filtered_idx = target_indices,
                 regulator_filtered_idx = regulator_indices,
                 graph_mode = "VBSR")

# Plot with phenotype-aware layout (uses t-test to sort targets)
layout <- return_layout_phenotype(drivers_names, targets_names, varfile)
plot_igraph(graph$graphs$VBSR, mylayout = layout)
```

## Tips for Success
*   **Normalization**: Use `DESeq2::varianceStabilizingTransformation` before inputting data into TraRe.
*   **Bootstraps**: For publication-quality results, use at least 50 bootstraps in `LINKER_run` to increase the power of the Fisher's test in gene-level analysis.
*   **Regulators**: Ensure your `gene_info` correctly identifies TFs; the quality of the GRN depends entirely on the provided candidate regulators.
*   **Cliques**: Use the `include_cliques = TRUE` parameter in `rewiring_gene_level` to recover TFs that might have been dropped due to high correlation with other regulators.

## Reference documentation
- [TraRe: Identification of transcriptional network disruptions via Bayesian machine learning](./references/TraRe.Rmd)
- [TraRe: Identification of conditions dependant Gene Regulatory Networks](./references/TraRe.md)