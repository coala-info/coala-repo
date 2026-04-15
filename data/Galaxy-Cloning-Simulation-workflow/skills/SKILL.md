---
name: cloning-simulation-workflow-v2
description: This synthetic biology workflow simulates Golden Gate assembly by processing assembly plans and JSON parameters through sequence retrieval, manufacturability evaluation, and cloning simulation tools. Use this skill when you need to validate the feasibility of complex DNA assembly designs and predict the final sequence of recombinant constructs before laboratory implementation.
homepage: https://parisbiofoundry.org/the-asu-biofoundry/
metadata:
  docker_image: "N/A"
---

# cloning-simulation-workflow-v2

## Overview

This Galaxy workflow performs a GoldenGate cloning simulation to validate assembly plans and evaluate sequence viability. It requires three primary inputs: an assembly plan, a JSON parameters file, and a collection of missing fragments. The process is designed to automate the transition from theoretical design to simulated verification.

The pipeline begins by configuring execution parameters via [Parameters Maystro](https://toolshed.g2.bx.psu.edu/repos/tduigou/parameters_maystro_workflow_1/parameters_maystro_workflow_1/0.1.0) and retrieving necessary sequence data from a database. It then performs a manufacturability evaluation, generating detailed PDF and TSV reports to ensure the sequences are suitable for physical assembly before proceeding to the simulation stage.

The core [Cloning Simulation](https://toolshed.g2.bx.psu.edu/repos/tduigou/cloning_simulation/cloning_simulation/0.2.0+galaxy1) step executes the GoldenGate assembly logic, producing final GenBank files and a compressed archive of the results. To ensure data persistence, the workflow concludes by saving the newly generated sequence data and reports back into the database for future use.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Assembly Plan | data_input |  |
| 1 | JSON parameters file | data_input |  |
| 2 | Missing Fragments | data_collection_input | GenBank collection for fragments not found in the database |


Ensure the Assembly Plan and JSON parameters are uploaded as individual datasets, while the Missing Fragments must be provided as a dataset collection to ensure compatibility with the simulation steps. Use standard JSON formatting for the parameters file and verify that the assembly plan aligns with the requirements of the Maystro tool. For comprehensive instructions on data structure and specific field requirements, refer to the `README.md` file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined job configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Workflow-1 Parameters Maystro | toolshed.g2.bx.psu.edu/repos/tduigou/parameters_maystro_workflow_1/parameters_maystro_workflow_1/0.1.0 |  |
| 4 | Get sequences Data From DB | toolshed.g2.bx.psu.edu/repos/tduigou/seq_from_db/seq_form_db/0.3.0+galaxy2 |  |
| 5 | Evaluate Manufacturability | toolshed.g2.bx.psu.edu/repos/tduigou/evaluate_manufacturability/evaluate_manufacturability/0.3.0+galaxy2 |  |
| 6 | Cloning Simulation | toolshed.g2.bx.psu.edu/repos/tduigou/cloning_simulation/cloning_simulation/0.2.0+galaxy1 |  |
| 7 | Save Sequence Data In DB | toolshed.g2.bx.psu.edu/repos/tduigou/seq_to_db/seq_to_db/0.3.0+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | Workflow-1 Parameters | output_json |
| 4 | GenBank Files collection | output_gb |
| 4 | missing fragments | report |
| 5 | Manufacturability Report (PDF) | report_pdf |
| 5 | Manufacturability Report (tsv) | report_tsv |
| 5 | Evaluate Manufacturability (gb) | annotated_gb |
| 6 | simulation results (zip) | output_zip |
| 6 | simulation results (gb) | construct_gb |
| 7 | saving report | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Cloning_Simulation_workflow_v2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Cloning_Simulation_workflow_v2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Cloning_Simulation_workflow_v2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Cloning_Simulation_workflow_v2.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Cloning_Simulation_workflow_v2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Cloning_Simulation_workflow_v2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)