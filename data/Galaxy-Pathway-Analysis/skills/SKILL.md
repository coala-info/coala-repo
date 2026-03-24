---
name: pathway-analysis
description: "This workflow evaluates heterologous pathways within a microbial chassis using flux balance analysis, thermodynamic constraints, and scoring tools to rank metabolic routes. Use this skill when you need to identify and prioritize the most viable synthetic pathways for producing a target compound based on predicted yield and thermodynamic feasibility."
homepage: https://workflowhub.eu/workflows/2005
---

# Pathway Analysis

## Overview

This workflow evaluates and ranks heterologous metabolic pathways for producing a target molecule within a specific host organism (chassis). It utilizes a collection of candidate pathways and a chassis model as primary inputs, requiring specific parameters such as the cell compartment and biomass reaction IDs to accurately simulate the metabolic environment.

The analysis pipeline is powered by the [rpTools](https://github.com/brs-cosmo/rpTools) suite to assess pathway viability through multiple lenses. It begins with Flux Balance Analysis (FBA) to calculate theoretical yields, followed by thermodynamic feasibility assessments. These metrics are then integrated into a global score for each pathway, allowing for a rigorous comparison of different synthetic routes.

The final outputs provide a comprehensive set of scored pathways and a ranked list of pathway IDs. By filtering out energetically unfavorable or low-yield routes, this workflow streamlines the retrosynthesis process and helps researchers identify the most promising candidates for experimental implementation in metabolic engineering projects.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Heterologous pathways | data_collection_input |  |
| 1 | Chassis where to produce target from | data_input |  |
| 2 | Cell compartment ID | parameter_input |  |
| 3 | Biomass reaction ID | parameter_input |  |


Ensure the heterologous pathways are provided as a collection of SBML files, while the chassis model should be uploaded as a single SBML dataset. Verify that the cell compartment and biomass reaction IDs exactly match the identifiers within your chassis model to ensure the flux balance analysis executes correctly. Using a data collection for pathways allows the workflow to efficiently process and rank multiple retrosynthesis solutions in parallel. Refer to the README.md for comprehensive details on required SBML namespaces and specific parameter formatting. You can automate the configuration of these inputs by using planemo workflow_job_init to generate a job.yml file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Flux balance analysis | toolshed.g2.bx.psu.edu/repos/tduigou/rptools_rpfba/rptools_rpfba/6.5.0+galaxy0 |  |
| 5 | Thermo | toolshed.g2.bx.psu.edu/repos/tduigou/rptools_rpthermo/rptools_rpthermo/6.5.0 |  |
| 6 | Score Pathway | toolshed.g2.bx.psu.edu/repos/tduigou/rptools_rpscore/rptools_rpscore/6.5.0+galaxy0 |  |
| 7 | Rank Pathways | toolshed.g2.bx.psu.edu/repos/tduigou/rptools_rpranker/rptools_rpranker/6.5.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Pathways with FBA score | pathway_with_fba |
| 5 | Pathways with FBA + thermo scores | pathway_with_thermo |
| 6 | Fully Scored Pathways | scored_pathway |
| 7 | Ranked Pathways IDs | sorted_pathways |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Pathway_Analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Pathway_Analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Pathway_Analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Pathway_Analysis.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Pathway_Analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Pathway_Analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
