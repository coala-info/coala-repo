---
name: intro_to_cnn_v10110
description: This Galaxy workflow processes training and testing datasets to build, train, and evaluate a convolutional neural network using Keras model configuration and visualization tools. Use this skill when you need to perform image classification or pattern recognition tasks by training a deep learning model on labeled numerical data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# intro_to_cnn_v10110

## Overview

This workflow provides an introductory pipeline for building and training Convolutional Neural Networks (CNNs) within the Galaxy framework. It is designed to handle standard machine learning datasets, requiring four primary inputs: training features (`X_train`), training labels (`y_train`), test features (`X_test`), and test labels (`y_test`).

The process begins by defining a deep learning architecture using [keras_model_config](https://toolshed.g2.bx.psu.edu/repos/bgruening/keras_model_config/keras_model_config/1.0.10.0) and converting labels into a categorical format. A model is then constructed via the [keras_model_builder](https://toolshed.g2.bx.psu.edu/repos/bgruening/keras_model_builder/keras_model_builder/1.0.10.0) before undergoing training and evaluation using the [keras_train_and_eval](https://toolshed.g2.bx.psu.edu/repos/bgruening/keras_train_and_eval/keras_train_and_eval/1.0.11.0) tool.

Once the model is trained, the workflow generates predictions on the test set to assess real-world performance. The final stage utilizes the [ml_visualization_ex](https://toolshed.g2.bx.psu.edu/repos/bgruening/ml_visualization_ex/ml_visualization_ex/1.0.11.0) tool to produce visual representations of the results, such as accuracy and loss curves. This resource is associated with the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | X_test | data_input |  |
| 1 | X_train | data_input |  |
| 2 | y_test | data_input |  |
| 3 | y_train | data_input |  |


Ensure that the input training and testing datasets are formatted as tabular or array-based files compatible with Keras and Scikit-learn tool requirements. These inputs should be uploaded as individual datasets rather than collections to match the workflow's expected ports for features and labels. For streamlined execution, you can use `planemo workflow_job_init` to generate a `job.yml` file for mapping these inputs. Detailed instructions on data normalization and specific column requirements are provided in the README.md.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Create a deep learning model architecture | toolshed.g2.bx.psu.edu/repos/bgruening/keras_model_config/keras_model_config/1.0.10.0 |  |
| 5 | To categorical | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_to_categorical/sklearn_to_categorical/1.0.10.0 |  |
| 6 | Create deep learning model | toolshed.g2.bx.psu.edu/repos/bgruening/keras_model_builder/keras_model_builder/1.0.10.0 |  |
| 7 | Deep learning training and evaluation | toolshed.g2.bx.psu.edu/repos/bgruening/keras_train_and_eval/keras_train_and_eval/1.0.11.0 |  |
| 8 | Model Prediction | toolshed.g2.bx.psu.edu/repos/bgruening/model_prediction/model_prediction/1.0.11.0 |  |
| 9 | Machine Learning Visualization Extension | toolshed.g2.bx.psu.edu/repos/bgruening/ml_visualization_ex/ml_visualization_ex/1.0.11.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run intro-to-cnn-v1-0-11-0.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run intro-to-cnn-v1-0-11-0.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run intro-to-cnn-v1-0-11-0.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init intro-to-cnn-v1-0-11-0.ga -o job.yml`
- Lint: `planemo workflow_lint intro-to-cnn-v1-0-11-0.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `intro-to-cnn-v1-0-11-0.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)