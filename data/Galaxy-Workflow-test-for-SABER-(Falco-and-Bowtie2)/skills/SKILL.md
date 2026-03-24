---
name: falco-bowtie2
description: "This workflow processes sequencing reads using Falco for quality assessment and Bowtie2 for alignment to evaluate the functional status of bioinformatics platforms. Use this skill when you need to monitor the reliability of Galaxy endpoints and ensure that core sequence analysis tools are executing correctly across different environments."
homepage: https://workflowhub.eu/workflows/1845
---

# Falco-bowtie2

## Overview

The Falco-bowtie2 workflow is a specialized monitoring tool built for the [SABER](https://monitor.usegalaxy.it) (System for Automated Bioinformatics Endpoint Reliability) infrastructure. It is designed to validate the operational status and reliability of Galaxy instances by executing lightweight, automated test runs on a daily schedule.

The pipeline processes synthetic *sacCer3* sequence data through two primary stages: quality control using [Falco](https://github.com/isovic/falco) and sequence alignment via [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml). By utilizing minimal runtime configurations, the workflow ensures prompt failure detection across multiple endpoints without consuming excessive computational resources.

Results are captured as timestamped HTML and text reports, providing a traceable history of instance performance. While optimized for scalable monitoring and infrastructure testing under the MIT license, this workflow is not intended for full-scale production bioinformatics analysis. For detailed setup and configuration instructions, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | 1_reads | data_input | Input FASTQ file |


Provide input reads in FASTQ format to ensure compatibility with both Falco quality control and Bowtie2 alignment steps. While this monitoring workflow is optimized for individual datasets to maintain a lightweight footprint, it can be adapted for dataset collections if testing parallel processing capabilities. Refer to the `README.md` for comprehensive instructions on configuring the encrypted YAML files required for automated endpoint monitoring. You may use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution across multiple Galaxy instances.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 2 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.3+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | html_file | html_file |
| 1 | text_file | text_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Falco-bowtie2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Falco-bowtie2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Falco-bowtie2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Falco-bowtie2.ga -o job.yml`
- Lint: `planemo workflow_lint Falco-bowtie2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Falco-bowtie2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
