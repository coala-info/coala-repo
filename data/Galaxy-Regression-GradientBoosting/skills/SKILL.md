---
name: regression-gradientboosting
description: This Galaxy workflow performs gradient boosting regression on training and testing datasets using Scikit-learn ensemble tools and generates performance visualizations with Plotly. Use this skill when you need to build a predictive model for continuous numerical outcomes and evaluate its accuracy through residual plots and actual versus predicted comparisons.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# regression-gradientboosting

## Overview

This workflow implements a regression analysis using the Gradient Boosting ensemble method within the Galaxy platform. It is designed for machine learning tasks, specifically focusing on predicting continuous variables—such as body fat percentages—by training a model on labeled datasets and validating its performance against test data.

The pipeline utilizes [Scikit-learn ensemble methods](https://toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_ensemble/sklearn_ensemble/1.0.8.1) to fit a regression model to the training input. It processes three primary data components: a training set, a test set, and the corresponding test labels, ensuring a standard supervised learning approach for model evaluation.

Upon completion, the workflow generates a fitted model and several diagnostic visualizations using [Plotly](https://toolshed.g2.bx.psu.edu/repos/bgruening/plotly_regression_performance_plots/plotly_regression_performance_plots/0.1). These outputs include actual vs. predicted curves, residual plots, and scatter plots, which are essential for assessing the accuracy of the Gradient Boosting regressor and identifying potential error patterns.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | body_fat_test | data_input |  |
| 1 | body_fat_train | data_input |  |
| 2 | body_fat_test_labels | data_input |  |


Ensure your training and testing data are provided in tabular format (CSV or TSV) with numerical features properly formatted for the scikit-learn ensemble tools. While this workflow uses individual datasets for the body fat inputs, you may consider using dataset collections if scaling to multiple regression tasks. Refer to the `README.md` for comprehensive details on feature selection and specific hyperparameter configurations. You can also streamline the execution setup by using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Ensemble methods | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_ensemble/sklearn_ensemble/1.0.8.1 |  |
| 4 | Ensemble methods | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_ensemble/sklearn_ensemble/1.0.8.1 |  |
| 5 | Plot actual vs predicted curves and residual plots | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_regression_performance_plots/plotly_regression_performance_plots/0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | outfile_fit | outfile_fit |
| 5 | output_scatter_plot | output_scatter_plot |
| 5 | output_actual_vs_pred | output_actual_vs_pred |
| 5 | output_residual_plot | output_residual_plot |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run regression-gradientboosting.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run regression-gradientboosting.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run regression-gradientboosting.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init regression-gradientboosting.ga -o job.yml`
- Lint: `planemo workflow_lint regression-gradientboosting.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `regression-gradientboosting.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)