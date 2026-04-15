---
name: clonal_population-imported-from-uploaded-file
description: This workflow extracts and formats data from cBioPortal patient mutation tables and copy number files to perform clonal population analysis using PyClone-vi. Use this skill when you need to characterize the subclonal architecture of tumor samples and generate cellular prevalence visualizations for integration into cBioPortal timelines.
homepage: https://eosc4cancer.eu
metadata:
  docker_image: "N/A"
---

# clonal_population-imported-from-uploaded-file

## Overview

This Galaxy workflow automates the analysis of clonal populations using data structures derived from the TracerX study. It processes patient mutation tables and copy number (CN) data, specifically formatted for cBioPortal, to identify and characterize subclonal structures within a given case.

The pipeline begins with data extraction and formatting using tools like [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2), Join, and Filter. These steps prepare the raw mutation and CN data for [PyClone-vi](https://github.com/Roth-Lab/pyclone-vi), which performs the core clonal population estimation and calculates cellular prevalence across multiple samples.

Following the analysis, the workflow generates visualizations of cluster prevalence and formats the results for seamless integration back into cBioPortal. The final outputs include data and metadata files required for cBioPortal timelines and image resources, facilitating the clinical interpretation of evolutionary dynamics. This workflow is released under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | raw_patient_mutation_table | data_input | Raw table from cBioPortal patient mutation |
| 1 | all_CN | data_input | Missing CN data |
| 2 | study_id | parameter_input | cBioPortal Study ID |
| 3 | case_id | parameter_input | cBioPortal patient ID |


Ensure the `raw_patient_mutation_table` and `all_CN` inputs are provided as tabular files with consistent sample identifiers to facilitate the internal join and filtering operations. While the workflow is designed for individual datasets, you can leverage dataset collections to run the analysis across multiple patient cases simultaneously. Consult the `README.md` for comprehensive details on the specific column headers and data schemas required for successful PyClone-vi execution. For automated testing or batch execution, you may use `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 5 | Merge Columns | mergeCols1 | Merge mutation and event name |
| 6 | Join two Datasets | join1 | Join mutation with copy Number data |
| 7 | Cut | Cut1 | From the merge mutation CN table, select only PyClone-VI input |
| 8 | Filter | Filter1 |  |
| 9 | pyclone_vi | pyclone_vi | Run PyClone with data |
| 10 | Cluster Prevalence Over Samples | plot_cellular_prevalence | Make clonal evolution graph from PyClone-Vi output |
| 11 | Load PyClone-VI output to cBioPortal Timeline | export_cbioportal_timeline |  |
| 12 | Link image to cBioPortal resource | export_cbioportal_image | Add a link to the PyClone-VI plot to the cBioportal database |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 11 | data_file | data_file |
| 11 | meta_file | meta_file |
| 12 | data_patient_file | data_patient_file |
| 12 | meta_definition_file | meta_definition_file |
| 12 | data_definition_file | data_definition_file |
| 12 | meta_patient_file | meta_patient_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-clonal_population.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-clonal_population.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-clonal_population.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-clonal_population.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-clonal_population.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-clonal_population.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)