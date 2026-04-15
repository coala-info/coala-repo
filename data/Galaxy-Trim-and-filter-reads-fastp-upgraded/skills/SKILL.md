---
name: trim-and-filter-reads-fastp-upgraded
description: This Galaxy workflow processes Illumina paired-end reads and long reads using the fastp tool to perform quality trimming and filtering. Use this skill when you need to improve the quality of raw sequencing data by removing adapters and low-quality bases before proceeding with downstream genomic analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# trim-and-filter-reads-fastp-upgraded

## Overview

This Galaxy workflow provides an automated solution for the quality control and preprocessing of both short-read and long-read sequencing data. It is designed to handle paired-end Illumina reads (R1 and R2) alongside a separate dataset of long reads, ensuring that all input types are cleaned and filtered before downstream analysis.

The core of the workflow utilizes [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.4+galaxy0), an all-in-one preprocessing tool. Two parallel instances of the tool are executed: one specifically configured for the paired-end short reads and another optimized for the long-read data. This approach allows for efficient adapter trimming, quality filtering, and read pruning across different sequencing technologies within a single pipeline.

The workflow generates filtered sequence files for both short and long reads, ready for assembly or mapping. Additionally, it produces comprehensive quality reports in both HTML and JSON formats for each data type, providing detailed insights into filtering statistics and read quality. This workflow is licensed under GPL-3.0-or-later and is associated with [GTN](https://training.galaxyproject.org/) training materials.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Illumina reads R1 | data_input |  |
| 1 | Illumina reads R2 | data_input |  |
| 2 | long reads | data_input |  |


Ensure all input files are provided in fastq or fastq.gz format to maintain compatibility with the fastp processing steps. For the Illumina reads, utilizing paired-end collections is recommended over individual datasets to streamline data handling and ensure proper pairing. Detailed guidance on specific filtering thresholds and adapter trimming configurations can be found in the README.md. You may also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.4+galaxy0 |  |
| 4 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.4+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | fastp report on short reads html | report_html |
| 3 | fastp filtered R1 reads | out1 |
| 3 | fastp report on short reads json | report_json |
| 3 | fastp filtered R2 reads | out2 |
| 4 | fastp report on long reads html | report_html |
| 4 | fastp filtered long reads | out1 |
| 4 | fastp report on long reads json | report_json |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-trim-and-filter-reads.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-trim-and-filter-reads.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-trim-and-filter-reads.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-trim-and-filter-reads.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-trim-and-filter-reads.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-trim-and-filter-reads.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)