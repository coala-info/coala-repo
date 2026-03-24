---
name: classification-lsvc
description: "This machine learning workflow utilizes Linear Support Vector Machines to classify tabular data from training and test sets while generating detailed performance plots. Use this skill when you need to develop a robust classification model for biological or clinical datasets and require visual validation of model sensitivity and specificity."
homepage: https://workflowhub.eu/workflows/1592
---

# Classification LSVC

## Overview

This Galaxy workflow performs supervised machine learning classification using Linear Support Vector Classification (LSVC). It is designed to process tabular datasets, specifically taking training data, target labels, and test data as inputs to build and validate a predictive model.

The pipeline utilizes [Scikit-learn SVM tools](https://toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_svm_classifier/sklearn_svm_classifier/1.0.8.1) to train the classifier. It follows standard machine learning practices by fitting the model on training data and subsequently applying it to test data to evaluate its generalization capabilities.

For model evaluation, the workflow generates comprehensive performance visualizations using [Plotly-based tools](https://toolshed.g2.bx.psu.edu/repos/bgruening/plotly_ml_performance_plots/plotly_ml_performance_plots/0.1). Key outputs include the fitted model file, ROC curves, confusion matrices, and precision-recall-F1 (PRF) metrics, providing a detailed assessment of the classifier's accuracy and error distribution.

This workflow is tagged for use in **ML**, **Statistics**, and **GTN** (Galaxy Training Network) contexts, making it a robust template for classification and regression tasks within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | breast-w_train | data_input |  |
| 1 | breast-w_targets | data_input |  |
| 2 | breast-w_test | data_input |  |


Ensure your training, target, and test inputs are formatted as tabular files (TSV or CSV) with consistent feature columns to avoid errors during the SVM fitting process. While this workflow uses individual datasets, you may consider using data collections if you plan to scale the analysis across multiple patient cohorts. Refer to the `README.md` for comprehensive details on the specific column indices and preprocessing requirements for the Linear Support Vector Classification model. You can also streamline your execution by using `planemo workflow_job_init` to generate a `job.yml` for automated parameter handling.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Support vector machines (SVMs) | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_svm_classifier/sklearn_svm_classifier/1.0.8.1 |  |
| 4 | Support vector machines (SVMs) | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_svm_classifier/sklearn_svm_classifier/1.0.8.1 |  |
| 5 | Plot confusion matrix, precision, recall and ROC and AUC curves | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_ml_performance_plots/plotly_ml_performance_plots/0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | outfile_fit | outfile_fit |
| 5 | output_roc | output_roc |
| 5 | output_confusion | output_confusion |
| 5 | output_prf | output_prf |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run classification-lsvc.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run classification-lsvc.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run classification-lsvc.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init classification-lsvc.ga -o job.yml`
- Lint: `planemo workflow_lint classification-lsvc.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `classification-lsvc.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
