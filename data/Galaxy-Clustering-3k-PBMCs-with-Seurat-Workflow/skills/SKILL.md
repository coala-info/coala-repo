---
name: clustering-3k-pbmcs-with-seurat-workflow
description: "This Galaxy workflow processes single-cell RNA-seq data from 3k PBMCs using Seurat tools for normalization, scaling, and clustering based on matrix, gene, and barcode inputs. Use this skill when you need to identify distinct cell populations, perform dimensionality reduction, and characterize immune cell heterogeneity within a peripheral blood mononuclear cell sample."
homepage: https://workflowhub.eu/workflows/1560
---

# Clustering 3k PBMCs with Seurat - Workflow

## Overview

This Galaxy workflow implements the Seurat pipeline for single-cell RNA-seq analysis, specifically following the [Clustering 3k PBMCs tutorial](https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/seurat-pbmc/tutorial.html) from the Galaxy Training Network (GTN). It is designed to process raw count matrices—consisting of matrix, gene, and barcode files—to identify and annotate distinct cell populations.

The pipeline employs a modular approach by using separate tools for each preprocessing stage, including `NormalizeData`, `FindVariableFeatures`, and `ScaleData`. After filtering and normalization, the workflow performs linear dimensional reduction (PCA) followed by graph-based clustering. It further utilizes non-linear dimensional reduction techniques like UMAP or t-SNE to visualize cell clusters in a 2D space.

Throughout the execution, the workflow generates extensive visualizations, such as violin plots for quality control, elbow plots for dimensionality assessment, and feature plots for marker expression. The final outputs include a fully preprocessed Seurat object, annotated clusters based on provided canonical markers, and a list of differentially expressed (DE) markers. This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for `singlecell` and `seurat` analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | matrix.mtx | data_input | Single cell expression data in Matrix Market (mtx) format. This is the table that shows the counts of each RNA in each cell. |
| 1 | genes.tsv | data_input | Table of gene names for the features in the matrix. |
| 2 | barcodes.tsv | data_input | Table of barcodes for the cells in the matrix. |
| 3 | Canonical Markers | data_input | Paste in a list of canonical markers for PBMCs - this is given in the Clustering 3K PBMCs with Seurat tutorial. |


Ensure your input files are in the correct formats, specifically the sparse matrix (.mtx) and the associated tab-separated feature and barcode files. This workflow expects these as individual datasets rather than a collection, so upload them separately to your Galaxy history before execution. The canonical markers file should be a tabular list to facilitate accurate cluster annotation during the final steps. Refer to the README.md for comprehensive instructions on specific parameter settings and detailed data preparation steps. You can also use planemo workflow_job_init to generate a job.yml file for streamlined automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Seurat Create | toolshed.g2.bx.psu.edu/repos/iuc/seurat_create/seurat_create/5.0+galaxy1 |  |
| 5 | Seurat Data Management | toolshed.g2.bx.psu.edu/repos/iuc/seurat_data/seurat_data/5.0+galaxy0 |  |
| 6 | Seurat Create | toolshed.g2.bx.psu.edu/repos/iuc/seurat_create/seurat_create/5.0+galaxy1 |  |
| 7 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 8 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 9 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 10 | Seurat Create | toolshed.g2.bx.psu.edu/repos/iuc/seurat_create/seurat_create/5.0+galaxy1 |  |
| 11 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 12 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 13 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 14 | Seurat Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/seurat_preprocessing/seurat_preprocessing/5.0+galaxy0 |  |
| 15 | Seurat Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/seurat_preprocessing/seurat_preprocessing/5.0+galaxy0 |  |
| 16 | Seurat Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/seurat_preprocessing/seurat_preprocessing/5.0+galaxy0 |  |
| 17 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 18 | Seurat Run Dimensional Reduction | toolshed.g2.bx.psu.edu/repos/iuc/seurat_reduce_dimension/seurat_reduce_dimension/5.0+galaxy0 |  |
| 19 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 20 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 21 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 22 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 23 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 24 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 25 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 26 | Seurat Find Clusters | toolshed.g2.bx.psu.edu/repos/iuc/seurat_clustering/seurat_clustering/5.0+galaxy0 |  |
| 27 | Seurat Find Clusters | toolshed.g2.bx.psu.edu/repos/iuc/seurat_clustering/seurat_clustering/5.0+galaxy0 |  |
| 28 | Seurat Run Dimensional Reduction | toolshed.g2.bx.psu.edu/repos/iuc/seurat_reduce_dimension/seurat_reduce_dimension/5.0+galaxy0 |  |
| 29 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 30 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 31 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 32 | Seurat Find Clusters | toolshed.g2.bx.psu.edu/repos/iuc/seurat_clustering/seurat_clustering/5.0+galaxy0 |  |
| 33 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 34 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 35 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 36 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 37 | Seurat Data Management | toolshed.g2.bx.psu.edu/repos/iuc/seurat_data/seurat_data/5.0+galaxy0 | This is the final annotated Seurat Object with each cluster labelled by cell type. |
| 38 | Convert CSV to tabular | csv_to_tabular |  |
| 39 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 40 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 41 | Cut | Cut1 |  |
| 42 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Input 3k PBMC | rds_out |
| 16 | Preprocessed Data | rds_out |
| 37 | Annotated Clusters | rds_out |
| 41 | Input DE Markers | table |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run seurat-pbmc-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run seurat-pbmc-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run seurat-pbmc-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init seurat-pbmc-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint seurat-pbmc-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `seurat-pbmc-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
