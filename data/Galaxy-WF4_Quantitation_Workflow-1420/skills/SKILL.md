---
name: wf4_quantitation_workflow
description: This Galaxy workflow performs protein quantification from raw mass spectrometry data using MaxQuant, a protein database, and an experimental design file. Use this skill when you need to identify and quantify proteins across multiple samples to analyze differential expression or protein abundance in discovery-based proteomics studies.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# wf4_quantitation_workflow

## Overview

This workflow is designed for protein quantification in proteomics research, specifically utilizing the [MaxQuant](https://toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/1.6.17.0+galaxy4) tool. It processes mass spectrometry raw data to identify and quantify proteins based on a provided sequence database and a specific experimental design.

The pipeline requires three primary inputs: a quantitation database, an experimental design file for discovery, and a collection of raw mass spectrometry files. After the initial MaxQuant processing, the workflow performs several downstream data manipulation steps, including filtering with Grep, column selection via the Cut tool, and data aggregation using the Grouping tool to refine the final quantitative output.

Developed under the [clinicalmp](https://github.com/clinicalmp) and [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) tags, this workflow provides a standardized approach for clinical proteomics. It is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/), making it a reusable resource for the bioinformatics community.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Quantitation_Database-For-MaxQuant | data_input |  |
| 1 | Experimental-Design Discovery MaxQuant | data_input |  |
| 2 | Input Raw-files | data_collection_input |  |


Ensure your protein database is in FASTA format and the experimental design is a correctly formatted tabular file compatible with MaxQuant requirements. Use a list collection for the raw mass spectrometry files to ensure the workflow processes all samples simultaneously within the MaxQuant tool. Refer to the included README.md for specific parameter configurations and detailed column specifications for the experimental design file. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution and testing.

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