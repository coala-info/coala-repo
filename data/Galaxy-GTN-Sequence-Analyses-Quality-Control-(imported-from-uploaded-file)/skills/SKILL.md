---
name: gtn-sequence-analyses-quality-control-imported-from-uploaded
description: This Galaxy workflow performs quality control on paired-end sequencing reads using FastQC for assessment, Cutadapt for adapter trimming, and MultiQC for aggregated reporting. Use this skill when you need to evaluate the quality of raw genomic data and remove technical artifacts like adapter sequences to prepare high-quality reads for downstream bioinformatics applications.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gtn-sequence-analyses-quality-control-imported-from-uploaded

## Overview

This workflow provides a standardized pipeline for the initial quality assessment and preprocessing of raw sequencing data, based on [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) materials for sequence analysis. It is designed to identify sequencing artifacts, evaluate base call quality, and perform necessary data cleaning to ensure reliable downstream results.

The process begins by analyzing raw input reads using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to generate comprehensive quality metrics. Following this initial assessment, [Cutadapt](https://cutadapt.readthedocs.io/) is utilized to trim low-quality bases and remove adapter sequences. This trimming step is crucial for reducing noise and improving the accuracy of subsequent alignment or assembly tasks.

To verify the effectiveness of the cleaning process, the workflow runs a second round of FastQC on the processed reads. Finally, [MultiQC](https://multiqc.info/) aggregates the reports from all steps into a single, interactive summary. This allows users to easily compare the data quality before and after trimming, providing a clear overview of the library's status.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | reads_2 | data_input |  |
| 1 | reads_1 | data_input |  |


Ensure your input sequencing data is in FASTQ format, ideally compressed as .fastq.gz to save storage space. While the workflow is configured for individual forward and reverse read datasets, you may find it more efficient to use paired-end collections if processing multiple samples simultaneously. Consult the README.md for comprehensive details on specific adapter sequences and quality thresholds required for the Cutadapt steps. For automated execution or testing, you can generate a template configuration using `planemo workflow_job_init` to create your `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 3 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.3 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 5 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.3 |  |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.9+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | html_file | html_file |
| 2 | reads_2_fastqc | text_file |
| 3 | reads_1_cutadapt | report |
| 4 | html_file | html_file |
| 4 | reads_1_fastqc | text_file |
| 5 | reads_cutadapt | report |
| 6 | multiqc | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run quality-control.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run quality-control.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run quality-control.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init quality-control.ga -o job.yml`
- Lint: `planemo workflow_lint quality-control.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `quality-control.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)