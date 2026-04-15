---
name: data-qc
description: This Galaxy workflow performs quality control on long reads and paired-end Illumina reads using NanoPlot, FastQC, and MultiQC to generate comprehensive summary reports. Use this skill when you need to evaluate the integrity and sequencing quality of hybrid datasets to ensure they meet the standards required for reliable downstream assembly or variant calling.
homepage: https://usegalaxy.org.au/
metadata:
  docker_image: "N/A"
---

# data-qc

## Overview

This workflow provides a comprehensive quality control (QC) pipeline for sequencing data, supporting both long-read and short-read (Illumina) platforms. It is designed to process three primary inputs: a long-read dataset and paired-end Illumina reads (R1 and R2), making it ideal for hybrid sequencing projects.

The long-read data is analyzed using [NanoPlot](https://toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.28.2+galaxy1), which generates statistical summaries and visualizations specific to long-read characteristics. Simultaneously, the Illumina paired-end reads are processed through [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1) to evaluate base quality, GC content, and adapter contamination.

To streamline the review process, the workflow utilizes [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.9+galaxy1) to aggregate the individual reports into a single, interactive webpage. The final outputs include a detailed NanoPlot HTML report and a unified MultiQC summary, providing a clear overview of the data quality before proceeding to downstream analysis. This workflow is tagged under **LG-WF**.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input file: long reads | data_input |  |
| 1 | Input file: Illumina reads R1 | data_input |  |
| 2 | Input file: Illumina reads R2 | data_input |  |


Ensure long reads should be provided in fastq.gz or fasta format, while Illumina R1 and R2 must be uploaded as paired-end fastq.gz files. Although individual datasets are supported, organizing Illumina reads into paired collections is recommended for more efficient batch processing and cleaner history management. Consult the `README.md` for comprehensive details on data formatting and specific tool parameters. You may also use `planemo workflow_job_init` to generate a `job.yml` for streamlined execution and automated input mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.28.2+galaxy1 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 5 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.9+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | NanoPlot on input dataset(s): HTML report | output_html |
| 6 | MultiQC on input dataset(s): Webpage | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Data_QC.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Data_QC.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Data_QC.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Data_QC.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Data_QC.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Data_QC.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)