---
name: data-qc-upgraded
description: "This Galaxy workflow performs comprehensive quality control on long reads and paired-end Illumina sequencing data using NanoPlot, FastQC, and MultiQC to generate integrated reports. Use this skill when you need to evaluate the integrity and quality of hybrid sequencing datasets to ensure high-quality inputs for downstream genomic assembly or variant calling."
homepage: https://workflowhub.eu/workflows/1585
---

# Data QC - upgraded

## Overview

This workflow provides a comprehensive quality control pipeline for hybrid sequencing projects, supporting both long-read and short-read (Illumina) data. It processes three primary inputs: a long-read dataset and paired-end Illumina reads (R1 and R2), making it a robust solution for [GTN](https://training.galaxyproject.org/) training materials or standard genomic assembly preparation.

The pipeline utilizes [NanoPlot](https://github.com/wdecoster/NanoPlot) to generate statistical summaries and visualizations for the long-read data. Simultaneously, [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) performs independent quality assessments on both the forward and reverse Illumina reads to identify potential sequencing artifacts, adapter contamination, or library preparation issues.

To streamline the analysis, [MultiQC](https://multiqc.info/) aggregates the individual FastQC reports into a single, interactive webpage. The final outputs consist of the NanoPlot HTML report and the consolidated MultiQC summary, providing a centralized view of the data quality across all input types. This workflow is licensed under [GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.en.html).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input file: long reads | data_input |  |
| 1 | Input file: Illumina reads R1 | data_input |  |
| 2 | Input file: Illumina reads R2 | data_input |  |


Ensure all input files are in FASTQ format, ideally compressed as .fastq.gz to optimize storage and processing time. While the workflow is configured for individual datasets, using collections can streamline the management of multiple samples during large-scale quality control runs. Consult the `README.md` for comprehensive details on specific parameter configurations and data preparation requirements. For automated execution, you can use `planemo workflow_job_init` to generate a template `job.yml` file for your inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.42.0+galaxy1 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 5 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | NanoPlot on input dataset(s): HTML report | output_html |
| 6 | MultiQC on input dataset(s): Webpage | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-data-qc.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-data-qc.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-data-qc.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-data-qc.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-data-qc.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-data-qc.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
