---
name: seurat-scrna-seq
description: "This CWL workflow processes single-cell RNA-seq count matrices using the Seurat toolkit to perform data normalization, feature selection, and dimensionality reduction. Use this skill when you need to identify distinct cell populations, characterize transcriptomic heterogeneity, or visualize the cellular composition of complex biological tissues."
homepage: https://workflowhub.eu/workflows/303
---
# seurat scRNA-seq

## Overview

This [Common Workflow Language (CWL) pipeline](https://workflowhub.eu/workflows/303) automates a standard Seurat-based analysis for single-cell RNA sequencing (scRNA-seq) data. It provides a reproducible path from raw expression matrices to clustered cell populations and low-dimensional visualizations.

The workflow begins with data ingestion and quality control filtering, followed by log-normalization and the identification of highly variable features. The resulting data is scaled to remove technical noise before performing Principal Component Analysis (PCA) for linear dimensionality reduction.

Downstream analysis utilizes the PCA results to construct a Shared Nearest Neighbor (SNN) graph for modularity-based clustering. Finally, the pipeline generates both UMAP and tSNE embeddings to facilitate the visual exploration of cell-type heterogeneity and cluster distribution.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| running_step |  | int |  |
| loadDataR |  | File |  |
| barcodes |  | File |  |
| features |  | File |  |
| matrix |  | File |  |
| minCells |  | int |  |
| minFeatures |  | int |  |
| projectName |  | string |  |
| pattern |  | string |  |
| filterDataR |  | File |  |
| nFeatureRNAmin |  | string |  |
| nFeatureRNAmax |  | string |  |
| nCountRNAmin |  | string |  |
| nCountRNAmax |  | string |  |
| percentMTmin |  | string |  |
| percentMTmax |  | string |  |
| normalizeDataR |  | File |  |
| normalization_method |  | string |  |
| scale_factor |  | string |  |
| margin |  | string |  |
| block_size |  | string |  |
| verbose |  | string |  |
| featureSelectionDataR |  | File |  |
| selection_method |  | string |  |
| loess_span |  | string |  |
| clip_max |  | string |  |
| num_bin |  | string |  |
| binning_method |  | string |  |
| num_features |  | string |  |
| scaleDataR |  | File |  |
| runPCAR |  | File |  |
| findNeighborsR |  | File |  |
| neighbors_method |  | string |  |
| k |  | string |  |
| clusterDataR |  | File |  |
| runUmapR |  | File |  |
| runTSNER |  | File |  |
| find_markersR |  | File |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| loadData | loadData |  |
| filterData | filterData |  |
| normalizeData | normalizeData |  |
| findFeatures | findFeatures |  |
| scaleData | scaleData |  |
| runPCA | runPCA |  |
| findNeighbors | findNeighbors |  |
| clusterData | clusterData |  |
| runUMAP | runUMAP |  |
| runTSNE | runTSNE |  |
| findAllMarkers | findAllMarkers |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| loadDataOutput |  | File |  |
| loadDataPlot |  | File |  |
| filterDataOutput |  | File |  |
| filterDataPlot |  | File |  |
| normalizeDataOutput |  | File |  |
| findFeaturesOutput |  | File |  |
| findFeaturesPlot |  | File |  |
| scaleDataOutput |  | File |  |
| runPCAOutput |  | File |  |
| runPCAPlot1 |  | File |  |
| runPCAPlot2 |  | File |  |
| runPCAPlot3 |  | File |  |
| findNeighborsOutput |  | File |  |
| clusterDataOutput |  | File |  |
| runUMAPOutput |  | File |  |
| runUMAPOutputPlot |  | File |  |
| runTSNEOutput |  | File |  |
| findMarkersOutput |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/303
- `steps.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
