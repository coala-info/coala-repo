---
name: galaxy-intro-short
description: This bioinformatics workflow processes mutant R1 FASTQ sequencing data using FastQC for quality assessment and multiple filtering steps to remove low-quality reads. Use this skill when you need to perform initial quality control and data cleaning on raw sequencing reads to ensure high-quality inputs for downstream genomic analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# galaxy-intro-short

## Overview

This workflow provides a foundational introduction to the Galaxy platform, specifically designed for users following [GTN (Galaxy Training Network)](https://training.galaxyproject.org/) introductory materials. It demonstrates a basic quality control (QC) pipeline for processing raw sequencing data.

The process begins with a single input, `mutant_R1`, which is first analyzed using [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72) to assess read quality. Following this assessment, the data is passed through two sequential [Filter by quality](https://toolshed.g2.bx.psu.edu/repos/devteam/fastq_quality_filter/cshl_fastq_quality_filter/1.0.1) steps to refine the dataset.

The workflow generates two primary outputs, `filter1` and `filter2`, representing the filtered datasets from steps 2 and 3. This short sequence serves as a practical entry point for learning how to navigate the Galaxy tool interface and manage data flow between processing steps.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mutant_R1 | data_input |  |


Ensure the input `mutant_R1` is uploaded in FASTQ format (fastq or fastq.gz) to maintain compatibility with the FastQC and quality filtering tools. While this workflow is designed for a single dataset, you can adapt it for high-throughput processing by utilizing dataset collections for multiple samples. Please refer to the `README.md` for comprehensive details regarding specific parameter settings and data preparation requirements. You can also use `planemo workflow_job_init` to quickly generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72 |  |
| 2 | Filter by quality | toolshed.g2.bx.psu.edu/repos/devteam/fastq_quality_filter/cshl_fastq_quality_filter/1.0.1 |  |
| 3 | Filter by quality | toolshed.g2.bx.psu.edu/repos/devteam/fastq_quality_filter/cshl_fastq_quality_filter/1.0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | filter1 | output |
| 3 | filter2 | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflowlaxy-intro-short.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflowlaxy-intro-short.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflowlaxy-intro-short.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflowlaxy-intro-short.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflowlaxy-intro-short.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflowlaxy-intro-short.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)