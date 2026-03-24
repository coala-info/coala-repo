---
name: genetic-design-gibson-golden-gate-lcr
description: "This workflow automates the design of genetic constructs for heterologous pathways by integrating enzyme selection via Selenzyme, part optimization with PartsGenie, and assembly planning using DNA Weaver and LCR Genie. Use this skill when you need to optimize enzyme sequences for a specific host organism and generate detailed assembly plans for Gibson, Golden Gate, or LCR cloning methods."
homepage: https://workflowhub.eu/workflows/2007
---

# Genetic Design (Gibson, Golden Gate, LCR)

## Overview

This workflow automates the design and assembly planning of heterologous pathways for synthetic biology applications. It begins by taking a heterologous pathway input along with host and enzyme taxon IDs to initiate a comprehensive pipeline that transitions from metabolic pathway description to physical DNA assembly instructions.

The process utilizes [Selenzyme](https://toolshed.g2.bx.psu.edu/repos/tduigou/selenzy/selenzy-wrapper/0.2.0) for enzyme selection and [SbmlToSbol](https://toolshed.g2.bx.psu.edu/repos/tduigou/sbml2sbol/sbml2sbol/0.1.13) to convert pathway data into standardized formats. Genetic parts are then designed and optimized using [PartsGenie](https://toolshed.g2.bx.psu.edu/repos/tduigou/partsgenie/PartsGenie/1.0.1), while the [Design of Experiment](https://toolshed.g2.bx.psu.edu/repos/tduigou/optdoe/optdoe/2.0.2) step ensures the experimental parameters are optimized for the target host.

In the final stages, the workflow generates detailed assembly strategies through [DNA Weaver](https://toolshed.g2.bx.psu.edu/repos/tduigou/dnaweaver/dnaweaver/1.0.2) and [LCR Genie](https://toolshed.g2.bx.psu.edu/repos/tduigou/lcrgenie/LCRGenie/1.0.2). The primary outputs are actionable assembly plans tailored for various molecular cloning methods, including Gibson assembly, Golden Gate, and Ligase Cycling Reaction (LCR).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Heterologous pathway | data_input |  |
| 1 | Host taxon ID | parameter_input |  |
| 2 | Taxon IDs of output enzyme sequences | parameter_input |  |


Ensure the heterologous pathway is provided in a valid SBML format to allow the Selenzyme and SbmlToSbol tools to correctly parse metabolic reactions and chemical entities. Taxon IDs must be valid NCBI Taxonomy identifiers to ensure accurate enzyme selection and host-specific codon optimization during the design phase. While the primary inputs are individual datasets, organizing multiple pathway variants into collections can streamline batch processing across the DNA Weaver and LCR Genie steps. Refer to the README.md for comprehensive details on parameter constraints and specific file formatting requirements. You may use planemo workflow_job_init to create a job.yml file for automated configuration of these genetic design parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Selenzyme | toolshed.g2.bx.psu.edu/repos/tduigou/selenzy/selenzy-wrapper/0.2.0 |  |
| 4 | SbmlToSbol | toolshed.g2.bx.psu.edu/repos/tduigou/sbml2sbol/sbml2sbol/0.1.13 |  |
| 5 | PartsGenie | toolshed.g2.bx.psu.edu/repos/tduigou/partsgenie/PartsGenie/1.0.1 |  |
| 6 | Design of Experiment | toolshed.g2.bx.psu.edu/repos/tduigou/optdoe/optdoe/2.0.2 |  |
| 7 | DNA Weaver | toolshed.g2.bx.psu.edu/repos/tduigou/dnaweaver/dnaweaver/1.0.2 |  |
| 8 | LCR Genie | toolshed.g2.bx.psu.edu/repos/tduigou/lcrgenie/LCRGenie/1.0.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | DNA Weaver - Assembly Plan | output |
| 8 | LCR Genie: Assembly Plan | LCR_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Genetic_Design_(Gibson,_Golden_Gate,_LCR).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Genetic_Design_(Gibson,_Golden_Gate,_LCR).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Genetic_Design_(Gibson,_Golden_Gate,_LCR).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Genetic_Design_(Gibson,_Golden_Gate,_LCR).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Genetic_Design_(Gibson,_Golden_Gate,_LCR).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Genetic_Design_(Gibson,_Golden_Gate,_LCR).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
