---
name: cluster-3k-pbmcs-with-seurat-workflow-sctransform-version
description: This single-cell RNA-seq workflow processes PBMC count matrices and marker lists using Seurat tools to perform SCTransform-based normalization, dimensionality reduction, and cluster identification. Use this skill when you need to identify distinct cell populations in peripheral blood mononuclear cell datasets while applying SCTransform to improve signal-to-noise ratios and stabilize variance.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# cluster-3k-pbmcs-with-seurat-workflow-sctransform-version

## Overview

This Galaxy workflow implements the Seurat pipeline for clustering 3,000 Peripheral Blood Mononuclear Cells (PBMCs), specifically utilizing the `SCTransform` method for preprocessing. It is designed to accompany the [Clustering 3K PBMCs with Seurat](https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/seurat-intro/tutorial.html) tutorial from the Galaxy Training Network (GTN).

The pipeline begins by importing raw count matrices—including matrix, genes, and barcodes—to create a Seurat object. Unlike traditional normalization methods, this version uses the `SCTransform` tool to perform normalization, feature selection, and scaling in a single step. This approach effectively removes technical noise and improves the downstream identification of biological variations.

Following preprocessing, the workflow executes dimensional reduction via PCA and identifies cell clusters through graph-based clustering. It generates a comprehensive suite of visualizations, including UMAP plots and marker gene distributions, to help researchers explore the data structure. The final stages involve cluster annotation using canonical markers and the extraction of differentially expressed (DE) markers for cell type identification.

This resource is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for `singlecell` analysis and `seurat` users within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | matrix.mtx | data_input | Single cell expression data in Matrix Market (mtx) format. This is the table that shows the counts of each RNA in each cell. |
| 1 | genes.tsv | data_input | Table of gene names for the features in the matrix. |
| 2 | barcodes.tsv | data_input | Table of barcodes for the cells in the matrix. |
| 3 | Canonical Markers | data_input | Paste in a list of canonical markers for PBMCs - this is given in the Clustering 3K PBMCs with Seurat tutorial. |


Ensure your input files are correctly formatted as a sparse matrix (matrix.mtx) and associated TSV files for genes and barcodes to avoid ingestion errors in the Seurat Create step. While this workflow uses individual datasets, you can organize multi-sample runs into collections for more efficient processing across the SCTransform and clustering steps. Refer to the README.md for comprehensive details on parameter settings and marker gene selection. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing.

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
| 11 | Seurat Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/seurat_preprocessing/seurat_preprocessing/5.0+galaxy0 |  |
| 12 | Seurat Data Management | toolshed.g2.bx.psu.edu/repos/iuc/seurat_data/seurat_data/5.0+galaxy0 |  |
| 13 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 14 | Seurat Run Dimensional Reduction | toolshed.g2.bx.psu.edu/repos/iuc/seurat_reduce_dimension/seurat_reduce_dimension/5.0+galaxy0 |  |
| 15 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 16 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 17 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 18 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 19 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 20 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 21 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 22 | Seurat Find Clusters | toolshed.g2.bx.psu.edu/repos/iuc/seurat_clustering/seurat_clustering/5.0+galaxy0 |  |
| 23 | Seurat Find Clusters | toolshed.g2.bx.psu.edu/repos/iuc/seurat_clustering/seurat_clustering/5.0+galaxy0 |  |
| 24 | Seurat Run Dimensional Reduction | toolshed.g2.bx.psu.edu/repos/iuc/seurat_reduce_dimension/seurat_reduce_dimension/5.0+galaxy0 |  |
| 25 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 26 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 27 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 28 | Seurat Find Clusters | toolshed.g2.bx.psu.edu/repos/iuc/seurat_clustering/seurat_clustering/5.0+galaxy0 |  |
| 29 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 30 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 31 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 32 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 33 | Seurat Data Management | toolshed.g2.bx.psu.edu/repos/iuc/seurat_data/seurat_data/5.0+galaxy0 | This is the final annotated Seurat Object with each cluster labelled by cell type. |
| 34 | Convert CSV to tabular | csv_to_tabular |  |
| 35 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 36 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |
| 37 | Cut | Cut1 |  |
| 38 | Seurat Visualize | toolshed.g2.bx.psu.edu/repos/iuc/seurat_plot/seurat_plot/5.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Input 3k PBMC | rds_out |
| 11 | Preprocessed Data | rds_out |
| 33 | Annotated Clusters | rds_out |
| 37 | Input DE Markers | table |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run seurat-pbmc-workflow-sct.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run seurat-pbmc-workflow-sct.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run seurat-pbmc-workflow-sct.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init seurat-pbmc-workflow-sct.ga -o job.yml`
- Lint: `planemo workflow_lint seurat-pbmc-workflow-sct.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `seurat-pbmc-workflow-sct.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)