---
name: scanpy-parameter-iterator-workflow-full-imported-from-url
description: "This single-cell RNA-seq workflow utilizes Scanpy tools and parameter iterators on AnnData objects to automate the generation of multiple clustering and dimensionality reduction results across a range of settings. Use this skill when you need to systematically evaluate how varying hyperparameters like resolution, perplexity, and neighbor counts impact cell population identification and visualization in transcriptomic data."
homepage: https://workflowhub.eu/workflows/1510
---

# Scanpy Parameter Iterator workflow full (imported from URL)

## Overview

This Galaxy workflow is designed for systematic parameter optimization in single-cell RNA-seq analysis using the Scanpy suite. It automates the process of testing multiple configurations for key analytical steps, such as clustering and dimensionality reduction, by iterating through various values for resolution, perplexity, and the number of neighbors.

The pipeline accepts AnnData objects containing PCA, graph, or UMAP data as primary inputs. It utilizes the [Scanpy ParameterIterator](https://toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_parameter_iterator) to feed these inputs into downstream tools, including `Scanpy FindCluster`, `Scanpy RunTSNE`, and `Scanpy RunUMAP`. This approach allows researchers to evaluate how different hyperparameter settings influence the resulting data structure and cluster assignments.

The final outputs consist of a comprehensive collection of AnnData objects and visualization plots generated via `Scanpy PlotEmbed`. These results are categorized by the specific parameter being tested—such as resolution-based PCA plots or perplexity-based t-SNE plots—enabling a side-by-side comparison to determine the most biologically relevant settings for a given dataset.

This workflow is associated with the [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/), making it a robust resource for reproducible single-cell bioinformatics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Scanpy RunPCA: AnnData object | data_input |  |
| 2 | Scanpy ComputeGraph on data X and data Y: Graph object AnnData | data_input |  |
| 4 | Scanpy RunUMAP on data X: UMAP object AnnData | data_input |  |


Ensure all input files are in the h5ad (AnnData) format, specifically providing the PCA-processed object, the graph object, and the UMAP-ready object as required by the initial steps. Since this workflow utilizes the Parameter Iterator to explore multiple variables, you should organize your inputs as individual datasets rather than collections to allow the iterator to correctly branch the downstream analysis. Refer to the README.md for comprehensive details on specific parameter ranges and expected metadata. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and precise parameter mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Scanpy ParameterIterator | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_parameter_iterator/scanpy_parameter_iterator/0.0.1+galaxy9 |  |
| 3 | Scanpy ParameterIterator | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_parameter_iterator/scanpy_parameter_iterator/0.0.1+galaxy9 |  |
| 5 | Scanpy ParameterIterator | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_parameter_iterator/scanpy_parameter_iterator/0.0.1+galaxy9 |  |
| 6 | Scanpy ComputeGraph | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_compute_graph/scanpy_compute_graph/1.8.1+galaxy9 |  |
| 7 | Scanpy RunTSNE | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_tsne/scanpy_run_tsne/1.8.1+galaxy9 |  |
| 8 | Scanpy FindCluster | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_cluster/scanpy_find_cluster/1.8.1+galaxy9 |  |
| 9 | Scanpy RunTSNE | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_tsne/scanpy_run_tsne/1.8.1+galaxy9 |  |
| 10 | Scanpy RunUMAP | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_umap/scanpy_run_umap/1.8.1+galaxy9 |  |
| 11 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 12 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 13 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 14 | Scanpy RunUMAP | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_umap/scanpy_run_umap/1.8.1+galaxy9 |  |
| 15 | Scanpy FindCluster | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_cluster/scanpy_find_cluster/1.8.1+galaxy9 |  |
| 16 | Scanpy FindCluster | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_cluster/scanpy_find_cluster/1.8.1+galaxy9 |  |
| 17 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 18 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | Scanpy ComputeGraph on collection X: Graph object AnnData (n-neighbours) | output_h5ad |
| 7 | Scanpy RunTSNE on collection X: tSNE object AnnData (perplexity) | output_h5ad |
| 8 | Scanpy FindCluster on collection X: Clusters AnnData (resolution) | output_h5ad |
| 9 | Scanpy RunTSNE on collection X: tSNE object AnnData (n-neighbours) | output_h5ad |
| 10 | Scanpy RunUMAP on collection X: UMAP object AnnData (perplexity) | output_h5ad |
| 11 | resolution_pca_plots | output_png |
| 12 | resolution_umap_plots | output_png |
| 13 | resolution_tsne_plots | output_png |
| 14 | Scanpy RunUMAP on collection X: UMAP object AnnData (n-neighbours) | output_h5ad |
| 15 | Scanpy FindCluster on collection X: Clusters AnnData (perplexity) | output_h5ad |
| 16 | Scanpy FindCluster on collection X: Clusters AnnData (n-neighbours) | output_h5ad |
| 17 | perplexity_plots | output_png |
| 18 | n-neighbors_plots | output_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run scanpy-parameter-iterator-workflow-full.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run scanpy-parameter-iterator-workflow-full.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run scanpy-parameter-iterator-workflow-full.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init scanpy-parameter-iterator-workflow-full.ga -o job.yml`
- Lint: `planemo workflow_lint scanpy-parameter-iterator-workflow-full.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `scanpy-parameter-iterator-workflow-full.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
