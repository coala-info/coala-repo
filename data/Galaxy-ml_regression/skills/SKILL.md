---
name: ml_regression
description: "This machine learning workflow performs regression analysis on tabular training and testing datasets using Scikit-learn pipelines, ensemble methods, and hyperparameter optimization. Use this skill when you need to predict continuous numerical outcomes from structured data and evaluate model accuracy through residual plots and performance curves."
homepage: https://workflowhub.eu/workflows/1633
---

# ml_regression

## Overview

This workflow performs regression analysis using machine learning techniques within the Galaxy framework. It is designed to handle supervised learning tasks by processing training datasets, test datasets, and their corresponding labels. The workflow is aligned with [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards for statistics and machine learning.

The pipeline utilizes several Scikit-learn based tools to build, optimize, and evaluate models. It includes steps for constructing machine learning pipelines, performing hyperparameter searches, and implementing various algorithms such as generalized linear models and ensemble methods. This structure allows users to compare different modeling approaches to identify the most effective regression strategy for their data.

To assess model performance, the workflow generates comprehensive visualizations using Plotly. These include actual vs. predicted curves and residual plots, which are essential for evaluating the accuracy and error distribution of the trained models. This workflow is released under the [MIT license](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | train_rows | data_input |  |
| 1 | test_rows_labels | data_input |  |
| 2 | test_rows | data_input |  |


Ensure your input files are formatted as tabular or CSV data, with features and target variables properly cleaned and preprocessed for regression analysis. This workflow requires individual datasets for training rows, test rows, and test labels rather than data collections, so ensure each file is uploaded separately to your Galaxy history. Refer to the README.md for comprehensive details on column selection and specific data preparation requirements. You can use `planemo workflow_job_init` to create a `job.yml` file for streamlined execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Pipeline Builder | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_build_pipeline/sklearn_build_pipeline/1.0.11.0 |  |
| 4 | Generalized linear models | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_generalized_linear/sklearn_generalized_linear/1.0.11.0 |  |
| 5 | Ensemble methods | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_ensemble/sklearn_ensemble/1.0.11.0 |  |
| 6 | Remove beginning | Remove beginning1 |  |
| 7 | Hyperparameter Search | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_searchcv/sklearn_searchcv/1.0.11.0 |  |
| 8 | Generalized linear models | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_generalized_linear/sklearn_generalized_linear/1.0.11.0 |  |
| 9 | Ensemble methods | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_ensemble/sklearn_ensemble/1.0.11.0 |  |
| 10 | Ensemble methods | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_ensemble/sklearn_ensemble/1.0.11.0 |  |
| 11 | Plot actual vs predicted curves and residual plots | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_regression_performance_plots/plotly_regression_performance_plots/0.1 |  |
| 12 | Plot actual vs predicted curves and residual plots | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_regression_performance_plots/plotly_regression_performance_plots/0.1 |  |
| 13 | Plot actual vs predicted curves and residual plots | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_regression_performance_plots/plotly_regression_performance_plots/0.1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run ml-regression.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run ml-regression.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run ml-regression.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init ml-regression.ga -o job.yml`
- Lint: `planemo workflow_lint ml-regression.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `ml-regression.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
