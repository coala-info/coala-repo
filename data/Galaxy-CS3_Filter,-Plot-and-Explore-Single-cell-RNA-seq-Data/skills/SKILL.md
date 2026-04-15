---
name: cs3_filter-plot-and-explore-single-cell-rna-seq-data
description: This transcriptomics workflow processes mito-counted AnnData using Scanpy tools to perform quality control filtering, normalization, dimensionality reduction, and clustering of single-cell RNA-seq data. Use this skill when you need to remove low-quality cells, identify distinct cell populations through unsupervised clustering, and discover cluster-specific marker genes to characterize cellular heterogeneity.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# cs3_filter-plot-and-explore-single-cell-rna-seq-data

## Overview

This Galaxy workflow provides a comprehensive pipeline for the quality control, filtering, and downstream analysis of single-cell RNA-seq (scRNA-seq) data using the Scanpy suite. Starting from a mitochondrial-counted AnnData object, the workflow performs rigorous cell and gene filtering based on parameters such as UMI counts, gene expression per cell, and mitochondrial content. It utilizes extensive visualization steps, including violin and scatter plots, to inspect the data distribution across genotypes, batches, and sexes before and after filtering.

Following data cleaning, the workflow executes standard secondary analysis steps: normalization, identification of highly variable genes, and data scaling. It then performs dimensionality reduction via PCA, t-SNE, and UMAP to facilitate cluster identification and visualization. The pipeline concludes by finding marker genes for clusters and genotypes, generating embedding plots, and exporting the final processed AnnData object for further exploration.

This workflow is designed for [transcriptomics](https://galaxyproject.org/use/transcriptomics/) and [single-cell](https://singlecell.usegalaxy.eu/) research and is aligned with [GTN](https://training.galaxyproject.org/) training standards. It was updated in August 2022 to ensure compatibility with modern tool versions and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Mito-counted AnnData | data_input |  |


The primary input for this workflow is a single-cell AnnData object in `.h5ad` format, which must already contain mitochondrial count information within its metadata. While the workflow is configured for a single dataset, you can efficiently process multiple samples by organizing your files into a dataset collection before execution. Ensure that your input file includes the necessary `obs` and `var` annotations required by Scanpy for filtering and downstream visualization. For comprehensive instructions on preparing your data and specific parameter settings, please refer to the accompanying `README.md`. You can also automate the configuration of these inputs by generating a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 2 | Scanpy FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells/scanpy_filter_cells/1.8.1+galaxy0 |  |
| 3 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 4 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 5 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 6 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 7 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 8 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 9 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 10 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 11 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 12 | Scanpy FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells/scanpy_filter_cells/1.8.1+galaxy0 |  |
| 13 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 14 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 15 | Scanpy FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells/scanpy_filter_cells/1.8.1+galaxy0 |  |
| 16 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 17 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 18 | Scanpy FilterGenes | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_genes/scanpy_filter_genes/1.8.1+galaxy0 |  |
| 19 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 20 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 21 | Scanpy NormaliseData | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_normalise_data/scanpy_normalise_data/1.8.1+galaxy0 |  |
| 22 | Scanpy FindVariableGenes | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_variable_genes/scanpy_find_variable_genes/1.8.1+galaxy0 |  |
| 23 | Scanpy ScaleData | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_scale_data/scanpy_scale_data/1.8.1+galaxy0 |  |
| 24 | Scanpy RunPCA | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_pca/scanpy_run_pca/1.8.1+galaxy0 |  |
| 25 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 26 | Scanpy ComputeGraph | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_compute_graph/scanpy_compute_graph/1.8.1+galaxy1 |  |
| 27 | Scanpy RunTSNE | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_tsne/scanpy_run_tsne/1.8.1+galaxy1 |  |
| 28 | Scanpy RunUMAP | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_umap/scanpy_run_umap/1.8.1+galaxy0 |  |
| 29 | Scanpy FindCluster | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_cluster/scanpy_find_cluster/1.8.1+galaxy0 |  |
| 30 | Scanpy FindMarkers | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_markers/scanpy_find_markers/1.8.1+galaxy0 |  |
| 31 | Scanpy FindMarkers | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_markers/scanpy_find_markers/1.8.1+galaxy0 |  |
| 32 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy0 |  |
| 33 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy0 |  |
| 34 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.7.5+galaxy1 |  |
| 35 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy0 |  |
| 36 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 37 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.8.1+galaxy0 |  |
| 38 | Join two Datasets | join1 |  |
| 39 | Join two Datasets | join1 |  |
| 40 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.8.1+galaxy0 |  |
| 41 | Cut | Cut1 |  |
| 42 | Cut | Cut1 |  |
| 43 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | obs | obs |
| 2 | Genes-filtered Object | output_h5ad |
| 3 | Scatter - genes x UMIs | out_png |
| 4 | Scatter - mito x genes | out_png |
| 5 | Violin - genotype - log | out_png |
| 6 | Violin - batch - log | out_png |
| 7 | var | var |
| 8 | Scatter - mito x UMIs | out_png |
| 9 | general | general |
| 10 | Violin - sex - log | out_png |
| 11 | Violin - Filterbygenes | out_png |
| 12 | Counts-filtered Object | output_h5ad |
| 13 | General - Filterbygenes | general |
| 14 | General - Filterbycounts | general |
| 15 | Mito-filtered Object | output_h5ad |
| 16 | Violin - Filterbycounts | out_png |
| 17 | General - Filterbymito | general |
| 18 | Filtered Object | output_h5ad |
| 19 | Violin - Filterbymito | out_png |
| 20 | General - Filtered object | general |
| 21 | output_h5ad | output_h5ad |
| 22 | output_h5ad | output_h5ad |
| 23 | output_h5ad | output_h5ad |
| 24 | output_h5ad | output_h5ad |
| 25 | PCA Variance | out_png |
| 26 | output_h5ad | output_h5ad |
| 27 | output_h5ad | output_h5ad |
| 27 | output_embed | output_embed |
| 28 | output_embed | output_embed |
| 28 | output_h5ad | output_h5ad |
| 29 | output_txt | output_txt |
| 29 | output_h5ad | output_h5ad |
| 30 | Markers - cluster | output_tsv |
| 30 | Final object | output_h5ad |
| 31 | Markers - genotype | output_tsv |
| 32 | output_png | output_png |
| 33 | output_png | output_png |
| 34 | anndata | anndata |
| 35 | output_png | output_png |
| 36 | var | var |
| 37 | output_h5ad | output_h5ad |
| 38 | out_file1 | out_file1 |
| 39 | out_file1 | out_file1 |
| 40 | Final cell annotated object | output_h5ad |
| 41 | Markers - cluster - named | out_file1 |
| 42 | Markers - genotype - named | out_file1 |
| 43 | output_png | output_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run cs3-filter--plot-and-explore-single-cell-rna-seq-data.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run cs3-filter--plot-and-explore-single-cell-rna-seq-data.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run cs3-filter--plot-and-explore-single-cell-rna-seq-data.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init cs3-filter--plot-and-explore-single-cell-rna-seq-data.ga -o job.yml`
- Lint: `planemo workflow_lint cs3-filter--plot-and-explore-single-cell-rna-seq-data.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `cs3-filter--plot-and-explore-single-cell-rna-seq-data.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)