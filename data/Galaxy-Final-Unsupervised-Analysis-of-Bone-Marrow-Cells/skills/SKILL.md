---
name: final-unsupervised-analysis-of-bone-marrow-cells
description: "This Galaxy workflow performs unsupervised classification of bone marrow cells by integrating multi-omics and clinical datasets using the Flexynesis deep learning framework. Use this skill when you need to identify latent cell populations and evaluate clustering consistency across high-dimensional multi-omics datasets from bone marrow samples."
homepage: https://workflowhub.eu/workflows/1852
---

# Final - Unsupervised Analysis of Bone Marrow Cells

## Overview

This workflow performs unsupervised classification of bone marrow cells using the [Flexynesis](https://github.com/BIMSBbioinfo/flexynesis) deep learning framework. Inspired by the [original analysis notebook](https://github.com/BIMSBbioinfo/flexynesis/blob/main/examples/tutorials/unsupervised_analysis_single_cell.ipynb), the pipeline is designed to integrate multi-omic datasets to identify cellular patterns and clusters without the need for predefined labels.

The process begins by ingesting clinical data and two distinct omics data types, partitioned into training and testing sets. Using the Flexynesis tool suite, the workflow executes deep learning-based feature extraction and dimensionality reduction to prepare the multi-modal data for unsupervised analysis.

Key outputs include clustering results generated via Louvain and K-means algorithms. The workflow evaluates these clusters by calculating Adjusted Rand Index (ARI) metrics against ground truth labels and generates UMAP visualizations to compare predicted clusters with true cell identities. Additionally, concordance plots are produced to assess the consistency of the integration across different data modalities.

Licensed under the MIT license, this toolset is optimized for Galaxy environments and serves as a robust resource for machine learning applications in single-cell biology. It is particularly useful for researchers following [GTN](https://training.galaxyproject.org/) tutorials or those seeking to implement deep learning-based omics integration.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | train clinincal data | data_input | clinical training data |
| 1 | test clinincal data | data_input | clinical test data |
| 2 | train omics 1 | data_input | omics 1 training data |
| 3 | test omics 1 | data_input | omics 1 test data |
| 4 | train omics 2 | data_input | omics 2 training data |
| 5 | test omics 2 | data_input | omics 2 test data |


Ensure your input files for clinical data and omics layers are in tabular format (CSV or TSV) to maintain compatibility with the Flexynesis tool suite. Since the workflow requires separate training and testing datasets for each modality, organizing these into a Galaxy data collection can streamline the mapping process. Refer to the README.md for specific column requirements and preprocessing steps necessary for successful unsupervised classification. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Flexynesis | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis/flexynesis/0.2.20+galaxy3 |  |
| 7 | Extract dataset | __EXTRACT_DATASET__ |  |
| 8 | Flexynesis utils | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_utils/flexynesis_utils/0.2.20+galaxy3 |  |
| 9 | Flexynesis plot | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_plot/flexynesis_plot/0.2.20+galaxy3 |  |
| 10 | Flexynesis utils | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_utils/flexynesis_utils/0.2.20+galaxy3 |  |
| 11 | Flexynesis plot | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_plot/flexynesis_plot/0.2.20+galaxy3 |  |
| 12 | Flexynesis utils | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_utils/flexynesis_utils/0.2.20+galaxy3 |  |
| 13 | Flexynesis utils | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_utils/flexynesis_utils/0.2.20+galaxy3 |  |
| 14 | Flexynesis plot | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_plot/flexynesis_plot/0.2.20+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | flexynesis output | results |
| 8 | louvain clustering | util_out |
| 9 | umap - true_value | plot_out |
| 10 | k-means clustering | util_out |
| 11 | concordance plot | plot_out |
| 12 | amir_ari true vs louvain | util_out |
| 13 | amir_ari true vs k-means | util_out |
| 14 | umap - louvain | plot_out |


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
