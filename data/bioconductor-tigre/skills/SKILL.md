---
name: bioconductor-tigre
description: This tool implements Gaussian process differential equation models to analyze gene expression time series data. Use when user asks to infer latent transcription factor protein concentrations, rank candidate transcription factor targets, or model single input motif networks.
homepage: https://bioconductor.org/packages/release/bioc/html/tigre.html
---

# bioconductor-tigre

name: bioconductor-tigre
description: Gaussian process differential equation models for gene expression time series analysis. Use this skill to infer unobserved transcription factor (TF) protein concentrations from target gene expression data, rank candidate TF targets, and model single input motif (SIM) networks.

# bioconductor-tigre

## Overview

The `tigre` package (Transcription factor Inference through Gaussian process Reconstruction of Expression) implements Gaussian process models to analyze gene expression time series. It is primarily used for Single Input Motif (SIM) networks where a single TF regulates multiple target genes. The package allows for the reconstruction of latent TF protein activity and the ranking of potential targets based on how well their expression profiles fit the differential equation model.

## Core Workflow

### 1. Data Preparation

The package requires time series data, ideally with associated measurement uncertainty (error bars).

- **Affymetrix Data**: If using Affymetrix arrays, process with `puma::mmgmos` to obtain expression levels and variances.
- **Processing for tigre**: Use `processData` to format the expression data for modeling.
  ```r
  # experiments argument defines independent time series replicates
  data <- processData(expression_set, experiments = rep(1:3, each = 12))
  ```
- **Non-Affymetrix Data**: Use `processRawData` for data without pre-calculated variances.
  ```r
  procData <- processRawData(data_matrix, times = c(...), experiments = c(...))
  ```

### 2. Learning Models

Use `GPLearn` to fit Gaussian process models to specific TF-target pairs or groups.

- **Single-Target Model**: Learn a model for one TF and one target.
  ```r
  model <- GPLearn(data, TF = "TF_probe_id", targets = "Target_probe_id")
  ```
- **Multiple-Target Model**: Learn a joint model for a TF and multiple targets.
  ```r
  mt_model <- GPLearn(data, TF = "TF_probe_id", targets = c("T1", "T2", "T3"))
  ```
- **Model without TF mRNA**: If TF mRNA data is unavailable or unreliable, fit a model using only target data.
  ```r
  nt_model <- GPLearn(data, targets = c("TF_id", "T1", "T2"))
  ```

### 3. Ranking Targets

To identify the most likely targets of a TF from a large pool of candidates, use `GPRankTargets`.

- **Basic Ranking**:
  ```r
  scores <- GPRankTargets(data, TF = "TF_id", testTargets = candidate_probes)
  scores <- sort(scores, decreasing = TRUE)
  write.scores(scores)
  ```
- **Filtering**: Use `filterLimit` to exclude weakly expressed genes (based on average expression z-score).
- **Known Targets**: Improve ranking by providing `knownTargets` to help calibrate the TF activity profile.
  ```r
  scores <- GPRankTargets(data, TF = "TF_id", knownTargets = "Known_T1", testTargets = candidates)
  ```

### 4. Visualization and Export

- **Plotting**: Visualize the inferred TF activity and the model fit for target genes.
  ```r
  GPPlot(model, nameMapping = getAnnMap("SYMBOL", annotation(data)))
  ```
- **Recreating Models**: `GPRankTargets` returns scores, not full models. Recreate top models using `generateModels`.
  ```r
  top_models <- generateModels(data, scores[1:5])
  ```
- **Database Export**: Export results to an SQLite database for use with the `tigreBrowser`.
  ```r
  export.scores(scores, datasetName = "MyStudy", database = "results.sqlite", preprocData = data)
  ```

## Tips and Best Practices

- **Measurement Noise**: `tigre` performs best when measurement noise (variances) is provided. If unavailable, the package will estimate noise variances, but results may be less robust.
- **TF Activity**: The inferred TF protein concentration is a "latent" variable. It represents the effective activity of the TF, which may differ from its mRNA concentration due to translation delays or post-translational modifications.
- **Batch Processing**: For large-scale rankings, use the `scoreSaveFile` argument in `GPRankTargets` to save progress incrementally.
- **Annotation**: Use `annotate` or `org.XX.eg.db` packages to map between probe IDs and gene symbols for clearer plotting and reporting.

## Reference documentation

- [tigre User Guide](./references/tigre.md)