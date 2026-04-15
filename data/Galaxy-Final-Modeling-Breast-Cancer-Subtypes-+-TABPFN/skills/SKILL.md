---
name: final-modeling-breast-cancer-subtypes-tabpfn
description: This Galaxy workflow integrates clinical, gene expression, and copy number alteration data to classify breast cancer subtypes using Flexynesis and TabPFN machine learning models. Use this skill when you need to evaluate the predictive performance of multi-omic integration methods or visualize molecular embeddings for patient stratification in oncology research.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# final-modeling-breast-cancer-subtypes-tabpfn

## Overview

This workflow is designed for the classification of breast cancer subtypes using multi-omic data from the Metabric dataset. It integrates clinical information, gene expression (GEX), and copy number alteration (CNA) data to train and evaluate predictive models, facilitating a comprehensive analysis of molecular features associated with different cancer phenotypes.

The core of the analysis utilizes [Flexynesis](https://toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis/flexynesis/0.2.20+galaxy3), a deep learning-based framework for multi-omic data integration. The pipeline performs feature selection and generates various visualizations, including PCA and UMAP embedding plots, to analyze the latent space and assess how well the model distinguishes between subtypes.

In addition to Flexynesis, the workflow optionally employs [TabPFN](https://toolshed.g2.bx.psu.edu/repos/bgruening/tabpfn/tabpfn/2.0.9+galaxy0), a prior-data fitted network specifically optimized for tabular data prediction. By processing GEX and CNA data through both methods, the workflow enables a direct performance comparison via Precision-Recall (PR) curves and detailed prediction outputs.

This MIT-licensed toolset is tagged for [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) applications, leveraging standard Galaxy text processing and data extraction tools to streamline the machine learning pipeline from raw tabular inputs to final evaluation metrics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | clin_train | data_input | training clinical data |
| 1 | clin_test | data_input | test clinical data |
| 2 | gex_train | data_input | training omics 1 data |
| 3 | gex_test | data_input | test omics 1 data |
| 4 | cna_train | data_input | training omics 2 data |
| 5 | cna_test | data_input | test omics 2 data |
| 6 | number of features to keep | parameter_input | How many highly variable genes to include in TABPFN analysis? |
| 7 | Performe TABPFN? | parameter_input | TABPFN currently runs on CPU and it is super slow (~7 hours) |


Ensure all clinical, gene expression (GEX), and copy number alteration (CNA) inputs are provided as tabular files, maintaining consistent sample identifiers across the training and test sets for both Flexynesis and TabPFN modules. While this workflow utilizes individual datasets for multi-omic integration, ensure that the feature selection parameter is tuned appropriately to balance computational efficiency with model accuracy. For automated execution and parameter mapping, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on data preprocessing requirements and specific column formatting.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 8 | Flexynesis | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis/flexynesis/0.2.20+galaxy3 |  |
| 9 | Flexynesis | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis/flexynesis/0.2.20+galaxy3 |  |
| 10 | Prepare data for TABPFN | (subworkflow) |  |
| 11 | Prepare data for TABPFN | (subworkflow) |  |
| 12 | Extract dataset | __EXTRACT_DATASET__ |  |
| 13 | Extract dataset | __EXTRACT_DATASET__ |  |
| 14 | Extract dataset | __EXTRACT_DATASET__ |  |
| 15 | Extract dataset | __EXTRACT_DATASET__ |  |
| 16 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 17 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 18 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 19 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 20 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy2 |  |
| 21 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy2 |  |
| 22 | Flexynesis plot | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_plot/flexynesis_plot/0.2.20+galaxy3 |  |
| 23 | Tabular data prediction using TabPFN | toolshed.g2.bx.psu.edu/repos/bgruening/tabpfn/tabpfn/2.0.9+galaxy0 |  |
| 24 | Tabular data prediction using TabPFN | toolshed.g2.bx.psu.edu/repos/bgruening/tabpfn/tabpfn/2.0.9+galaxy0 |  |
| 25 | Flexynesis plot | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_plot/flexynesis_plot/0.2.20+galaxy3 |  |
| 26 | Flexynesis plot | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_plot/flexynesis_plot/0.2.20+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | flexynesis output | results |
| 9 | embedding plots pca | plots |
| 22 | PR curve - Flexynesis | plot_out |
| 23 | TABPFN predictions - gex | output_predicted_data |
| 23 | PR curve - TABPFN - gex | output_plot |
| 24 | PR curve - TABPFN - cna | output_plot |
| 24 | TABPFN predictions - cna | output_predicted_data |
| 25 | embedding plot umap - niter1 | plot_out |
| 26 | embedding plot umap - niter5 | plot_out |


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