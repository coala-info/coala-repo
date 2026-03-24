---
name: domestication-and-cloning-simulation-workflow-v2
description: "This synthetic biology workflow processes genetic fragments and simulation plans using tools like Sculpt Sequences and Domestication Of New Parts to prepare DNA for Golden Gate assembly. Use this skill when you need to automate the domestication of novel genetic parts by removing restricted enzyme sites and verifying manufacturability before simulating complex cloning procedures."
homepage: https://workflowhub.eu/workflows/2001
---

# Domestication and cloning simulation workflow v2

## Overview

This Galaxy workflow automates the domestication of genetic parts and simulates Golden Gate assembly processes. It is designed to streamline the transition from theoretical design to manufacturable genetic constructs by integrating sequence retrieval, optimization, and cloning simulation into a single pipeline.

The process begins by fetching sequence data and evaluating the manufacturability of genetic fragments based on a provided simulation plan and assembly standards. It utilizes tools like [Sculpt Sequences](https://toolshed.g2.bx.psu.edu/repos/tduigou/sculpt_sequences/sculpt_sequences/0.2.0+galaxy1) and [Domestication Of New Parts](https://toolshed.g2.bx.psu.edu/repos/tduigou/domestication_of_new_parts/domestication_of_new_parts/0.2.0+galaxy1) to modify sequences for compatibility, ensuring they meet specific biological constraints and assembly requirements.

In the final stages, the workflow performs a comprehensive [Cloning Simulation](https://toolshed.g2.bx.psu.edu/repos/tduigou/cloning_simulation/cloning_simulation/0.2.0+galaxy1) to predict assembly outcomes. The results, including domesticated GenBank files, manufacturability reports (PDF/TSV), and simulation logs, are then saved back to a database for downstream laboratory execution.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Simulation Plan | data_input |  |
| 1 | Missing Fragments | data_collection_input | GenBank collection for fragments not found in the database |
| 2 | JSON parameters file | data_input |  |
| 3 | Assembly Standard | data_input | For Domestication process |
| 4 | New fragment for cloning simulation | data_collection_input | This applies only when the user wishes to incorporate additional fragments into the cloning simulation that are not part of the domestication process. |


Ensure your Simulation Plan and Assembly Standard are provided in GenBank or JSON formats as required by the Maystro tools, while the JSON parameters file must strictly follow the schema for workflow-2. Use list collections for "Missing Fragments" and "New fragment for cloning simulation" to allow the workflow to batch process multiple genetic parts simultaneously. For automated execution, you can generate a template for your inputs using `planemo workflow_job_init` to create a `job.yml` file. Refer to the `README.md` for specific naming conventions and detailed attribute requirements for the input sequences. Always verify that your sequence collections are properly mapped to avoid errors during the domestication and cloning simulation steps.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Workflow-2 Parameters Maystro | toolshed.g2.bx.psu.edu/repos/tduigou/parameters_maystro_workflow_2/parameters_maystro_workflow_2/0.1.0 |  |
| 6 | Get sequences Data From DB | toolshed.g2.bx.psu.edu/repos/tduigou/seq_from_db/seq_form_db/0.3.0+galaxy2 |  |
| 7 | Evaluate Manufacturability | toolshed.g2.bx.psu.edu/repos/tduigou/evaluate_manufacturability/evaluate_manufacturability/0.3.0+galaxy2 |  |
| 8 | Sculpt Sequences | toolshed.g2.bx.psu.edu/repos/tduigou/sculpt_sequences/sculpt_sequences/0.2.0+galaxy1 |  |
| 9 | Domestication Of New Parts | toolshed.g2.bx.psu.edu/repos/tduigou/domestication_of_new_parts/domestication_of_new_parts/0.2.0+galaxy1 |  |
| 10 | Cloning Simulation | toolshed.g2.bx.psu.edu/repos/tduigou/cloning_simulation/cloning_simulation/0.2.0+galaxy1 |  |
| 11 | Save Sequence Data In DB | toolshed.g2.bx.psu.edu/repos/tduigou/seq_to_db/seq_to_db/0.3.0+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | Workflow-2 Parameters | output_json |
| 6 | missing fragments | report |
| 6 | GenBank Files collection | output_gb |
| 7 | Manufacturability Report (PDF) | report_pdf |
| 7 | Evaluate Manufacturability (gb) | annotated_gb |
| 7 | Manufacturability Report (tsv) | report_tsv |
| 8 | scul group | scul |
| 8 | unscul+scul gb | unscul |
| 9 | domestication results | domesticated_zip |
| 9 | Domesticated GenBank Files | domesticated_gb |
| 10 | simulation results (zip) | output_zip |
| 11 | json_output | json_output |
| 11 | saving report | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Domestication_and_cloning_simulation_workflow_v2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Domestication_and_cloning_simulation_workflow_v2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Domestication_and_cloning_simulation_workflow_v2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Domestication_and_cloning_simulation_workflow_v2.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Domestication_and_cloning_simulation_workflow_v2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Domestication_and_cloning_simulation_workflow_v2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
