---
name: pathway-analysis
description: "This Galaxy workflow processes rpSBML and GEM SBML files to perform flux balance analysis, thermodynamic evaluation, and global scoring of metabolic pathways using rpFBA, rpThermo, and rpGlobalScore. Use this skill when you need to identify the most promising biosynthetic routes for a target compound by evaluating their metabolic flux and thermodynamic favorability within a genome-scale model."
homepage: https://workflowhub.eu/workflows/22
---

# Pathway Analysis

## Overview

This workflow performs a comprehensive evaluation and ranking of metabolic pathways to identify the most viable candidates for metabolic engineering. It processes a collection of pathways in rpSBML format alongside a Genome-scale Metabolic Model (GEM) to assess how these pathways perform within a specific host organism.

The analysis pipeline integrates three primary computational steps. First, it utilizes [rpFBA](https://github.com/brsynth/rpFBA) to calculate flux distributions and theoretical yields. It then performs a thermodynamic feasibility assessment using [rpThermo](https://github.com/brsynth/rpThermo) to ensure the reactions are energetically favorable. Finally, the [rpGlobalScore](https://github.com/brsynth/rpScore) tool aggregates these metrics to rank the pathways based on a user-defined number of top results.

The workflow generates detailed outputs for each stage, providing flux balance data, thermodynamic profiles, and a prioritized list of high-ranking pathways. These results enable researchers to transition from a broad set of theoretical routes to a focused selection of pathways optimized for experimental validation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | rpSBML TAR | data_input |  |
| 1 | GEM SBML | data_input |  |
| 2 | Top Ranking Pathways | parameter_input |  |


Ensure the rpSBML input is provided as a compressed TAR archive containing valid SBML files, while the GEM SBML must be a single standalone model file. If you are processing multiple pathway sets, utilizing Galaxy collections can help streamline the data flow through the FBA and thermodynamics tools. Please consult the README.md for comprehensive details on parameter settings and scoring criteria. You may also use `planemo workflow_job_init` to create a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | FBA | rpFBA |  |
| 4 | Thermodynamics | rpThermo |  |
| 5 | Rank Pathways | rpGlobalScore |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | output | output |
| 4 | output | output |
| 5 | output | output |


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
