---
name: by-covid-data-download
description: This Galaxy workflow takes a two-column sample table of SRR identifiers and uses tools like Cut, Grep, and fasterq-dump to download and extract raw FASTQ reads from NCBI. Use this skill when you need to automate the retrieval of public viral sequencing datasets for large-scale genomic analysis or pandemic monitoring efforts.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# by-covid-data-download

## Overview

This Galaxy workflow is designed to automate the retrieval of sequencing data from NCBI as part of the [BY-COVID](https://by-covid.org/) project. It streamlines the process of fetching raw reads by taking a structured list of SRA identifiers and converting them into a ready-to-use dataset collection.

The workflow requires a specific input format: a two-column sample table with a header. The first column, labeled **Run**, must contain valid SRR identifiers, while the second column, **Group**, is used for sample categorization. This structured approach ensures that the downstream tools correctly parse the metadata before initiating the download.

Internally, the pipeline uses text manipulation tools to isolate the identifiers, followed by the [fasterq-dump](https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump) utility from the SRA Toolkit. This tool efficiently downloads and extracts the sequencing data into a FASTQ collection, which serves as the primary output for further genomic analysis.

Licensed under [AGPL-3.0-or-later](https://spdx.org/licenses/AGPL-3.0-or-later.html), this workflow is tagged for use within the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) and the broader BY-COVID ecosystem. It provides a standardized entry point for researchers needing to integrate public SRA data into their Galaxy histories.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Sample Table | data_input | This should be a two column sample table that looks like:  ``` Run	Group SRR16681566	healthy SRR16681565	healthy SRR16681564	healthy ``` |


Ensure the input Sample Table is a tabular file containing a header with "Run" and "Group" columns, where the "Run" column specifically lists SRR accessions. This workflow processes the list to generate a collection of FASTQ files, which is more efficient for downstream batch analysis than handling individual datasets. Refer to the `README.md` for specific formatting examples and detailed metadata requirements. You can also streamline the execution setup by using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Cut | Cut1 |  |
| 2 | Select | Grep1 |  |
| 3 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/3.0.8+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | output_collection | output_collection |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-by-covid--data-download.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-by-covid--data-download.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-by-covid--data-download.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-by-covid--data-download.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-by-covid--data-download.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-by-covid--data-download.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)