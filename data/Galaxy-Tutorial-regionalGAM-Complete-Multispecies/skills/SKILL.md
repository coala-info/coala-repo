---
name: tutorial-regionalgam-complete-multispecies
description: This ecology workflow processes multispecies CSV datasets using regionalGAM flight-curve tools and data manipulation utilities to analyze population trends. Use this skill when you need to estimate seasonal abundance indices and flight curves for multiple species across different regions to monitor biodiversity trends.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# tutorial-regionalgam-complete-multispecies

## Overview

This workflow implements the Regional Generalized Additive Model (GAM) approach to analyze multispecies ecological monitoring data. It is designed to process butterfly count data or similar seasonal observations to estimate abundance indices and phenology. The pipeline is based on resources provided by the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) and utilizes the `regionalgam` tool suite.

The process begins by importing a multispecies dataset from [Zenodo](https://zenodo.org/record/1324204), which is then converted from CSV to tabular format. The workflow performs extensive data cleaning and preparation, including regex-based find-and-replace operations, filtering, and column manipulation to ensure the input meets the requirements for statistical modeling.

At the core of the analysis, the workflow executes the `flight-curve` tool to model the seasonal activity patterns of the target species. These models account for variation in sampling effort and timing across different sites. The final stages involve merging columns and reformatting the results into a consolidated output, allowing researchers to compare population trends across multiple species within a region.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | https://zenodo.org/record/1324204/files/Dataset%20multispecies%20Regional%20GAM.csv?download=1 | data_input |  |


Ensure your input data is uploaded in CSV format to match the requirements of the initial conversion and filtering steps. While this workflow is configured for a single multispecies dataset, you may consider using dataset collections if you plan to scale the analysis across multiple distinct survey regions. Detailed information regarding the specific column headers and data structures required for the flight curve tools can be found in the accompanying README.md. For automated execution, you can use `planemo workflow_job_init` to create a `job.yml` file for managing these inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | CSV to Tabular | toolshed.g2.bx.psu.edu/repos/mnhn65mo/csv_to_tabular/csv2tab_R/0.1 |  |
| 2 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.0 |  |
| 3 | Count | Count1 |  |
| 4 | Filter | Filter1 |  |
| 5 | Filter | Filter1 |  |
| 6 | Tabular to CSV | toolshed.g2.bx.psu.edu/repos/mnhn65mo/tabular_to_csv/tab2csv_R/0.1 |  |
| 7 | Tabular to CSV | toolshed.g2.bx.psu.edu/repos/mnhn65mo/tabular_to_csv/tab2csv_R/0.1 |  |
| 8 | Flight curve | toolshed.g2.bx.psu.edu/repos/mnhn65mo/regionalgam/flight-curve/1.0.0 |  |
| 9 | Flight curve | toolshed.g2.bx.psu.edu/repos/mnhn65mo/regionalgam/flight-curve/1.0.0 |  |
| 10 | Count | Count1 |  |
| 11 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.0 |  |
| 12 | Count | Count1 |  |
| 13 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.0 |  |
| 14 | Merge Columns | mergeCols1 |  |
| 15 | Merge Columns | mergeCols1 |  |
| 16 | Remove beginning | Remove beginning1 |  |
| 17 | Remove beginning | Remove beginning1 |  |
| 18 | Paste | Paste1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-tutorial-regionalgam-complete-multispecies.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-tutorial-regionalgam-complete-multispecies.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-tutorial-regionalgam-complete-multispecies.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-tutorial-regionalgam-complete-multispecies.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-tutorial-regionalgam-complete-multispecies.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-tutorial-regionalgam-complete-multispecies.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)