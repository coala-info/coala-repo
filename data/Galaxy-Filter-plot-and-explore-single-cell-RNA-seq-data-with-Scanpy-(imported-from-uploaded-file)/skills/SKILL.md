---
name: filter-plot-and-explore-single-cell-rna-seq-data-with-scanpy
description: "This workflow processes batched AnnData files for single-cell RNA-seq analysis using Scanpy and AnnData tools to perform quality control, filtering, normalization, and dimensionality reduction. Use this skill when you need to identify cell clusters, visualize gene expression patterns, and perform marker gene analysis on pre-processed single-cell transcriptomic datasets."
homepage: https://workflowhub.eu/workflows/1501
---

# Filter plot and explore single-cell RNA-seq data with Scanpy (imported from uploaded file)

## Overview

This Galaxy workflow provides a comprehensive pipeline for the quality control, filtering, and exploratory analysis of single-cell RNA-seq data using the Scanpy suite. Starting from a batched AnnData object, the workflow performs rigorous data inspection and multi-step filtering based on gene counts, UMI counts, and mitochondrial content. It generates a series of diagnostic plots, such as violin and scatter plots, to visualize the impact of these QC metrics across different genotypes, sexes, and batches.

Following initial preprocessing, the workflow executes data normalization, logarithmization, and scaling. It identifies highly variable genes and performs dimensionality reduction through PCA, tSNE, and UMAP. The pipeline concludes with automated clustering and the identification of marker genes (ranked genes) by cluster and genotype, producing annotated objects and final visualization plots for biological interpretation.

This workflow is based on the [GTN training material](https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/scrna-case_basic-pipeline/tutorial.html) for basic single-cell RNA-seq pipelines. It is released under an MIT license and is tagged for single-cell analysis and training purposes.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Batched_AnnData | data_input | The output from this tutorial: https://training.galaxyproject.org/training-material//topics/single-cell/tutorials/scrna-case_alevin-combine-datasets/tutorial.html This is an AnnData object that has a column declaring which genes are mitochondrial or not. |


To run this workflow, ensure your input is a single AnnData file (h5ad format) containing the batched single-cell counts and relevant metadata. If your data is split across multiple files, you must first merge them into a single dataset before processing. For automated execution and parameter management, you can use `planemo workflow_job_init` to generate a `job.yml` file. Detailed instructions on specific filtering thresholds and metadata requirements are available in the README.md. Please refer to the README.md for a comprehensive guide on preparing your environment and data.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Scanpy Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.10.2+galaxy2 |  |
| 2 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |
| 3 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |
| 4 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |
| 5 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy3 |  |
| 6 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 7 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 8 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 9 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 10 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 11 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 12 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy3 |  |
| 13 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 14 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy3 |  |
| 15 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy3 |  |
| 16 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 17 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy3 |  |
| 18 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 19 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy3 |  |
| 20 | Scanpy normalize | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_normalize/scanpy_normalize/1.10.2+galaxy0 |  |
| 21 | Scanpy Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.10.2+galaxy1 |  |
| 22 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy1 |  |
| 23 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy3 |  |
| 24 | Scanpy Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.10.2+galaxy1 |  |
| 25 | Scanpy cluster, embed | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_cluster_reduce_dimension/scanpy_cluster_reduce_dimension/1.10.2+galaxy2 |  |
| 26 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 27 | Scanpy Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.10.2+galaxy1 |  |
| 28 | Scanpy cluster, embed | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_cluster_reduce_dimension/scanpy_cluster_reduce_dimension/1.10.2+galaxy2 |  |
| 29 | Scanpy cluster, embed | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_cluster_reduce_dimension/scanpy_cluster_reduce_dimension/1.10.2+galaxy2 |  |
| 30 | Scanpy cluster, embed | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_cluster_reduce_dimension/scanpy_cluster_reduce_dimension/1.10.2+galaxy2 |  |
| 31 | Scanpy Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.10.2+galaxy1 |  |
| 32 | Scanpy Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.10.2+galaxy1 |  |
| 33 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 34 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 35 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 36 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy1 |  |
| 37 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | QC_Object | anndata_out |
| 2 | general | general |
| 3 | obs | obs |
| 4 | var | var |
| 5 | Genes_Part_Object | anndata_out |
| 6 | Violin_log_genotype | out_png |
| 7 | Violin_log_sex | out_png |
| 8 | Scatter_GenesxUMI | out_png |
| 9 | Violin_log_batch | out_png |
| 10 | Scatter_GenesxMito | out_png |
| 11 | Scatter_UMIxMito | out_png |
| 12 | Genes_Filtered_Object | anndata_out |
| 13 | Violin_log_genotype-Genes | out_png |
| 14 | UMI_Part_Object | anndata_out |
| 15 | UMI_Filtered_Object | anndata_out |
| 16 | Violin_log_genotype-UMIs | out_png |
| 17 | Mito_Filtered_Object | anndata_out |
| 18 | Violin_log_genotype-Mito | out_png |
| 19 | Cells_Filtered_Object | anndata_out |
| 20 | Normalised_Object | anndata_out |
| 21 | Logarithmised_Object | anndata_out |
| 22 | Frozen_Object | anndata |
| 23 | FVG_Object | anndata_out |
| 24 | Scaled_Object | anndata_out |
| 25 | PCA_Object | anndata_out |
| 26 | PCA_Variance_Plot | out_png |
| 27 | Neighbours_Object | anndata_out |
| 28 | tSNE_Object | anndata_out |
| 29 | UMAP_Object | anndata_out |
| 30 | Clustered_Object | anndata_out |
| 31 | Ranked_Genes-by_Genotype | ranked_gene |
| 32 | Ranked_Genes-Cluster | ranked_gene |
| 32 | anndata_out | anndata_out |
| 33 | tSNE_Plot | out_png |
| 34 | PCA_Plot | out_png |
| 35 | UMAP_Plot | out_png |
| 36 | Annotated_Object | anndata |
| 37 | Annotated_Plots | out_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run filter-plot-and-explore-single-cell-rna-seq-data-with-scanpy.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run filter-plot-and-explore-single-cell-rna-seq-data-with-scanpy.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run filter-plot-and-explore-single-cell-rna-seq-data-with-scanpy.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init filter-plot-and-explore-single-cell-rna-seq-data-with-scanpy.ga -o job.yml`
- Lint: `planemo workflow_lint filter-plot-and-explore-single-cell-rna-seq-data-with-scanpy.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `filter-plot-and-explore-single-cell-rna-seq-data-with-scanpy.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
