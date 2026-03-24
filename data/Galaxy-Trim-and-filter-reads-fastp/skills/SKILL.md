---
name: trim-and-filter-reads-fastp
description: "This Galaxy workflow processes Illumina paired-end reads and long reads using the fastp tool to perform quality trimming and filtering. Use this skill when you need to improve the quality of raw sequencing data by removing low-quality bases and adapter sequences before performing downstream genomic analyses."
homepage: https://workflowhub.eu/workflows/224
---

# Trim and filter reads - fastp

## Overview

This Galaxy workflow provides an automated pipeline for the quality control and preprocessing of sequencing data. It is designed to handle both short-read (Illumina R1 and R2) and long-read datasets simultaneously, ensuring that raw reads are properly trimmed and filtered before downstream analysis.

The process utilizes two parallel instances of the [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1) tool. One instance processes the paired-end Illumina reads to perform adapter trimming, base quality filtering, and length filtering. The second instance performs analogous quality control operations specifically tailored for the provided long-read data.

The workflow generates cleaned FASTQ files for both sequencing types, along with comprehensive quality reports in HTML and JSON formats. These outputs allow researchers to verify the effectiveness of the filtering and assess the overall quality of the library. This workflow is tagged as LG-WF.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Illumina reads R1 | data_input |  |
| 1 | Illumina reads R2 | data_input |  |
| 2 | long reads | data_input |  |


Ensure your input files are in FASTQ or compressed FASTQ.GZ format to ensure compatibility and efficient processing. For the Illumina short reads, using a paired-end dataset collection is recommended to maintain read synchronization and simplify the workflow execution compared to individual datasets. Detailed parameter configurations and specific tool settings are documented in the accompanying README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing or batch execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 4 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | fastp filtered R2 reads | out2 |
| 3 | fastp report on short reads html | report_html |
| 3 | fastp filtered R1 reads | out1 |
| 3 | fastp report on short reads json | report_json |
| 4 | fastp report on long reads html | report_html |
| 4 | fastp filtered long reads | out1 |
| 4 | fastp report on long reads json | report_json |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Trim_and_filter_reads.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Trim_and_filter_reads.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Trim_and_filter_reads.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Trim_and_filter_reads.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Trim_and_filter_reads.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Trim_and_filter_reads.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
