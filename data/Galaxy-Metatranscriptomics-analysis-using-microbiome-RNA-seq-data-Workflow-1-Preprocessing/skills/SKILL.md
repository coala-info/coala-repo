---
name: metatranscriptomics-analysis-using-microbiome-rna-seq-data-w
description: This metatranscriptomics workflow processes raw paired-end microbiome RNA-seq reads using FastQC, Cutadapt, and SortMeRNA to perform quality control, adapter trimming, and ribosomal RNA depletion. Use this skill when you need to clean raw environmental or clinical sequencing data by removing sequencing adapters and contaminating rRNA sequences to prepare for downstream functional profiling.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# metatranscriptomics-analysis-using-microbiome-rna-seq-data-w

## Overview

This workflow represents the initial stage of a metatranscriptomics pipeline designed for microbiome RNA-seq data. It focuses on the essential preprocessing of raw paired-end reads to ensure high-quality input for subsequent taxonomic and functional analysis. By automating the cleaning and filtering steps, the workflow prepares the data for more complex downstream tasks like assembly or mapping.

The process begins with quality assessment using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and [MultiQC](https://multiqc.info/), followed by adapter trimming and quality filtering via [Cutadapt](https://cutadapt.readthedocs.io/). A critical component of this workflow is the removal of ribosomal RNA (rRNA) sequences using [SortMeRNA](https://github.com/biocore/sortmerna), which is necessary to enrich the dataset for messenger RNA (mRNA) before further analysis.

The final outputs include comprehensive quality reports and cleaned, non-rRNA forward and reverse reads. This workflow is based on [GTN](https://training.galaxyproject.org/) training materials for microbiome analysis and is released under the [MIT License](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Reverse raw reads | data_input | Metatranscriptomics reverse raw reads |
| 1 | Forward raw reads | data_input | Metatranscriptomics forward raw reads |


Ensure your raw reads are in fastq or fastq.gz format, typically provided as paired-end datasets for this microbiome preprocessing pipeline. While individual files are supported, organizing your data into paired-end collections is recommended to streamline the execution of tools like Cutadapt and SortMeRNA across multiple samples. Refer to the accompanying README.md for comprehensive details on specific parameter configurations and required rRNA databases. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated job submission and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 3 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 4 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/5.0+galaxy0 |  |
| 5 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |
| 6 | Filter with SortMeRNA | toolshed.g2.bx.psu.edu/repos/rnateam/sortmerna/bg_sortmerna/4.3.6+galaxy0 |  |
| 7 | FASTQ interlacer | toolshed.g2.bx.psu.edu/repos/devteam/fastq_paired_end_interlacer/fastq_paired_end_interlacer/1.2.0.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | fastqc_reverse_html_file | html_file |
| 3 | fastqc_forward_html_file | html_file |
| 4 | cutadapt_report | report |
| 5 | multiqc_html_report | html_report |
| 6 | sortmerna_unaligned_reverse | unaligned_reverse |
| 6 | sortmerna_unaligned_forward | unaligned_forward |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow1-preprocessing.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow1-preprocessing.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow1-preprocessing.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow1-preprocessing.ga -o job.yml`
- Lint: `planemo workflow_lint workflow1-preprocessing.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow1-preprocessing.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)