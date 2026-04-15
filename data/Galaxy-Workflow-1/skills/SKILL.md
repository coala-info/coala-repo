---
name: unnamed-workflow
description: This workflow processes assembly plans and JSON parameters to perform sequence retrieval, manufacturability evaluation, and cloning simulation using Maystro and database integration tools. Use this skill when you need to validate the feasibility of synthetic DNA designs and simulate assembly protocols to ensure constructs can be successfully manufactured and cloned.
homepage: https://parisbiofoundry.org/the-asu-biofoundry/
metadata:
  docker_image: "N/A"
---

# unnamed-workflow

## Overview

This Galaxy workflow automates a synthetic biology pipeline designed for assembly planning and sequence management. It processes an initial assembly plan and specific JSON parameters alongside a collection of GenBank fragments to facilitate the design and verification of genetic constructs.

The pipeline begins by configuring workflow parameters using [Maystro](https://testtoolshed.g2.bx.psu.edu/view/tduigou/parameters_maystro_workflow_1) and retrieving required sequence data from a database. It then performs a critical [manufacturability evaluation](https://testtoolshed.g2.bx.psu.edu/view/tduigou/evaluate_manufacturability) to assess the feasibility of the assembly, generating detailed reports in both TSV and PDF formats.

In the final stages, the workflow executes a [cloning simulation](https://testtoolshed.g2.bx.psu.edu/view/tduigou/cloning_simulation) to model the biological assembly process. The resulting sequence data is then saved back to the database, and the system provides a compressed ZIP archive containing the simulation outputs for downstream analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Assembly Plan | data_input |  |
| 1 | JSON params | data_input |  |
| 2 | Missing gb fragmets from DB | data_collection_input |  |


Ensure the Assembly Plan is provided as a tabular file and the JSON parameters follow the specific schema required by the Maystro tool. The "Missing gb fragments" input must be uploaded as a data collection of GenBank files, while the other primary inputs are handled as individual datasets. For comprehensive details on file formatting and metadata requirements, please consult the `README.md`. You may also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined job configuration and automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Workflow-1 Parameters Maystro | testtoolshed.g2.bx.psu.edu/repos/tduigou/parameters_maystro_workflow_1/parameters_maystro_workflow_1/0.1.0 |  |
| 4 | Get sequences Data From DB | testtoolshed.g2.bx.psu.edu/repos/tduigou/seq_from_db/seq_form_db/0.3.0+galaxy2 |  |
| 5 | Evaluate Manufacturability | testtoolshed.g2.bx.psu.edu/repos/tduigou/evaluate_manufacturability/evaluate_manufacturability/0.5.0+galaxy4 |  |
| 6 | Cloning Simulation | testtoolshed.g2.bx.psu.edu/repos/tduigou/cloning_simulation/cloning_simulation/0.2.0+galaxy1 |  |
| 7 | Save Sequence Data In DB | testtoolshed.g2.bx.psu.edu/repos/tduigou/seq_to_db/seq_to_db/0.3.0+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | output_json | output_json |
| 4 | report | report |
| 5 | report_tsv | report_tsv |
| 5 | report_pdf | report_pdf |
| 6 | output_zip | output_zip |
| 7 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Unnamed_Workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Unnamed_Workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Unnamed_Workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Unnamed_Workflow.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Unnamed_Workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Unnamed_Workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)