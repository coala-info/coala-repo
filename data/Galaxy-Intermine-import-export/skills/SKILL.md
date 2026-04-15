---
name: intermine-importexport
description: This Galaxy workflow utilizes the InterMine Galaxy Exchange tool to transform input datasets into the InterMine Interchange format for biological data sharing. Use this skill when you need to export processed genomic results to an InterMine database to facilitate integrated data mining and comparative biological queries.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# intermine-importexport

## Overview

This workflow facilitates the seamless transfer of biological data between Galaxy and [InterMine](https://intermine.org/) instances. It is designed to bridge the gap between Galaxy's analytical capabilities and InterMine's integrative data warehousing, allowing researchers to move datasets efficiently between the two platforms.

The process takes a single input dataset and utilizes the [Create InterMine Interchange](https://toolshed.g2.bx.psu.edu/view/iuc/intermine_galaxy_exchange/) tool to format the data for exchange. This enables users to export Galaxy results into an InterMine database for complex cross-organism queries or to bring specific genomic data into Galaxy for further processing.

Developed in alignment with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) standards, this workflow is a key utility for enhancing interoperability. It is particularly useful for bioinformatics pipelines that require integrated data mining and comparative genomic analysis across different biological databases.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset | data_input |  |


Ensure your input datasets are in the appropriate tabular or genomic formats required by your specific Intermine instance. While the workflow accepts individual datasets, utilizing dataset collections allows for efficient batch processing of multiple files through the exchange tool. Consult the README.md for essential details regarding API credentials and destination URL configurations. You can also use `planemo workflow_job_init` to generate a `job.yml` for streamlined execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Create InterMine Interchange | toolshed.g2.bx.psu.edu/repos/iuc/intermine_galaxy_exchange/galaxy_intermine_exchange/0.0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | intermine_output | intermine_output |


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