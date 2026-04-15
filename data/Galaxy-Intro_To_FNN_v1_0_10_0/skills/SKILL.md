---
name: intro_to_fnn_v1_0_10_0
description: This workflow utilizes training and testing datasets to configure, build, and train a Feedforward Neural Network using Keras tools for regression analysis and performance visualization. Use this skill when you need to develop predictive models for continuous variables and evaluate their accuracy through residual plots and actual versus predicted curves.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# intro_to_fnn_v1_0_10_0

## Overview

This workflow provides a foundational pipeline for implementing Feedforward Neural Networks (FNN) using Keras within the Galaxy framework. It is designed for supervised learning tasks, specifically regression, and requires four primary datasets as input: training features (`X_train`), training labels (`y_train`), testing features (`X_test`), and testing labels (`y_test`).

The process begins by defining the deep learning model architecture and building the model structure through the `keras_model_config` and `keras_model_builder` tools. Once the architecture is established, the workflow executes the training and evaluation phase, where the model learns from the training data and its performance is validated.

Following the training phase, the workflow generates predictions on the test dataset. To facilitate a comprehensive analysis of the model's accuracy, it produces interactive visualizations using Plotly, including actual versus predicted curves and residual plots. These outputs allow users to assess the model's fit and identify potential biases in the regression results.

This resource is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for use in Statistics and Machine Learning (ML). It serves as a practical implementation of [GTN](https://training.galaxyproject.org/) training materials for deep learning.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | X_test | data_input |  |
| 1 | X_train | data_input |  |
| 2 | y_test | data_input |  |
| 3 | y_train | data_input |  |


Ensure your training and testing inputs are provided as tabular or CSV files, verifying that feature matrices and target labels are pre-processed and correctly aligned by row. While these inputs are typically uploaded as individual datasets, ensure that the dimensionality of the X and y files matches the requirements of the Keras model configuration. Refer to the README.md for comprehensive details on specific column indices and data normalization steps required for this Feedforward Neural Network. For streamlined execution, you can use `planemo workflow_job_init` to generate a `job.yml` file for your environment.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Create a deep learning model architecture | toolshed.g2.bx.psu.edu/repos/bgruening/keras_model_config/keras_model_config/1.0.10.0 |  |
| 5 | Create deep learning model | toolshed.g2.bx.psu.edu/repos/bgruening/keras_model_builder/keras_model_builder/1.0.10.0 |  |
| 6 | Deep learning training and evaluation | toolshed.g2.bx.psu.edu/repos/bgruening/keras_train_and_eval/keras_train_and_eval/1.0.10.0 |  |
| 7 | Model Prediction | toolshed.g2.bx.psu.edu/repos/bgruening/model_prediction/model_prediction/1.0.10.0 |  |
| 8 | Plot actual vs predicted curves and residual plots | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_regression_performance_plots/plotly_regression_performance_plots/0.1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run intro-to-fnn-v1-0-10-0.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run intro-to-fnn-v1-0-10-0.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run intro-to-fnn-v1-0-10-0.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init intro-to-fnn-v1-0-10-0.ga -o job.yml`
- Lint: `planemo workflow_lint intro-to-fnn-v1-0-10-0.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `intro-to-fnn-v1-0-10-0.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)