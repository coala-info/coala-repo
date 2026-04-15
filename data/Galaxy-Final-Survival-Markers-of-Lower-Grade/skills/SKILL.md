---
name: final-survival-markers-of-lower-grade
description: This Galaxy workflow utilizes the Flexynesis machine learning tool to analyze clinical and multi-omics datasets for the identification of survival markers in lower-grade cancers. Use this skill when you need to integrate heterogeneous molecular data to predict patient survival outcomes and visualize risk group stratifications through Kaplan-Meier plots and PCA embeddings.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# final-survival-markers-of-lower-grade

## Overview

This workflow implements a machine learning pipeline designed to identify survival markers from multi-omics datasets, specifically targeting Lower Grade Glioma (LGG) and Glioblastoma (GBM). It is inspired by the [flexynesis analysis notebook](https://github.com/BIMSBbioinfo/flexynesis/blob/main/examples/tutorials/survival_subtypes_LGG_GBM.ipynb) and demonstrates how to integrate clinical data with multiple omics layers to predict patient outcomes.

The pipeline processes paired training and testing sets for clinical data and two distinct omics layers. It utilizes the [Flexynesis](https://github.com/BIMSBbioinfo/flexynesis) tool suite alongside data manipulation utilities like Datamash and text processing tools to prepare and analyze the high-dimensional biological data. The core logic focuses on training models that can effectively categorize risk groups based on molecular signatures.

Key outputs include comprehensive survival analysis visualizations, such as Cox proportional hazards models and Kaplan-Meier (KM) plots. Additionally, the workflow generates PCA embedding plots to visualize the separation between high- and low-risk groups, providing clear insights into the predictive power of the identified markers.

This MIT-licensed workflow is a valuable resource for researchers exploring [Machine Learning](https://galaxyproject.org/use/machine-learning/) applications in bioinformatics and follows practices aligned with the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | clinical_train | data_input | clinical training file |
| 1 | clinical_test | data_input | clinical test file |
| 2 | omics1_train | data_input | omics 1 training file |
| 3 | omics1_test | data_input | omics 1 test file |
| 4 | omics2_train | data_input | omics 2 training file |
| 5 | omics2_test | data_input | omics 2 test file |


Ensure all clinical and omics inputs are provided in tabular format (TSV or CSV) with consistent sample identifiers across the training and testing sets. While the workflow accepts individual datasets, using data collections can help manage the multiple omics layers more efficiently during large-scale analyses. Consult the README.md for specific details on required data structures and the multi-omics integration logic used by Flexynesis. For automated execution, use `planemo workflow_job_init` to create a `job.yml` file that maps these inputs correctly.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Flexynesis | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis/flexynesis/0.2.20+galaxy3 |  |
| 7 | Extract dataset | __EXTRACT_DATASET__ |  |
| 8 | Extract dataset | __EXTRACT_DATASET__ |  |
| 9 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.9+galaxy0 |  |
| 10 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 11 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.5+galaxy2 |  |
| 12 | Flexynesis plot | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_plot/flexynesis_plot/0.2.20+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | Cox and KM plots | plots |
| 6 | flexynesis output | results |
| 12 | High-Low_risk_groups_embedding_pca_plot | plot_out |


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