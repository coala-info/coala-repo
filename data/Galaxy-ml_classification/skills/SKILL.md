---
name: ml_classification
description: "This machine learning workflow processes CSV datasets to perform classification using Scikit-learn pipelines, hyperparameter searching, and multiple algorithms including SVMs, ensemble methods, and nearest neighbors. Use this skill when you need to develop predictive models for categorical outcomes in fields like cheminformatics or statistics and require comprehensive performance metrics like ROC curves and confusion matrices."
homepage: https://workflowhub.eu/workflows/1588
---

# ml_classification

## Overview

This Galaxy workflow provides a standardized pipeline for performing machine learning classification, specifically tailored for statistical analysis and cheminformatics. It processes three primary inputs: training data, test data, and test labels in CSV format. The workflow is designed to streamline the transition from raw data to evaluated predictive models within the Galaxy environment.

The pipeline utilizes a suite of Scikit-learn based tools to build and optimize various classification models. It supports multiple algorithms, including Generalized Linear Models, Nearest Neighbors, Support Vector Machines (SVMs), and Ensemble methods. A dedicated Hyperparameter Search step is included to fine-tune model parameters, ensuring the selection of the most robust configuration for the given dataset.

To evaluate model performance, the workflow generates a series of comprehensive visualizations using Plotly. These include confusion matrices, precision-recall curves, and ROC/AUC curves. These outputs allow researchers to compare the efficacy of different algorithms and validate the accuracy of their classification results.

Developed under the [MIT license](https://opensource.org/licenses/MIT), this workflow follows [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) best practices. It serves as a reproducible framework for users looking to implement machine learning classification tasks without requiring extensive manual coding.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | train_rows.csv | data_input |  |
| 1 | test_rows_labels.csv | data_input |  |
| 2 | test_rows.csv | data_input |  |


Ensure all inputs are formatted as tabular CSV files with consistent column headers to prevent errors during the Scikit-learn pipeline execution. While this workflow uses individual datasets for training and testing, verify that the target labels in your test set match the feature structure of the training data. Refer to the README.md for comprehensive details on feature engineering and hyperparameter configurations. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Pipeline Builder | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_build_pipeline/sklearn_build_pipeline/1.0.11.0 |  |
| 4 | Generalized linear models | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_generalized_linear/sklearn_generalized_linear/1.0.11.0 |  |
| 5 | Nearest Neighbors Classification | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_nn_classifier/sklearn_nn_classifier/1.0.11.0 |  |
| 6 | Support vector machines (SVMs) | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_svm_classifier/sklearn_svm_classifier/1.0.11.0 |  |
| 7 | Ensemble methods | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_ensemble/sklearn_ensemble/1.0.11.0 |  |
| 8 | Remove beginning | Remove beginning1 |  |
| 9 | Hyperparameter Search | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_searchcv/sklearn_searchcv/1.0.11.0 |  |
| 10 | Generalized linear models | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_generalized_linear/sklearn_generalized_linear/1.0.11.0 |  |
| 11 | Nearest Neighbors Classification | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_nn_classifier/sklearn_nn_classifier/1.0.11.0 |  |
| 12 | Support vector machines (SVMs) | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_svm_classifier/sklearn_svm_classifier/1.0.11.0 |  |
| 13 | Ensemble methods | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_ensemble/sklearn_ensemble/1.0.11.0 |  |
| 14 | Ensemble methods | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_ensemble/sklearn_ensemble/1.0.11.0 |  |
| 15 | Plot confusion matrix, precision, recall and ROC and AUC curves | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_ml_performance_plots/plotly_ml_performance_plots/0.4 |  |
| 16 | Plot confusion matrix, precision, recall and ROC and AUC curves | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_ml_performance_plots/plotly_ml_performance_plots/0.4 |  |
| 17 | Plot confusion matrix, precision, recall and ROC and AUC curves | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_ml_performance_plots/plotly_ml_performance_plots/0.4 |  |
| 18 | Plot confusion matrix, precision, recall and ROC and AUC curves | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_ml_performance_plots/plotly_ml_performance_plots/0.4 |  |
| 19 | Plot confusion matrix, precision, recall and ROC and AUC curves | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_ml_performance_plots/plotly_ml_performance_plots/0.4 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run ml-classification.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run ml-classification.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run ml-classification.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init ml-classification.ga -o job.yml`
- Lint: `planemo workflow_lint ml-classification.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `ml-classification.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
