---
name: retrosynthesis
description: This metabolic engineering workflow takes a target molecule and utilizes RetroPath2.0, RP2paths, and RRules Parser to predict biosynthetic pathways from an SBML model. Use this skill when you need to identify potential enzymatic reaction sequences and metabolic routes for the microbial production of a specific target compound.
homepage: https://www.micalis.fr/equipe/galaxy-synbiocad/
metadata:
  docker_image: "N/A"
---

# retrosynthesis

## Overview

This workflow automates the retrosynthesis process to identify viable metabolic pathways for a specific target compound. It begins by taking a "Target to produce" as the primary input and utilizes an SBML model (such as iML1515) to define the metabolic sink of the host organism.

The core of the pipeline employs [RetroPath2.0](https://toolshed.g2.bx.psu.edu/repos/tduigou/retropath2/retropath2/2.3.0) to explore chemical transformation spaces based on reaction rules processed by the [RRules Parser](https://toolshed.g2.bx.psu.edu/repos/tduigou/rrparser/rrparser/2.5.2+galaxy0). It integrates [rpextractsink](https://toolshed.g2.bx.psu.edu/repos/tduigou/rptools_rpextractsink/rptools_rpextractsink/6.5.0+galaxy0) to ensure the target molecule can be linked back to the host's native metabolism through predicted enzymatic steps.

Finally, the workflow uses [RP2paths](https://toolshed.g2.bx.psu.edu/repos/tduigou/rp2paths/rp2paths/1.5.0) to extract and organize the resulting pathways and compounds. The process concludes with [rpcompletion](https://toolshed.g2.bx.psu.edu/repos/tduigou/rptools_rpcompletion/rptools_rpcompletion/6.5.0+galaxy0), which generates fully balanced reactions for the predicted synthetic routes. This toolset is particularly useful for metabolic engineering and synthetic biology (brs) applications under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Target to produce | parameter_input |  |


Ensure the target molecule is provided as a string, such as an InChI or SMILES, to initiate the retrosynthesis search against the parsed reaction rules. Since the workflow generates multiple intermediate datasets and pathway collections, maintaining a clean history is essential for tracking the sink and reaction completion outputs. Consult the `README.md` for specific guidance on selecting SBML models and configuring the RRules Parser depth. For automated execution, use `planemo workflow_job_init` to create a `job.yml` file for your input parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Pick SBML Model | toolshed.g2.bx.psu.edu/repos/tduigou/get_sbml_model/get_sbml_model/0.0.3 |  |
| 2 | RRules Parser | toolshed.g2.bx.psu.edu/repos/tduigou/rrparser/rrparser/2.5.2+galaxy0 |  |
| 3 | toolshed.g2.bx.psu.edu/repos/tduigou/rptools_rpextractsink/rptools_rpextractsink/6.5.0+galaxy0 | toolshed.g2.bx.psu.edu/repos/tduigou/rptools_rpextractsink/rptools_rpextractsink/6.5.0+galaxy0 |  |
| 4 | RetroPath2.0 | toolshed.g2.bx.psu.edu/repos/tduigou/retropath2/retropath2/2.3.0 |  |
| 5 | RP2paths | toolshed.g2.bx.psu.edu/repos/tduigou/rp2paths/rp2paths/1.5.0 |  |
| 6 | toolshed.g2.bx.psu.edu/repos/tduigou/rptools_rpcompletion/rptools_rpcompletion/6.5.0+galaxy0 | toolshed.g2.bx.psu.edu/repos/tduigou/rptools_rpcompletion/rptools_rpcompletion/6.5.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | iML1515 | model |
| 2 | RRules Parser(retro, d=['2', '4', '6', '8', '10', '12', '14', '16']) | out_rules |
| 3 | sink | sink |
| 4 | Retropath2.0 | Reaction_Network |
| 5 | RP2paths (pathways) | master_pathways |
| 5 | RP2paths (compounds) | compounds |
| 6 | Complete Reactions | pathways |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-RetroSynthesis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-RetroSynthesis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-RetroSynthesis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-RetroSynthesis.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-RetroSynthesis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-RetroSynthesis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)