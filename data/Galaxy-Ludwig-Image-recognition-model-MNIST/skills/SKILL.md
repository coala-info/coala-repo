---
name: ludwig-image-recognition-model-mnist
description: This Galaxy workflow utilizes the Ludwig Experiment tool to train and evaluate a deep learning image classifier using a configuration file, a CSV dataset, and a ZIP archive of MNIST images. Use this skill when you need to perform automated machine learning for handwritten digit recognition or benchmark image classification models using the MNIST dataset.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# ludwig-image-recognition-model-mnist

## Overview

This workflow implements a deep learning image classifier using the [Ludwig](https://ludwig.ai/latest/) framework within Galaxy. It is specifically designed to process the classic MNIST dataset of handwritten digits, providing a streamlined pipeline for training and evaluating machine learning models without requiring extensive coding.

The process requires three primary inputs: a `config.yaml` file defining the model architecture and training parameters, a `mnist_dataset.csv` file for data mapping, and a `mnist_images.zip` archive containing the raw image data. These inputs are processed by the **Ludwig Experiment** tool, which automates the underlying training, validation, and testing phases.

Upon completion, the workflow generates three key outputs: a detailed experiment report, a CSV file containing the model's predictions, and the final trained model. This workflow is particularly useful for those following [GTN](https://training.galaxyproject.org/) tutorials or looking to implement automated image recognition tasks under the AGPL-3.0-or-later license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | config.yaml | data_input | The config.yaml file is crucial as it defines the entire structure of your machine learning experiment. This configuration file tells Ludwig how to process your data, what model to use, how to train it, and what outputs to generate. |
| 1 | mnist_dataset.csv | data_input | mnist_dataset.csv file is created and contains three columns: image_path, label, and, split. |
| 2 | mnist_images.zip | data_input | PNG files containing the handwritten numbers |


Ensure the `config.yaml` correctly maps the model architecture to the columns in `mnist_dataset.csv`, while the `mnist_images.zip` must be structured so the tool can resolve the relative image paths defined in your metadata. For large-scale training, consider organizing your inputs into dataset collections to streamline data management within the Galaxy history. Detailed instructions on specific parameter settings and data preprocessing are available in the `README.md` file. You may also use `planemo workflow_job_init` to create a `job.yml` for reproducible command-line execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Ludwig Experiment | toolshed.g2.bx.psu.edu/repos/paulo_lyra_jr/ludwig_applications/ludwig_experiment/2024.0.10.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | output_report | output_report |
| 3 | output_pred_csv | output_pred_csv |
| 3 | output_model | output_model |


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