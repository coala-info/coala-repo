---
name: intro_to_deep_learning
description: This deep learning workflow processes training and testing datasets to build, train, and evaluate neural network models using Keras-based configuration and visualization tools. Use this skill when you need to implement a supervised machine learning pipeline to identify patterns in structured data or predict outcomes based on historical training sets.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# intro_to_deep_learning

## Overview

This workflow provides a foundational introduction to deep learning within the Galaxy environment, designed to guide users through the end-to-end process of supervised learning. It begins by taking standard machine learning inputs, including training and testing datasets for both features (`X`) and labels (`y`), to establish a clear pipeline for model development.

The core of the process involves configuring and building a neural network architecture using Keras-based tools. Once the model structure is defined, the workflow proceeds to the training and evaluation phase, where the model learns from the training data and its performance is validated against the test set to ensure accuracy and generalizability.

In the final stages, the workflow generates predictions and utilizes specialized visualization tools to interpret the model's results. This comprehensive approach, often associated with [GTN](https://training.galaxyproject.org/) training materials, serves as an essential resource for those exploring statistics and machine learning (ML) applications in a reproducible manner.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | X_test | data_input |  |
| 1 | X_train | data_input |  |
| 2 | y_test | data_input |  |
| 3 | y_train | data_input |  |


Ensure your training and testing data are formatted as tabular or CSV files, typically containing numerical features and labels ready for tensor conversion. While these inputs are provided as individual datasets, you can use dataset collections to manage multiple experimental runs more efficiently. Refer to the `README.md` for specific details on data normalization and feature scaling requirements essential for model convergence. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Create a deep learning model architecture | toolshed.g2.bx.psu.edu/repos/bgruening/keras_model_config/keras_model_config/0.5.0 |  |
| 5 | Create deep learning model | toolshed.g2.bx.psu.edu/repos/bgruening/keras_model_builder/keras_model_builder/0.5.0 |  |
| 6 | Deep learning training and evaluation | toolshed.g2.bx.psu.edu/repos/bgruening/keras_train_and_eval/keras_train_and_eval/1.0.8.2 |  |
| 7 | Model Prediction | toolshed.g2.bx.psu.edu/repos/bgruening/model_prediction/model_prediction/1.0.8.2 |  |
| 8 | Machine Learning Visualization Extension | toolshed.g2.bx.psu.edu/repos/bgruening/ml_visualization_ex/ml_visualization_ex/1.0.8.2 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run intro-to-deep-learning.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run intro-to-deep-learning.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run intro-to-deep-learning.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init intro-to-deep-learning.ga -o job.yml`
- Lint: `planemo workflow_lint intro-to-deep-learning.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `intro-to-deep-learning.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)