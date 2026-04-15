---
name: age-prediction-rna-seq
description: This Galaxy workflow performs age prediction from RNA-Seq input datasets using Scikit-learn pipeline building and hyperparameter optimization tools. Use this skill when you need to build and optimize machine learning models to estimate biological age or identify transcriptomic markers of aging from gene expression profiles.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# age-prediction-rna-seq

## Overview

This workflow provides a machine learning framework for predicting biological age from RNA-Seq expression data. It is designed to process an input dataset through a structured scikit-learn pipeline, enabling automated feature processing and model training within the Galaxy environment.

The analysis begins with the **Pipeline Builder**, which constructs a sequence of estimators and transformers. This is followed by a **Hyperparameter Search** step that optimizes the model's performance by exploring various parameter combinations to find the most accurate predictive configuration for the provided transcriptomic data.

To facilitate the interpretation of results, the workflow generates a **Parallel Coordinates Plot** using Plotly. This visualization allows researchers to examine the relationships between different hyperparameters and model outcomes, providing clear insights into the optimization process. This statistical approach follows [GTN](https://training.galaxyproject.org/) best practices for reproducible machine learning in bioinformatics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 1 | Input dataset | data_input |  |


Ensure your input is a tabular file (TSV or CSV) containing normalized RNA-Seq expression counts with age as a target variable. While this workflow processes a single dataset, you can use dataset collections if performing cross-validation across multiple cohorts. Refer to the README.md for specific column formatting requirements and pre-processing steps necessary for the scikit-learn tools. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution and parameter testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Pipeline Builder | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_build_pipeline/sklearn_build_pipeline/1.0.8.1 |  |
| 2 | Hyperparameter Search | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_searchcv/sklearn_searchcv/1.0.8.1 |  |
| 3 | Parallel Coordinates Plot | toolshed.g2.bx.psu.edu/repos/bgruening/plotly_parallel_coordinates_plot/plotly_parallel_coordinates_plot/0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | outfile_params | outfile_params |
| 0 | outfile | outfile |
| 2 | outfile_result | outfile_result |
| 3 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run age-prediction-rna.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run age-prediction-rna.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run age-prediction-rna.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init age-prediction-rna.ga -o job.yml`
- Lint: `planemo workflow_lint age-prediction-rna.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `age-prediction-rna.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)