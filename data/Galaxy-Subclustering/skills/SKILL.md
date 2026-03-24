---
name: subclustering
description: "This single-cell RNA-seq workflow processes AnnData objects to isolate and re-analyze specific clusters using Scanpy tools for normalization, dimensionality reduction, and marker gene identification. Use this skill when you need to resolve finer cellular heterogeneity or identify distinct sub-states within a broad cell population identified during initial clustering."
homepage: https://workflowhub.eu/workflows/1362
---

# Subclustering

## Overview

This workflow is designed for single-cell RNA-seq analysis, specifically focusing on the subclustering of a defined cell population. Developed for the 2024 Bioinformatics Bootcamp at The Open University, it serves as a downstream analysis step following initial filtering and exploration. It allows researchers to isolate a specific cluster from a larger Louvain-annotated dataset to perform more granular investigation into cell subtypes.

The pipeline utilizes the [Scanpy](https://scanpy.readthedocs.io/) suite and AnnData operations to process the selected subset. Starting with both the unprocessed and annotated AnnData objects, the workflow filters genes and performs normalization and scaling. It then re-calculates principal components (PCA), neighborhood graphs, and embeddings (UMAP and tSNE) specifically for the subsetted data to reveal finer internal structures that may have been masked in the global analysis.

Key outputs include updated AnnData files and a comprehensive suite of visualizations, including PCA, tSNE, and UMAP plots categorized by observations of interest. Additionally, the workflow generates marker gene lists for the new subclusters, facilitating the biological characterization of specific cell populations. This training resource is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for single-cell research and public data use.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Filtered but unprocessed AnnData Object | data_input |  |
| 1 | Final object - including louvain annotation | data_input |  |
| 2 | Number of louvain cluster to investigate | parameter_input | Put here the cluster number you would like to investigate |
| 3 | Observation of interest-1 | parameter_input | Observation category should be in the metadata of the sample, such as genotype |


Ensure both input files are provided in `h5ad` format, specifically requiring the filtered raw AnnData object and the final processed object containing your Louvain cluster annotations. While these are handled as individual datasets, verify that the cluster number and observation parameters exactly match your existing metadata to ensure successful sub-selection. For a complete breakdown of parameter requirements and tool configurations, please consult the `README.md`. You may also use `planemo workflow_job_init` to create a `job.yml` file for streamlined job submission.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.8.1+galaxy93 |  |
| 5 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.7.5+galaxy1 |  |
| 6 | Scanpy FilterGenes | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_genes/scanpy_filter_genes/1.8.1+galaxy9 |  |
| 7 | Scanpy NormaliseData | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_normalise_data/scanpy_normalise_data/1.8.1+galaxy9 |  |
| 8 | Scanpy FindVariableGenes | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_variable_genes/scanpy_find_variable_genes/1.8.1+galaxy9 |  |
| 9 | Scanpy ScaleData | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_scale_data/scanpy_scale_data/1.8.1+galaxy9 |  |
| 10 | Scanpy RunPCA | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_pca/scanpy_run_pca/1.8.1+galaxy9 |  |
| 11 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 12 | Scanpy ComputeGraph | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_compute_graph/scanpy_compute_graph/1.8.1+galaxy9 |  |
| 13 | Scanpy RunTSNE | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_tsne/scanpy_run_tsne/1.8.1+galaxy9 |  |
| 14 | Scanpy RunUMAP | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_umap/scanpy_run_umap/1.8.1+galaxy9 |  |
| 15 | Scanpy FindCluster | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_cluster/scanpy_find_cluster/1.8.1+galaxy9 |  |
| 16 | Scanpy FindMarkers | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_markers/scanpy_find_markers/1.8.1+galaxy9 |  |
| 17 | Scanpy FindMarkers | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_markers/scanpy_find_markers/1.8.1+galaxy9 |  |
| 18 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 19 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 20 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 21 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 22 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 23 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 24 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 25 | Join two Datasets | join1 |  |
| 26 | Join two Datasets | join1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 11 | out_png | out_png |
| 15 | output_h5ad | output_h5ad |
| 19 | UMAP Plot by Obs-1 | output_png |
| 20 | PCA Plot by Obs-1 | output_png |
| 21 | tSNE Plot by Obs-1 | output_png |
| 22 | PCA Plot | output_png |
| 23 | tSNE Plot | output_png |
| 24 | UMAP Plot | output_png |
| 25 | Obs-1 Marker Gene List | out_file1 |
| 26 | Cluster Marker Gene List | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Subclustering.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Subclustering.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Subclustering.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Subclustering.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Subclustering.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Subclustering.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
