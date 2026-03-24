---
name: peptideml
description: "This proteomics workflow processes anti-cancer and non-anti-cancer peptide sequences using PDAUG tools to extract sequence descriptors and train multiple machine learning models. Use this skill when you need to build and evaluate predictive models to distinguish therapeutic anti-cancer peptides from non-functional sequences based on their physicochemical properties."
homepage: https://workflowhub.eu/workflows/1454
---

# PeptideML

## Overview

The PeptideML workflow is designed for the machine learning-based modeling of Anti-cancer Peptides (ACPs). It utilizes the [PDAUG](https://toolshed.g2.bx.psu.edu/view/jay/) (Peptide Data Analysis Using Galaxy) toolset to automate the classification and analysis of therapeutic peptides. The pipeline begins by processing two primary input datasets: known ACP sequences and non-ACP sequences.

The workflow first extracts biochemical features using sequence property-based descriptors for both datasets. It then assigns class labels to the data and merges them into a unified dataframe. This structured data serves as the foundation for training and evaluating multiple machine learning models in parallel, allowing for a comparative analysis of different algorithmic performances.

In the final stages, the workflow aggregates the results from the various [PDAUG ML Models](https://toolshed.g2.bx.psu.edu/view/jay/pdaug_ml_models/) and generates visual reports. These basic plots help researchers interpret model accuracy and performance metrics, facilitating the identification of the most effective predictive models for anticancer peptide discovery. This workflow is a valuable resource for proteomics research and is featured in [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ACPs | data_input |  |
| 1 | non-ACPs | data_input |  |


Ensure your input sequences for both ACPs and non-ACPs are provided in FASTA format to allow the PDAUG descriptor tools to correctly calculate sequence properties. These inputs should be uploaded as individual datasets rather than collections to facilitate the distinct class labeling required before the dataframes are merged for machine learning. Refer to the `README.md` for comprehensive details on specific descriptor configurations and model parameters. You may also use `planemo workflow_job_init` to create a `job.yml` file for streamlined execution and better reproducibility.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | PDAUG Sequence Property Based Descriptors | toolshed.g2.bx.psu.edu/repos/jay/pdaug_sequence_property_based_descriptors/pdaug_sequence_property_based_descriptors/0.1.0 |  |
| 3 | PDAUG Sequence Property Based Descriptors | toolshed.g2.bx.psu.edu/repos/jay/pdaug_sequence_property_based_descriptors/pdaug_sequence_property_based_descriptors/0.1.0 |  |
| 4 | PDAUG Add Class Label | toolshed.g2.bx.psu.edu/repos/jay/pdaug_addclasslabel/pdaug_addclasslabel/0.1.0 |  |
| 5 | PDAUG Add Class Label | toolshed.g2.bx.psu.edu/repos/jay/pdaug_addclasslabel/pdaug_addclasslabel/0.1.0 |  |
| 6 | PDAUG Merge Dataframes | toolshed.g2.bx.psu.edu/repos/jay/pdaug_merge_dataframes/pdaug_merge_dataframes/0.1.0 |  |
| 7 | PDAUG ML Models | toolshed.g2.bx.psu.edu/repos/jay/pdaug_ml_models/pdaug_ml_models/0.1.0 |  |
| 8 | PDAUG ML Models | toolshed.g2.bx.psu.edu/repos/jay/pdaug_ml_models/pdaug_ml_models/0.1.0 |  |
| 9 | PDAUG ML Models | toolshed.g2.bx.psu.edu/repos/jay/pdaug_ml_models/pdaug_ml_models/0.1.0 |  |
| 10 | PDAUG ML Models | toolshed.g2.bx.psu.edu/repos/jay/pdaug_ml_models/pdaug_ml_models/0.1.0 |  |
| 11 | PDAUG ML Models | toolshed.g2.bx.psu.edu/repos/jay/pdaug_ml_models/pdaug_ml_models/0.1.0 |  |
| 12 | PDAUG ML Models | toolshed.g2.bx.psu.edu/repos/jay/pdaug_ml_models/pdaug_ml_models/0.1.0 |  |
| 13 | PDAUG Merge Dataframes | toolshed.g2.bx.psu.edu/repos/jay/pdaug_merge_dataframes/pdaug_merge_dataframes/0.1.0 |  |
| 14 | PDAUG Basic Plots | toolshed.g2.bx.psu.edu/repos/jay/pdaug_basic_plots/pdaug_basic_plots/0.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | output1 | output1 |
| 4 | OutFile1 | OutFile1 |
| 6 | output1 | output1 |
| 7 | output1 | output1 |
| 7 | output2 | output2 |
| 13 | output1 | output1 |
| 14 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run peptideml.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run peptideml.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run peptideml.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init peptideml.ga -o job.yml`
- Lint: `planemo workflow_lint peptideml.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `peptideml.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
