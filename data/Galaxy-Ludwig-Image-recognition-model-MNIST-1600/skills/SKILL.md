---
name: ludwig-image-recognition-model-mnist
description: This Galaxy workflow utilizes the PyCaret Model Comparison tool to evaluate Chowell training and test response datasets for the generation of a LORIS LLR6 predictive model. Use this skill when you need to identify the most accurate machine learning model for predicting patient response to immunotherapy based on clinical and genomic data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# ludwig-image-recognition-model-mnist

## Overview

This Galaxy workflow is designed to generate a LORIS LLR6 model by automating the evaluation and selection of machine learning algorithms. While the title references MNIST image recognition, the workflow specifically processes tabular response data—`Chowell_Train_Response.tsv` and `Chowell_Test_Response.tsv`—to identify optimal predictive patterns for classification tasks.

The core of the process utilizes the **PyCaret Model Comparison** tool, which benchmarks various machine learning architectures to determine the highest-performing model for the provided dataset. This approach leverages the [Galaxy](https://usegalaxy.org/) framework to ensure reproducibility and streamline the model selection process, often used in the context of [GTN](https://training.galaxyproject.org/) training materials.

The workflow yields two primary outputs: the best-performing model file and a comprehensive comparison report. These assets facilitate the deployment of the LLR6 model and provide detailed transparency into the performance metrics of all evaluated candidates. The project is shared under an [AGPL-3.0-or-later](https://spdx.org/licenses/AGPL-3.0-or-later.html) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Chowell_Train_Response.tsv | data_input | Chowell train cohort - 964 samples |
| 1 | Chowell_Test_Response.tsv | data_input | Chowell test cohort - 515 samples |


Ensure your training and testing response data are formatted as TSV files to ensure compatibility with the PyCaret comparison tool. While these inputs are provided as individual datasets, you can organize larger batches into collections for more efficient processing. Refer to the README.md file for comprehensive details on column requirements and specific preprocessing steps. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | PyCaret Model Comparison | toolshed.g2.bx.psu.edu/repos/paulo_lyra_jr/pycaret_model_comparison/PyCaret_Model_Comparison/2024.3.3.2+0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | PyCaret Model Comparison best model on input dataset(s) | model |
| 2 | PyCaret Model Comparison Comparison result on input dataset(s) | comparison_result |


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