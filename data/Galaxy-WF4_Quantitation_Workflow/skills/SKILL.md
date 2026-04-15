---
name: wf4_quantitation_workflow
description: This proteomics workflow performs protein quantification by processing raw mass spectrometry data and experimental design files using the MaxQuant tool against a specified protein database. Use this skill when you need to identify and quantify proteins in complex biological samples to determine relative abundance across different experimental conditions.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# wf4_quantitation_workflow

## Overview

This workflow is designed for proteomic quantification using the [MaxQuant](https://toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/1.6.17.0+galaxy4) tool within the Galaxy ecosystem. It facilitates the automated processing of raw mass spectrometry data to identify and quantify proteins based on a provided sequence database and specific experimental parameters.

The pipeline requires three primary inputs: a quantitation database, an experimental design file for discovery, and a collection of raw mass spectrometry files. After the initial MaxQuant processing, the workflow utilizes a series of downstream data manipulation steps—including filtering with `Grep`, column selection with `Cut`, and data aggregation using the `Group` tool—to refine and organize the quantitative output.

Developed under the clinicalmp and [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) frameworks, this workflow provides a standardized approach to protein quantitation. It is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/), making it a reusable resource for clinical and research proteomics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Quantitation_Database-For-MaxQuant | data_input |  |
| 1 | Experimental-Design Discovery MaxQuant | data_input |  |
| 2 | Input Raw-files | data_collection_input |  |


Ensure your mass spectrometry data is organized into a list collection of `.raw` files to satisfy the MaxQuant input requirements. The experimental design file should be a tabular format that precisely maps raw file names to their respective groups and fractions, while the protein database must be in FASTA format. Consult the `README.md` for comprehensive instructions on configuring specific MaxQuant parameters and experimental design templates. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | MaxQuant | toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/1.6.17.0+galaxy4 |  |
| 4 | Select | Grep1 |  |
| 5 | Select | Grep1 |  |
| 6 | Cut | Cut1 |  |
| 7 | Cut | Cut1 |  |
| 8 | Group | Grouping1 |  |
| 9 | Group | Grouping1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run wf4-quantitation-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run wf4-quantitation-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run wf4-quantitation-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init wf4-quantitation-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint wf4-quantitation-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `wf4-quantitation-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)