---
name: parallel-accession-download
description: This Galaxy workflow processes a text file of sequencing run accessions to download FASTQ files in parallel using the fasterq-dump tool. Use this skill when you need to efficiently retrieve large volumes of raw genomic data from public archives for high-throughput sequencing analysis.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# parallel-accession-download

## Overview

This Galaxy workflow automates the high-throughput retrieval of sequencing data from the Sequence Read Archive (SRA). By taking a text file of run accessions as input, it utilizes the [fasterq-dump](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/3.1.1+galaxy0) tool to download and extract FASTQ files efficiently.

The process is optimized for speed and reliability by first splitting the input list into a collection of individual accessions. This triggers parallel job execution, creating a separate job for each accession. This parallelized approach is significantly faster and more robust to network or processing errors than downloading multiple accessions within a single task.

Upon completion, the workflow applies specific rules to organize the retrieved data. It generates two distinct output collections: one for paired-end reads and another for single-end reads, ensuring the data is correctly formatted for downstream bioinformatics pipelines. This workflow is provided under an MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Run accessions | data_input | Text file containing run accessions (starting with SRR, ERR or DRR), one per line. |


Provide a simple text file containing one SRA run accession per line to ensure the workflow correctly splits the input into a collection for parallel processing. Using a single dataset as the primary input allows the tool to manage job distribution efficiently across the cluster. For comprehensive details on formatting and SRA toolkit requirements, please refer to the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` file for streamlined command-line execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.2 |  |
| 2 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/3.1.1+galaxy0 |  |
| 3 | Apply rules | __APPLY_RULES__ |  |
| 4 | Apply rules | __APPLY_RULES__ |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | Paired End Reads | output |
| 4 | Single End Reads | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run parallel-accession-download.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run parallel-accession-download.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run parallel-accession-download.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init parallel-accession-download.ga -o job.yml`
- Lint: `planemo workflow_lint parallel-accession-download.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `parallel-accession-download.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)