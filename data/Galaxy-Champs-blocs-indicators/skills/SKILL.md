---
name: champs-blocs-indicators
description: This ecological workflow processes field survey CSV data using IVR, QECB, and Ecology tools to compute specific environmental indicators and generate associated plots. Use this skill when you need to evaluate biodiversity or habitat quality indicators from Champs blocs field observations to assess ecological status.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# champs-blocs-indicators

## Overview

This Galaxy workflow is designed for ecological monitoring, specifically to compute key indicators for "Champs blocs" (block fields). It automates the processing of field data to evaluate environmental metrics, supporting researchers in the [Ecology](https://usegalaxy.eu/training-material/topics/ecology/) domain by streamlining complex data transformations into standardized outputs.

The pipeline processes six primary CSV inputs, including field observation sheets (`ficheterrain`) and specific datasets for IVR and QECB validation. The workflow executes three core analytical modules: the Index of Vegetation Regeneration (IVR), the Quality of Ecological Characterization of Blocks (QECB), and a general Ecology assessment. These steps transform raw field measurements into structured ecological indices.

Upon completion, the workflow generates a comprehensive suite of outputs for each module, including visual plots, RDS files for downstream R analysis, and specific tabular data. This structured approach ensures that ecological indicators are reproducible and ready for further statistical interpretation or reporting. Detailed documentation on the data structure can be found in the [README.md](README.md) located in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | champbloc_ivr_val.csv | data_input |  |
| 1 | champbloc_ivr.csv | data_input |  |
| 2 | ficheterrain_val.csv | data_input |  |
| 3 | ficheterrain.csv | data_input |  |
| 4 | champbloc_qecb_val.csv | data_input |  |
| 5 | champbloc_qecb.csv | data_input |  |


Ensure all six input files are uploaded in CSV format, paying close attention to the distinction between validation and field data files to ensure the IVR and QECB tools process the indicators correctly. While these are handled as individual datasets, grouping them within a single history or using tags will help manage the various outputs like RDS files and plots. Please consult the README.md for specific requirements regarding column headers and data formatting for each input. For automated execution and testing, you may use planemo workflow_job_init to create a job.yml file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | IVR | cb_ivr |  |
| 7 | QECB | cb_qecb |  |
| 8 | Ecology | cb_eco |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | plots | plots |
| 6 | output_rds | output_rds |
| 6 | output_ivr | output_ivr |
| 7 | plots | plots |
| 7 | output_rds | output_rds |
| 7 | output_qecb | output_qecb |
| 8 | plots | plots |
| 8 | output_rds | output_rds |
| 8 | output_eco | output_eco |


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