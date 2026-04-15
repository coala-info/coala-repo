---
name: retrosynthesis
description: This synthetic biology workflow takes a target molecule as input and utilizes RetroPath2.0, RP2paths, and RPcompletion to predict theoretical metabolic pathways for its production within a specific SBML host model. Use this skill when you need to identify potential enzymatic reaction sequences to synthesize a target metabolite from a host organism's endogenous precursors.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# retrosynthesis

## Overview

This workflow is designed for synthetic biology applications, specifically focusing on retrosynthesis to discover metabolic pathways for the production of target molecules. In this specific implementation, the pipeline is configured to generate theoretical pathways for producing Lycopene within an *E. coli* host, leveraging tools and methodologies often featured in the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/).

The process begins by retrieving a host SBML model (iML1515) and parsing reaction rules to define the chemical search space. Using [RetroPath2.0](https://toolshed.g2.bx.psu.edu/repos/tduigou/retropath2/retropath2/2.3.0), the workflow performs a retrosynthetic search from the target compound back to the available "sink" metabolites extracted from the host model. This automated approach identifies the necessary enzymatic steps required to bridge the gap between host metabolism and the desired product.

Once the reaction network is generated, the workflow utilizes [RP2paths](https://toolshed.g2.bx.psu.edu/repos/tduigou/rp2paths/rp2paths/1.5.0) to enumerate individual pathways and [RPCompletion](https://toolshed.g2.bx.psu.edu/repos/tduigou/rpcompletion/rpcompletion/5.12.2) to finalize the chemical equations. The final outputs include a comprehensive set of theoretical pathways, master pathway maps, and compound lists, providing a foundation for further metabolic engineering and flux analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Target to produce | parameter_input |  |


Ensure the target molecule is provided in SMILES format and that the chassis SBML model is compatible with the RetroPath2.0 toolset. While the initial input is a single parameter, subsequent steps generate complex pathway collections that require careful management within the Galaxy history. Refer to the README.md for comprehensive details on configuring reaction rules and sink parameters specific to E. coli. You can automate the setup of these parameters by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Pick SBML Model | toolshed.g2.bx.psu.edu/repos/tduigou/get_sbml_model/get_sbml_model/0.0.1 |  |
| 2 | RRules Parser | toolshed.g2.bx.psu.edu/repos/tduigou/rrparser/rrparser/2.4.6 |  |
| 3 | Sink from SBML | toolshed.g2.bx.psu.edu/repos/tduigou/rpextractsink/rpextractsink/5.12.1 |  |
| 4 | RetroPath2.0 | toolshed.g2.bx.psu.edu/repos/tduigou/retropath2/retropath2/2.3.0 |  |
| 5 | RP2paths | toolshed.g2.bx.psu.edu/repos/tduigou/rp2paths/rp2paths/1.5.0 |  |
| 6 | Complete Reactions | toolshed.g2.bx.psu.edu/repos/tduigou/rpcompletion/rpcompletion/5.12.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Pick SBML Model - iML1515 | sbml_model |
| 2 | RRules Parser(retro, d=['2', '4', '6', '8', '10', '12', '14', '16']) | out_rules |
| 3 | sink | sink |
| 4 | Reaction_Network | Reaction_Network |
| 5 | master_pathways | master_pathways |
| 5 | compounds | compounds |
| 6 | pathways | pathways |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run retrosynthesis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run retrosynthesis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run retrosynthesis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init retrosynthesis.ga -o job.yml`
- Lint: `planemo workflow_lint retrosynthesis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `retrosynthesis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)