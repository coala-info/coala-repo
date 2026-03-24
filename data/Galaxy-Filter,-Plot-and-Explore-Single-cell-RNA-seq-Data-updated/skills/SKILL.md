---
name: filter-plot-and-explore-single-cell-rna-seq-data-updated
description: "This transcriptomics workflow processes mito-counted AnnData using Scanpy tools to perform quality control filtering, normalization, dimensionality reduction, and clustering of single-cell RNA-seq data. Use this skill when you need to identify distinct cell populations and their marker genes from raw expression counts while removing low-quality cells and technical noise."
homepage: https://workflowhub.eu/workflows/1496
---

# Filter, Plot and Explore Single-cell RNA-seq Data updated

## Overview

This workflow provides a comprehensive pipeline for the downstream analysis of single-cell RNA-seq (scRNA-seq) data, following [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) best practices for transcriptomics. Starting with a mitochondrial-counted AnnData object, the pipeline automates the transition from raw counts to biological clusters, allowing for rigorous quality control and data exploration within the Galaxy ecosystem.

The process begins with extensive quality control using `Scanpy` to filter cells and genes based on UMI counts and mitochondrial content. It generates a series of diagnostic visualizations, including violin and scatter plots, to inspect data distributions at multiple filtering stages. Following QC, the workflow performs data normalization, identifies highly variable genes, and scales the data to prepare for dimensionality reduction.

For advanced data exploration, the workflow executes PCA, computes neighborhood graphs, and generates both t-SNE and UMAP embeddings. It further performs automated clustering and identifies marker genes to distinguish between different cell populations or genotypes. The final outputs include processed AnnData objects and high-resolution embedding plots ready for biological interpretation.

For detailed instructions on configuration and usage, please refer to the [README.md](README.md) in the Files section. This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for use in Transcriptomics and GTN-based analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Mito-counted AnnData | data_input |  |


This workflow requires a single AnnData (`.h5ad`) file containing mito-counted single-cell transcriptomics data as the primary input. Ensure your dataset is correctly formatted with mitochondrial gene counts stored in the observation metadata (`obs`) to facilitate the downstream filtering and plotting steps. For large-scale analyses involving multiple samples, consider organizing your files into a dataset collection before execution. Detailed parameter settings and metadata requirements are documented in the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 2 | Scanpy FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells/scanpy_filter_cells/1.8.1+galaxy9 |  |
| 3 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 4 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 5 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 6 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 7 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 8 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 9 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 10 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 11 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 12 | Scanpy FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells/scanpy_filter_cells/1.8.1+galaxy9 |  |
| 13 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 14 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 15 | Scanpy FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells/scanpy_filter_cells/1.8.1+galaxy9 |  |
| 16 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 17 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 18 | Scanpy FilterGenes | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_genes/scanpy_filter_genes/1.8.1+galaxy9 |  |
| 19 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 20 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 21 | Scanpy NormaliseData | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_normalise_data/scanpy_normalise_data/1.8.1+galaxy9 |  |
| 22 | Scanpy FindVariableGenes | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_variable_genes/scanpy_find_variable_genes/1.8.1+galaxy9 |  |
| 23 | Scanpy ScaleData | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_scale_data/scanpy_scale_data/1.8.1+galaxy9 |  |
| 24 | Scanpy RunPCA | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_pca/scanpy_run_pca/1.8.1+galaxy9 |  |
| 25 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 26 | Scanpy ComputeGraph | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_compute_graph/scanpy_compute_graph/1.8.1+galaxy9 |  |
| 27 | Scanpy RunTSNE | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_tsne/scanpy_run_tsne/1.8.1+galaxy9 |  |
| 28 | Scanpy RunUMAP | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_umap/scanpy_run_umap/1.8.1+galaxy9 |  |
| 29 | Scanpy FindCluster | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_cluster/scanpy_find_cluster/1.8.1+galaxy9 |  |
| 30 | Scanpy FindMarkers | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_markers/scanpy_find_markers/1.8.1+galaxy9 |  |
| 31 | Scanpy FindMarkers | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_markers/scanpy_find_markers/1.8.1+galaxy9 |  |
| 32 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 33 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 34 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.7.5+galaxy1 |  |
| 35 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 36 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 37 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.8.1+galaxy91 |  |
| 38 | Join two Datasets | join1 |  |
| 39 | Join two Datasets | join1 |  |
| 40 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.8.1+galaxy91 |  |
| 41 | Cut | Cut1 |  |
| 42 | Cut | Cut1 |  |
| 43 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |


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
| 22 | Use_me_FVG | output_h5ad |
| 23 | Use_me_Scaled | output_h5ad |
| 24 | output_h5ad | output_h5ad |
| 25 | PCA Variance | out_png |
| 26 | output_h5ad | output_h5ad |
| 27 | output_embed | output_embed |
| 27 | output_h5ad | output_h5ad |
| 28 | output_h5ad | output_h5ad |
| 28 | output_embed | output_embed |
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
planemo run filter--plot-and-explore-single-cell-rna-seq-data-updated.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run filter--plot-and-explore-single-cell-rna-seq-data-updated.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run filter--plot-and-explore-single-cell-rna-seq-data-updated.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init filter--plot-and-explore-single-cell-rna-seq-data-updated.ga -o job.yml`
- Lint: `planemo workflow_lint filter--plot-and-explore-single-cell-rna-seq-data-updated.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `filter--plot-and-explore-single-cell-rna-seq-data-updated.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
