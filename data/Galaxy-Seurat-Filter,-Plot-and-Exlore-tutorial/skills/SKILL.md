---
name: seurat-filter-plot-and-exlore-tutorial
description: "This single-cell RNA-seq workflow retrieves data from the EBI Single Cell Expression Atlas and performs quality control, normalization, and clustering using the Seurat toolkit. Use this skill when you need to process raw expression matrices to identify distinct cell populations and visualize high-dimensional transcriptomic data through UMAP projections."
homepage: https://workflowhub.eu/workflows/1570
---

# Seurat Filter, Plot and Exlore tutorial

## Overview

This workflow implements a standard single-cell RNA-seq analysis pipeline using the Seurat framework within Galaxy. It begins by retrieving expression data from the [EBI Single Cell Expression Atlas (SCXA)](https://www.ebi.ac.uk/gxa/sc/home) and importing the raw counts into a Seurat-compatible format. The initial stages focus on data inspection and quality control, allowing users to filter out low-quality cells before proceeding to downstream analysis.

Following data cleanup, the pipeline performs essential preprocessing steps including library size normalization, identification of highly variable genes, and data scaling. These steps ensure that biological signals are prioritized over technical noise, preparing the dataset for effective dimensionality reduction.

The final stages of the workflow involve Principal Component Analysis (PCA) and graph-based clustering to identify distinct cell populations. The results are visualized using UMAP plots, providing an intuitive map of the cellular landscape. This tutorial-based workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is designed in alignment with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) standards for single-cell exploration.

## Inputs and data preparation

_None listed._


Ensure you have the required matrix (MTX), gene/feature (TSV), and barcode (TSV) files ready, as these are essential for the initial Seurat Read10x step. While the workflow can process individual datasets, using dataset collections is recommended when handling multiple samples to streamline the downstream filtering and clustering processes. Refer to the accompanying README.md for comprehensive details on parameter settings and specific data preparation requirements. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and easier management of input parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | EBI SCXA Data Retrieval | toolshed.g2.bx.psu.edu/repos/ebi-gxa/retrieve_scxa/retrieve_scxa/v0.0.2+galaxy2 |  |
| 1 | Seurat Read10x | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_read10x/seurat_read10x/4.0.4+galaxy0 |  |
| 2 | Plot | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_plot/seurat_plot/4.0.4+galaxy0 |  |
| 3 | Seurat FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_filter_cells/seurat_filter_cells/4.0.4+galaxy0 |  |
| 4 | Seurat NormaliseData | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_normalise_data/seurat_normalise_data/4.0.4+galaxy0 |  |
| 5 | Seurat FindVariableGenes | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_find_variable_genes/seurat_find_variable_genes/4.0.4+galaxy0 |  |
| 6 | Seurat ScaleData | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_scale_data/seurat_scale_data/4.0.4+galaxy0 |  |
| 7 | Seurat RunPCA | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_run_pca/seurat_run_pca/4.0.4+galaxy0 |  |
| 8 | Seurat FindNeighbours | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_find_neighbours/seurat_find_neighbours/4.0.4+galaxy0 |  |
| 9 | Seurat FindClusters | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_find_clusters/seurat_find_clusters/4.0.4+galaxy0 |  |
| 10 | Seurat UMAP | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_run_umap/seurat_run_umap/4.0.4+galaxy0 |  |
| 11 | Plot | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_plot/seurat_plot/4.0.4+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | matrix_mtx | matrix_mtx |
| 0 | genes_tsv | genes_tsv |
| 0 | design_tsv | design_tsv |
| 0 | barcode_tsv | barcode_tsv |
| 9 | rds_seurat_clusters | rds_seurat_file |
| 10 | rds_seurat_umap | rds_seurat_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow-seurat-filter-plot-explore.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow-seurat-filter-plot-explore.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow-seurat-filter-plot-explore.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow-seurat-filter-plot-explore.ga -o job.yml`
- Lint: `planemo workflow_lint workflow-seurat-filter-plot-explore.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow-seurat-filter-plot-explore.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
