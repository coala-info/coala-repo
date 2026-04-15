---
name: pathway-analysis
description: This synthetic biology workflow evaluates heterologous pathways within a specific chassis using flux balance analysis, thermodynamic constraints, and multi-metric scoring tools to rank the most viable candidates. Use this skill when you need to identify the most efficient metabolic routes for producing a target compound by comparing the theoretical yield and thermodynamic feasibility of multiple engineered pathways.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# pathway-analysis

## Overview

This workflow is designed for synthetic biology applications to evaluate and rank heterologous pathways within a specific host chassis. It processes a collection of candidate pathways against a provided chassis model, utilizing parameters such as the cell compartment ID and biomass reaction ID to ensure the metabolic context is accurately represented.

The analysis pipeline integrates several specialized tools to assess pathway viability. It begins with Flux Balance Analysis (FBA) via [rpfba](https://toolshed.g2.bx.psu.edu/repos/iuc/rpfba/rpfba/5.12.1) to determine theoretical production yields, followed by thermodynamic feasibility assessments using [rpthermo](https://toolshed.g2.bx.psu.edu/repos/tduigou/rpthermo/rpthermo/5.12.1).

In the final stages, the workflow applies a multi-metric scoring system through [rpscore](https://toolshed.g2.bx.psu.edu/repos/tduigou/rpscore/rpscore/5.12.1) to evaluate each pathway's performance. These results are then aggregated by [rpranker](https://toolshed.g2.bx.psu.edu/repos/tduigou/rpranker/rpranker/5.12.1) to produce a prioritized list of pathways, facilitating the selection of the most promising candidates for further research or experimental validation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Heterologous pathways | data_collection_input |  |
| 1 | Chassis where to produce target from | data_input |  |
| 2 | Cell compartment ID | parameter_input |  |
| 3 | Biomass reaction ID | parameter_input |  |


Ensure your heterologous pathways are organized into a dataset collection, typically in SBML format, while the chassis model should be provided as a single SBML file. Verify that the cell compartment and biomass reaction IDs exactly match the identifiers used within your specific chassis model to avoid flux balance analysis errors. Consult the included README.md for comprehensive details on parameter formatting and specific metric thresholds. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Flux balance analysis | toolshed.g2.bx.psu.edu/repos/iuc/rpfba/rpfba/5.12.1 |  |
| 5 | Thermo | toolshed.g2.bx.psu.edu/repos/tduigou/rpthermo/rpthermo/5.12.1 |  |
| 6 | Score Pathway | toolshed.g2.bx.psu.edu/repos/tduigou/rpscore/rpscore/5.12.1 |  |
| 7 | Rank Pathways | toolshed.g2.bx.psu.edu/repos/tduigou/rpranker/rpranker/5.12.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | pathway_with_fba | pathway_with_fba |
| 5 | pathway_with_thermo | pathway_with_thermo |
| 6 | scored_pathway | scored_pathway |
| 7 | Ranked Pathways | sorted_pathways |


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