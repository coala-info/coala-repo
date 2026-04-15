---
name: machine-learning
description: This Galaxy workflow utilizes training and testing datasets to perform supervised classification using Support Vector Machine (SVM) algorithms. Use this skill when you need to develop predictive models for medical diagnostics or categorize biological samples based on multidimensional feature sets.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# machine-learning

## Overview

This workflow provides a foundational introduction to the basics of machine learning within the Galaxy ecosystem. It is designed to demonstrate supervised learning techniques using the [Scikit-learn](https://scikit-learn.org/) library, specifically focusing on classification tasks. The pipeline is often utilized in conjunction with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) materials to teach statistical modeling and data analysis.

The process begins by ingesting two primary datasets: a training set (`breast-w_train`) and a test set (`breast-w_test`). The workflow utilizes the [Support Vector Machines (SVMs)](https://toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_svm_classifier/sklearn_svm_classifier/1.0.8.1) tool to construct a predictive model. By applying the SVM algorithm, the system learns to identify patterns within the training data to classify subsequent inputs.

The final output of the workflow is a prediction file (`outfile_predict`) containing the classification results for the test dataset. This automated pipeline serves as a template for reproducible research in machine learning, allowing users to swap datasets or tune SVM parameters to explore different statistical outcomes.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | breast-w_train | data_input |  |
| 1 | breast-w_test | data_input |  |


Ensure your training and testing inputs are formatted as tabular files (CSV or TSV) with matching feature columns to ensure compatibility with the Scikit-learn tools. While individual datasets are used here, consider organizing larger batches into collections to simplify multi-model evaluations. Consult the `README.md` for specific instructions on data normalization and label encoding necessary for optimal SVM performance. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Support vector machines (SVMs) | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_svm_classifier/sklearn_svm_classifier/1.0.8.1 |  |
| 3 | Support vector machines (SVMs) | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_svm_classifier/sklearn_svm_classifier/1.0.8.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | outfile_predict | outfile_predict |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run machine-learning.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run machine-learning.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run machine-learning.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init machine-learning.ga -o job.yml`
- Lint: `planemo workflow_lint machine-learning.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `machine-learning.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)