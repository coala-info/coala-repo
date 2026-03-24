---
name: bam-to-fastq-qc-v10
description: "This Galaxy workflow converts BAM files into FASTQ format using Picard SamToFastq while simultaneously performing quality control and alignment statistics with Samtools flagstat and FastQC. Use this skill when you need to extract raw sequencing reads from an existing BAM file to assess library quality or prepare data for de novo genome assembly pipelines."
homepage: https://workflowhub.eu/workflows/220
---

# BAM to FASTQ + QC v1.0

## Overview

This workflow provides a streamlined pipeline for converting alignment data from BAM format back into raw sequence reads (FASTQ) while simultaneously performing essential quality assessments. It is designed to handle a single BAM input, making it an ideal preprocessing step for downstream applications such as [genome assembly with hifiasm](https://australianbiocommons.github.io/how-to-guides/genome_assembly/hifi_assembly).

The process utilizes [SamToFastq](https://broadinstitute.github.io/picard/command-line-overview.html#SamToFastq) from the Picard suite to extract sequence reads and [Samtools flagstat](http://www.htslib.org/doc/samtools-flagstat.html) to generate a statistical summary of the original BAM file. These tools ensure that mapping information is documented and read pairs are correctly formatted for subsequent analysis.

To ensure data integrity, the workflow automatically runs [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) on the resulting FASTQ files. This generates comprehensive reports on sequence quality, GC content, and potential adapter contamination. The final outputs include the converted FASTQ reads, the BAM flagstat report, and FastQC results in both HTML and text formats.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input BAM | data_input |  |


Ensure the primary input is a valid BAM file, which can be uploaded as a single dataset or organized into a dataset collection for efficient batch processing. It is important to verify that the file is not corrupted before starting the conversion and QC steps. Please refer to the README.md for comprehensive details on data preparation and specific configuration requirements. For users looking to automate execution, `planemo workflow_job_init` can be used to generate a `job.yml` file for defining workflow parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | SamToFastq | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_SamToFastq/2.18.2.2 |  |
| 2 | Samtools flagstat | toolshed.g2.bx.psu.edu/repos/devteam/samtools_flagstat/samtools_flagstat/2.0.3 |  |
| 3 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Converted FastQ reads | fq_single |
| 2 | BAM file information | output1 |
| 3 | FastQC HTML | html_file |
| 3 | FastQC text file | text_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-BAM_to_FASTQ___QC_v1.0.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-BAM_to_FASTQ___QC_v1.0.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-BAM_to_FASTQ___QC_v1.0.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-BAM_to_FASTQ___QC_v1.0.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-BAM_to_FASTQ___QC_v1.0.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-BAM_to_FASTQ___QC_v1.0.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
