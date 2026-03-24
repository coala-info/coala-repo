---
name: scrna-plant-analysis
description: "This Galaxy workflow processes plant single-cell RNA-seq count matrices using ScanPy and AnnData tools to perform quality control, normalization, and dimensionality reduction. Use this skill when you need to identify cell clusters, compare transcriptomic profiles between wild-type and mutant plant samples, and visualize gene expression patterns across different cell populations."
homepage: https://workflowhub.eu/workflows/1574
---

# scRNA Plant Analysis

## Overview

This Galaxy workflow provides a comprehensive pipeline for downstream single-cell RNA (scRNA) analysis in plants, specifically designed to process and compare wild-type (WT) and mutant (SHR) samples. Utilizing the [ScanPy](https://scanpy.readthedocs.io/en/stable/) ecosystem, the workflow automates the transition from raw count matrices to clustered visualizations, enabling researchers to identify cell-specific expression patterns and transcriptomic differences.

The process begins by importing and concatenating CSV data into the AnnData format. It performs rigorous quality control and preprocessing, including filtering based on minimum genes, cell counts, and library size, followed by normalization and the removal of confounding variables. These steps ensure that the resulting data is clean and comparable across different experimental conditions.

Advanced analytical steps include dimensionality reduction and clustering using the Leiden algorithm. The workflow generates several visual outputs, such as UMAP or t-SNE plots, to illustrate cluster distributions and gene expression profiles. By integrating [GTN](https://training.galaxyproject.org/) standards, this tool offers a robust framework for exploring plant transcriptomics at single-cell resolution.

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


Ensure the input expression matrices for the SHR and WT samples are provided as compressed CSV files (`CSV.gz`) to ensure compatibility with the initial AnnData import steps. While this workflow targets individual datasets, you may find it helpful to organize your raw files into a collection before assigning them to the specific data input slots. Adjust the numerical parameters, such as Leiden resolution and filtering thresholds, to suit the specific cell density and library quality of your plant tissue. For comprehensive guidance on parameter selection and data structure, please refer to the `README.md` file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution.

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
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
