---
name: fruit_360
description: This workflow performs image classification on the Fruit 360 dataset by processing tabular training and testing data through Keras deep learning architecture, training, and visualization tools. Use this skill when you need to automate the identification of fruit varieties using neural networks and evaluate the performance of image recognition models.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# fruit_360

## Overview

This workflow performs image classification using the Fruit 360 dataset, specifically designed for deep learning applications within the Galaxy environment. It processes tabular representations of image data, utilizing training and testing sets for both features (X) and labels (y). The pipeline is a practical implementation of [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) methodologies for statistics and machine learning.

The process begins by defining a neural network architecture using the [Keras model configuration](https://toolshed.g2.bx.psu.edu/repos/bgruening/keras_model_config/keras_model_config/0.5.0) and builder tools. Data preprocessing steps include refining the input datasets with text processing tools and converting labels into categorical formats via [sklearn_to_categorical](https://toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_to_categorical/sklearn_to_categorical/1.0.8.3) to ensure compatibility with the deep learning model.

Once the model is constructed, the workflow executes training and evaluation to generate model weights and performance results. It concludes by performing predictions on the test data and generating visual analytics through the [Machine Learning Visualization Extension](https://toolshed.g2.bx.psu.edu/repos/bgruening/ml_visualization_ex/ml_visualization_ex/1.0.8.3), providing a comprehensive overview of the model's accuracy and classification capabilities.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | test_y_10.tsv | data_input |  |
| 1 | train_y_10.tsv | data_input |  |
| 2 | train_X_10.tsv | data_input |  |
| 3 | test_X_10.tsv | data_input |  |


Ensure all input files are uploaded in tabular (TSV) format, representing the feature matrices and label vectors for both training and testing partitions. While these inputs are handled as individual datasets, ensure the column structures match the requirements of the Keras training and evaluation tools. Refer to the README.md for comprehensive details on data dimensionality and the preprocessing steps used to convert raw images into these tabular formats. You may use planemo workflow_job_init to create a job.yml for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Create a deep learning model architecture | toolshed.g2.bx.psu.edu/repos/bgruening/keras_model_config/keras_model_config/0.5.0 |  |
| 5 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 6 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 7 | Create deep learning model | toolshed.g2.bx.psu.edu/repos/bgruening/keras_model_builder/keras_model_builder/0.5.0 |  |
| 8 | To categorical | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_to_categorical/sklearn_to_categorical/1.0.8.3 |  |
| 9 | Deep learning training and evaluation | toolshed.g2.bx.psu.edu/repos/bgruening/keras_train_and_eval/keras_train_and_eval/1.0.8.3 |  |
| 10 | Model Prediction | toolshed.g2.bx.psu.edu/repos/bgruening/model_prediction/model_prediction/1.0.8.3 |  |
| 11 | Machine Learning Visualization Extension | toolshed.g2.bx.psu.edu/repos/bgruening/ml_visualization_ex/ml_visualization_ex/1.0.8.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | outfile | outfile |
| 5 | output | output |
| 6 | output | output |
| 7 | outfile | outfile |
| 8 | outfile | outfile |
| 9 | outfile_result | outfile_result |
| 9 | outfile_object | outfile_object |
| 9 | outfile_weights | outfile_weights |
| 10 | outfile_predict | outfile_predict |
| 11 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run fruit-360.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run fruit-360.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run fruit-360.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init fruit-360.ga -o job.yml`
- Lint: `planemo workflow_lint fruit-360.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `fruit-360.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)