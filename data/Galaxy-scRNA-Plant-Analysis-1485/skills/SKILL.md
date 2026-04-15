---
name: scrna-plant-analysis
description: This Galaxy workflow performs downstream single-cell RNA-seq analysis for plant transcriptomics by processing CSV count matrices through ScanPy tools for filtering, normalization, and clustering. Use this skill when you need to identify distinct cell populations and compare gene expression profiles between wild-type and mutant plant tissues using single-cell transcriptomic data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# scrna-plant-analysis

## Overview

This workflow provides a comprehensive pipeline for downstream single-cell RNA (scRNA) plant analysis using the [ScanPy](https://scanpy.readthedocs.io/) framework within Galaxy. It is designed to process count matrices from different experimental conditions—such as the provided "SHR" and "WT" samples—integrating them into a unified AnnData object for comparative study.

The pipeline begins with data ingestion and rigorous quality control. Users can tune parameters for filtering, such as minimum genes per cell, minimum cells per gene, and maximum library size. Following filtering, the workflow performs data normalization and addresses confounding factors to ensure that biological signals are not obscured by technical noise.

For high-level analysis, the workflow executes dimensionality reduction and clustering using the Leiden algorithm. It generates several visual outputs, including cluster maps and diagnostic plots, to help researchers identify cell populations and infer trajectories. The final outputs include a concatenated dataset, a fully annotated AnnData object with cluster assignments, and a suite of PNG visualizations for biological interpretation.

This resource is tagged for [Transcriptomics](https://training.galaxyproject.org/training-material/topics/transcriptomics/) and single-cell analysis, following [GTN](https://training.galaxyproject.org/) standards. The workflow is shared under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license, making it a reusable tool for the plant research community.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Leiden Resolution | parameter_input |  |
| 1 | SHR (CSV.gz) | data_input |  |
| 2 | WT (CSV.gz) | data_input |  |
| 3 | Min Genes | parameter_input |  |
| 4 | Min Cells | parameter_input |  |
| 5 | Max Features | parameter_input |  |
| 6 | Max Lib Size | parameter_input |  |


Ensure your input count matrices for SHR and WT are provided in compressed CSV format (CSV.gz) to be correctly processed by the AnnData import tools. This workflow is designed to take individual datasets for each condition, which are then concatenated internally for downstream ScanPy analysis. Adjust the filtering parameters like Min Genes and Max Lib Size based on your specific plant species' quality control requirements. Refer to the accompanying README.md for comprehensive details on parameter selection and data preparation steps. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | Import Anndata and loom | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.7.5+galaxy0 |  |
| 8 | Import Anndata and loom | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.7.5+galaxy0 |  |
| 9 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.7.5+galaxy0 |  |
| 10 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.7.5+galaxy0 |  |
| 11 | Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.7.1+galaxy0 |  |
| 12 | Filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.7.1+galaxy0 |  |
| 13 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy0 |  |
| 14 | Filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.7.1+galaxy0 |  |
| 15 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.7.5+galaxy0 |  |
| 16 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.7.5+galaxy0 |  |
| 17 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.7.5+galaxy0 |  |
| 18 | Normalize | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_normalize/scanpy_normalize/1.7.1+galaxy0 |  |
| 19 | Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.7.1+galaxy0 |  |
| 20 | Remove confounders | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_remove_confounders/scanpy_remove_confounders/1.7.1+galaxy0 |  |
| 21 | Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.7.1+galaxy0 |  |
| 22 | Cluster, infer trajectories and embed | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_cluster_reduce_dimension/scanpy_cluster_reduce_dimension/1.7.1+galaxy0 |  |
| 23 | Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.7.1+galaxy0 |  |
| 24 | Cluster, infer trajectories and embed | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_cluster_reduce_dimension/scanpy_cluster_reduce_dimension/1.7.1+galaxy0 |  |
| 25 | Cluster, infer trajectories and embed | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_cluster_reduce_dimension/scanpy_cluster_reduce_dimension/1.7.1+galaxy0 |  |
| 26 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy0 |  |
| 27 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy0 |  |
| 28 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy0 |  |
| 29 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.7.5+galaxy0 |  |
| 30 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy0 |  |
| 31 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy0 |  |
| 32 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.7.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 10 | scRNA Concatenated Datasets | anndata |
| 13 | out_png | out_png |
| 25 | scRNA with clusters Dataset | anndata_out |
| 26 | out_png | out_png |
| 27 | out_png | out_png |
| 28 | out_png | out_png |
| 30 | out_png | out_png |
| 31 | out_png | out_png |
| 32 | out_png | out_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run scrna-plant-analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run scrna-plant-analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run scrna-plant-analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init scrna-plant-analysis.ga -o job.yml`
- Lint: `planemo workflow_lint scrna-plant-analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `scrna-plant-analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)