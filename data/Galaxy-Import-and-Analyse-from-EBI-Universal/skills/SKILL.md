---
name: locked-import-and-analyse-from-ebi-universal
description: This single-cell RNA-seq workflow imports datasets from the EBI Single Cell Expression Atlas using experiment accessions and performs a comprehensive Scanpy-based analysis including filtering, normalization, and dimensionality reduction. Use this skill when you need to retrieve public single-cell data to identify cell clusters, visualize gene expression patterns via UMAP or tSNE, and discover marker genes for specific biological observations.
homepage: https://usegalaxy.eu
metadata:
  docker_image: "N/A"
---

# locked-import-and-analyse-from-ebi-universal

## Overview

This workflow was developed for the 2024 Bioinformatics Bootcamp at The Open University to provide a streamlined pipeline for single-cell RNA-seq analysis. It allows users to import datasets directly from the [EBI Single Cell Expression Atlas (SCXA)](https://www.ebi.ac.uk/gxa/sc/home) using a specific experiment accession number, alongside user-defined observations of interest for downstream grouping.

The pipeline performs comprehensive data reformatting and quality control using the Scanpy suite. It automates the filtering of cells and genes based on mitochondrial content, UMI counts, and expression thresholds, mirroring the methodology found in the [Filter, plot and explore](https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/scrna-intro-scanpy/tutorial.html) Galaxy tutorial. Throughout this process, the workflow generates diagnostic scatter and violin plots to visualize the impact of filtering on the dataset.

Following QC, the workflow executes standard downstream analysis steps, including data normalization, scaling, and dimensionality reduction via PCA, tSNE, and UMAP. It concludes by identifying clusters and marker genes, producing final embeddings that map the initial observations of interest onto the processed data. This universal approach enables rapid exploration and visualization of public single-cell datasets within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | SC-Atlas experiment accession | parameter_input | EBI Single Cell Atlas accession for the experiment that you want to retrieve. |
| 1 | Observation of interest-1 | parameter_input | This should be the exact name of a category of interest from the cell metadata in the Obs layer of AnnData, for instance disease or genotype. This will also be used for an additional FindMarkers step. |
| 2 | Observation of interest-2 | parameter_input | This should be the exact name of a category of interest from the cell metadata in the Obs layer of AnnData, for instance disease or genotype. |


To begin, ensure you have the correct EBI SCXA experiment accession ID and the specific observation labels (e.g., cell type or disease state) required for the parameter inputs. The workflow automatically retrieves and processes essential single-cell file types, including the gene expression matrix (MTX), cell barcodes, and gene identifiers, which are then integrated into an AnnData (H5AD) object. While this workflow handles data retrieval internally, you can refer to the `README.md` for comprehensive details on specific parameter requirements and expected metadata formats. For automated testing or reproducible execution, you may use `planemo workflow_job_init` to generate a `job.yml` file. Ensure that any observation names provided match the column headers in the retrieved design file to avoid filtering errors during the Scanpy analysis stages.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | EBI SCXA Data Retrieval | toolshed.g2.bx.psu.edu/repos/ebi-gxa/retrieve_scxa/retrieve_scxa/v0.0.2+galaxy2 |  |
| 4 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 | Shows how mitochondrial genes are annotated. |
| 5 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.8+galaxy1 |  |
| 6 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 7 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.8+galaxy1 |  |
| 8 | Scanpy Read10x | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_read_10x/scanpy_read_10x/1.8.1+galaxy9 |  |
| 9 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.8.1+galaxy92 |  |
| 10 | Scanpy FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells/scanpy_filter_cells/1.8.1+galaxy9 |  |
| 11 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 12 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 13 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 14 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 15 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 16 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 17 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 18 | Scanpy FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells/scanpy_filter_cells/1.8.1+galaxy9 |  |
| 19 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 20 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 21 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 22 | Scanpy FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells/scanpy_filter_cells/1.8.1+galaxy9 |  |
| 23 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 24 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 25 | Scanpy FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells/scanpy_filter_cells/1.8.1+galaxy9 |  |
| 26 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 27 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 28 | Scanpy FilterGenes | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_genes/scanpy_filter_genes/1.8.1+galaxy9 |  |
| 29 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 30 | Scanpy NormaliseData | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_normalise_data/scanpy_normalise_data/1.8.1+galaxy9 |  |
| 31 | Scanpy FindVariableGenes | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_variable_genes/scanpy_find_variable_genes/1.8.1+galaxy9 |  |
| 32 | Scanpy ScaleData | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_scale_data/scanpy_scale_data/1.8.1+galaxy9 |  |
| 33 | Scanpy RunPCA | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_pca/scanpy_run_pca/1.8.1+galaxy9 |  |
| 34 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy1 |  |
| 35 | Scanpy ComputeGraph | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_compute_graph/scanpy_compute_graph/1.8.1+galaxy9 |  |
| 36 | Scanpy RunTSNE | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_tsne/scanpy_run_tsne/1.8.1+galaxy9 |  |
| 37 | Scanpy RunUMAP | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_umap/scanpy_run_umap/1.8.1+galaxy9 |  |
| 38 | Scanpy FindCluster | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_cluster/scanpy_find_cluster/1.8.1+galaxy9 |  |
| 39 | Scanpy FindMarkers | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_markers/scanpy_find_markers/1.8.1+galaxy9 |  |
| 40 | Scanpy FindMarkers | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_find_markers/scanpy_find_markers/1.8.1+galaxy9 |  |
| 41 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 42 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 43 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 44 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 45 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 46 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 47 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 48 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 49 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 50 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 51 | Join two Datasets | join1 |  |
| 52 | Join two Datasets | join1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | design_tsv | design_tsv |
| 3 | barcode_tsv | barcode_tsv |
| 3 | genes_tsv | genes_tsv |
| 3 | matrix_mtx | matrix_mtx |
| 4 | Mito genes check | output |
| 10 | output_h5ad | output_h5ad |
| 11 | Scatter - mito x genes | out_png |
| 12 | obs | obs |
| 13 | general | general |
| 14 | Scatter - mito x UMIs | out_png |
| 15 | Scatter - genes x UMIs | out_png |
| 16 | var | var |
| 17 | Violin - Obs-1 - log | out_png |
| 18 | output_h5ad | output_h5ad |
| 20 | General - Filterbygenes | general |
| 21 | Violin - Filterbygenes | out_png |
| 22 | Counts-filtered Object | output_h5ad |
| 23 | General - Filterbycounts | general |
| 24 | Violin - Filterbycounts | out_png |
| 25 | Mito-filtered Object | output_h5ad |
| 26 | General - Filterbymito | general |
| 27 | Violin - Filterbymito | out_png |
| 28 | Filtered Object | output_h5ad |
| 29 | General - Filtered object | general |
| 30 | output_h5ad | output_h5ad |
| 31 | output_h5ad | output_h5ad |
| 32 | output_h5ad | output_h5ad |
| 33 | output_h5ad | output_h5ad |
| 34 | PCA Variance | out_png |
| 35 | output_h5ad | output_h5ad |
| 36 | output_h5ad | output_h5ad |
| 37 | output_h5ad | output_h5ad |
| 38 | output_h5ad | output_h5ad |
| 39 | Final object | output_h5ad |
| 41 | PCA Plot | output_png |
| 42 | UMAP Plot | output_png |
| 43 | tSNE Plot | output_png |
| 45 | PCA Plot with Obs-1 | output_png |
| 46 | tSNE Plot with Obs-1 | output_png |
| 47 | UMAP Plot with Obs-1 | output_png |
| 48 | PCA Plot with Obs-2 | output_png |
| 49 | UMAP Plot with Obs-2 | output_png |
| 50 | tSNE Plot with Obs-2 | output_png |
| 51 | Cluster marker genes | out_file1 |
| 52 | Observation of interest 1 - marker genes | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-LOCKED___Import_and_Analyse_from_EBI_-_Universal.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-LOCKED___Import_and_Analyse_from_EBI_-_Universal.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-LOCKED___Import_and_Analyse_from_EBI_-_Universal.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-LOCKED___Import_and_Analyse_from_EBI_-_Universal.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-LOCKED___Import_and_Analyse_from_EBI_-_Universal.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-LOCKED___Import_and_Analyse_from_EBI_-_Universal.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)