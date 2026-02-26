---
name: bioconductor-differentialregulation
description: This Bioconductor package identifies genes or transcripts displaying differential regulation between conditions by analyzing the balance between spliced and unspliced mRNA. Use when user asks to detect differential regulation in single-cell or bulk RNA-seq data, account for mapping uncertainty using equivalence classes, or compare the proportions of unspliced and spliced transcripts across experimental groups.
homepage: https://bioconductor.org/packages/release/bioc/html/DifferentialRegulation.html
---


# bioconductor-differentialregulation

## Overview

`DifferentialRegulation` is a Bioconductor package that identifies genes or transcripts displaying differential regulation between conditions. Unlike standard differential expression, which looks at total abundance, this method targets the balance between spliced (S) and unspliced (U) mRNA. A higher proportion of unspliced mRNA in one condition suggests active up-regulation compared to another. The package uses a Bayesian hierarchical model to account for sample-to-sample variability and mapping uncertainty (ambiguous and multi-mapping reads).

## Single-Cell RNA-seq Workflow

### 1. Load Data
The package expects scRNA-seq data quantified via `alevin-fry` with the USA (Unspliced-Spliced-Ambiguous) mode.

```r
library(DifferentialRegulation)

# Load USA counts into a SingleCellExperiment
sce <- load_USA(path_to_counts, path_to_cell_id, path_to_gene_id, sample_ids)

# Load Equivalence Classes (EC) to account for mapping uncertainty
EC_list <- load_EC(path_to_EC_counts, path_to_EC, path_to_cell_id, path_to_gene_id, sample_ids)
```

### 2. Pre-processing
Assign cell types to the `sce` object. Filtering should be performed on the `sce` object; `compute_PB_counts` will automatically synchronize the EC list.

```r
# Example: sce$cell_type <- my_labels
design <- data.frame(sample = sample_ids, group = c("Ctrl", "Ctrl", "Trt", "Trt"))

# Compute Pseudo-Bulk (PB) counts
PB_counts <- compute_PB_counts(sce = sce, 
                               EC_list = EC_list, 
                               design = design, 
                               sample_col_name = "sample", 
                               group_col_name = "group", 
                               sce_cluster_name = "cell_type")
```

### 3. Differential Testing
Run the main MCMC-based inference.

```r
set.seed(123)
results <- DifferentialRegulation(PB_counts, n_cores = 2, traceplot = TRUE)
```

## Bulk RNA-seq Workflow

### 1. Load Data
Requires an expanded reference (spliced + unspliced transcripts) quantified via `salmon` (with `--dumpEq`) or `kallisto`.

```r
# Load US counts
SE <- load_bulk_US(quant_files, sample_ids)

# Load Equivalence Classes
EC_list <- load_bulk_EC(path_to_eq_classes = equiv_classes_files, n_cores = 2)
```

### 2. Differential Testing
```r
design <- data.frame(sample = sample_ids, group = c("A", "A", "B", "B"))

results <- DifferentialRegulation_bulk(SE = SE, 
                                       EC_list = EC_list, 
                                       design = design, 
                                       n_cores = 2, 
                                       traceplot = TRUE)
```

## Interpreting Results

The results object contains several data frames:
- `Differential_results`: Main test statistics.
    - `p_val`: Raw p-value.
    - `p_adj.glb`: Globally adjusted p-value (across all clusters).
    - `Prob-group-UP`: Posterior probability that the gene is up-regulated in the specified group. Values near 1 indicate up-regulation; values near 0 indicate down-regulation.
- `US_results` / `USA_results`: Estimated proportions ($\pi$) and standard deviations for S, U, and A components.
- `Convergence_results`: Check if MCMC chains converged.

### Visualization
```r
# Plot proportions for a specific gene/cluster (scRNA-seq)
plot_pi(results, type = "US", gene_id = "ENSG...", cluster_id = "Neurons")

# Plot proportions for bulk data
plot_bulk_pi(results, transcript_id = "ENST...")

# Check MCMC traceplots
plot_traceplot(results, gene_id = "ENSG...", cluster_id = "Neurons")
```

## Key Tips
- **Memory Management**: The `EC_list` object can be very large. Remove it (`rm(EC_list)`) after running `compute_PB_counts` or `DifferentialRegulation_bulk` to free up RAM.
- **Ambiguous Reads**: In scRNA-seq, `load_USA` defines default counts as `Spliced + 0.5 * Ambiguous`. However, the model treats Ambiguous reads as a separate category in the `USA` results to better reflect mapping uncertainty.
- **Filtering**: Ensure you have a sufficient number of cells per cluster (typically >100) for reliable single-cell results.

## Reference documentation
- [DifferentialRegulation: a method to identify genes displaying differential regulation between groups of samples](./references/DifferentialRegulation.md)