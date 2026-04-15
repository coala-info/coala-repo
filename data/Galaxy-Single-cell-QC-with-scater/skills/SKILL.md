---
name: single-cell-qc-with-scater
description: This single-cell transcriptomics workflow processes count matrices, annotations, and mitochondrial control lists using Scater to calculate quality control metrics and filter Single Cell Experiment objects. Use this skill when you need to identify and remove low-quality cells from single-cell RNA-seq data based on library size, mitochondrial content, and gene expression patterns to ensure reliable downstream analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# single-cell-qc-with-scater

## Overview

This workflow performs comprehensive quality control (QC) on single-cell RNA-seq data using the [scater](https://bioconductor.org/packages/release/bioc/html/scater.html) package. It processes a counts matrix alongside cell annotations and mitochondrial control lists to identify and remove low-quality cells that could otherwise bias downstream transcriptomics analysis.

The pipeline begins by calculating essential QC metrics and generating diagnostic library plots to visualize the initial state of the data. It then applies filtering steps to exclude outliers based on library size and feature counts. After filtering, the workflow generates updated distribution plots and a PCA plot to assess the impact of the QC process on the dataset's dimensionality.

The final outputs include comparative QC visualizations, a PCA plot, and a cleaned dataset in Loom format ready for further analysis. This workflow is based on [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) materials and is provided under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | annotation.txt | data_input |  |
| 1 | counts.txt | data_input |  |
| 2 | mt_controls.txt | data_input |  |


Ensure your input files are formatted as tab-separated text files, providing the raw count matrix, cell/gene annotations, and a list of mitochondrial genes for quality control. While these inputs are typically processed as individual datasets, verify that the identifiers in the annotation file strictly match the headers in your count matrix. Refer to the `README.md` for specific formatting requirements and detailed descriptions of the expected metadata columns. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Scater: Calculate QC metrics | toolshed.g2.bx.psu.edu/repos/iuc/scater_create_qcmetric_ready_sce/scater_create_qcmetric_ready_sce/1.12.2 |  |
| 4 | Scater: plot library QC | toolshed.g2.bx.psu.edu/repos/iuc/scater_plot_dist_scatter/scater_plot_dist_scatter/1.12.2 |  |
| 5 | Scater: filter SCE | toolshed.g2.bx.psu.edu/repos/iuc/scater_filter/scater_filter/1.12.2 |  |
| 6 | Scater: plot library QC | toolshed.g2.bx.psu.edu/repos/iuc/scater_plot_dist_scatter/scater_plot_dist_scatter/1.12.2 |  |
| 7 | Scater: PCA plot | toolshed.g2.bx.psu.edu/repos/iuc/scater_plot_pca/scater_plot_pca/1.12.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | lib_qc_plot | output_plot |
| 5 | output_loom | output_loom |
| 6 | filtered_lib_qc_plot | output_plot |
| 7 | pca_plot | output_plot |


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