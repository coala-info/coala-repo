---
name: pathway-ranker
description: "This metabolic engineering workflow identifies and ranks biosynthetic pathways for a target molecule within a genome-scale metabolic model using RetroPath2.0, flux balance analysis, and global scoring tools. Use this skill when you need to discover the most thermodynamically and stoichiometrically viable enzymatic routes to produce a specific chemical compound in a microbial host."
homepage: https://workflowhub.eu/workflows/25
---

# Pathway Ranker

## Overview

The Pathway Ranker workflow is designed for the automated discovery and evaluation of metabolic pathways for a specific target molecule. Starting with a target InChI and a Genome-Scale Metabolic Model (GEM SBML), the workflow utilizes [RetroRules](https://retrorules.org/) and [RetroPath2.0](https://github.com/brsynth/RetroPath2) to perform retrosynthesis. It identifies potential biochemical routes by extracting sinks from the SBML model and generating source files to bridge the gap between the target compound and the host's native metabolism.

Once candidate pathways are identified, the workflow converts the results into SBML format and performs a series of refinement steps. This includes completing reactions with necessary cofactors and conducting thermodynamic analysis via [rpThermo](https://github.com/brsynth/rpThermo). To ensure biological feasibility and calculate theoretical yields, the workflow executes Flux Balance Analysis (FBA) using the provided GEM.

In the final stages, the discovered pathways are processed through [rpGlobalScore](https://github.com/brsynth/rpGlobalScore) to rank them based on integrated metrics. The workflow generates a variety of outputs, including ranked SBML files, interactive visualizations, and a comprehensive report, allowing researchers to identify the most promising metabolic routes for experimental validation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Target InChI | parameter_input |  |
| 2 | GEM SBML | data_input |  |
| 3 | Maximal Pathway Length | parameter_input |  |
| 4 | Top Ranking Pathways | parameter_input |  |


Ensure the GEM SBML input is a valid XML file and the Target InChI is provided as a precise chemical string to avoid search errors during the RetroPath2.0 execution. While the primary inputs are individual datasets, the workflow generates complex collections for pathway visualization that are best managed within a dedicated Galaxy history. Consult the `README.md` for comprehensive details on parameter constraints and metabolic sink preparation. For automated testing or command-line execution, use `planemo workflow_job_init` to create a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | RetroRules | retrorules |  |
| 5 | Make Source | makeSource |  |
| 6 | Sink from SBML | rpExtractSink |  |
| 7 | RetroPath2.0 | retropath2 |  |
| 8 | RP2paths | rp2paths |  |
| 9 | Pathways to SBML | rpReader |  |
| 10 | Complete Reactions | rpCofactors |  |
| 11 | Thermodynamics | rpThermo |  |
| 12 | FBA | rpFBA |  |
| 13 | Rank Pathways | rpGlobalScore |  |
| 14 | Pathway Visualiser | rpVisualiser |  |
| 15 | Report | rpReport |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | output | output |
| 5 | sourceFile | sourceFile |
| 6 | output | output |
| 7 | scope_csv | scope_csv |
| 8 | rp2paths_compounds | rp2paths_compounds |
| 8 | rp2paths_pathways | rp2paths_pathways |
| 9 | output | output |
| 10 | output | output |
| 11 | output | output |
| 12 | output | output |
| 13 | output | output |
| 14 | output | output |
| 15 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Pathway_Ranker.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Pathway_Ranker.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Pathway_Ranker.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Pathway_Ranker.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Pathway_Ranker.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Pathway_Ranker.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
