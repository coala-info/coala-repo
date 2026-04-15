---
name: qc-of-radseq-reads
description: This RAD-seq workflow processes demultiplexed FASTQ reads and adapter sequences using FastQC, Cutadapt, fastp, and MultiQC to perform comprehensive quality control and trimming. Use this skill when you need to assess raw read quality, remove sequencing adapters, and filter low-quality sequences from RAD-seq datasets before proceeding with downstream population genomic analysis.
homepage: https://usegalaxy.org.au/
metadata:
  docker_image: "N/A"
---

# qc-of-radseq-reads

## Overview

This Galaxy workflow provides a comprehensive quality control (QC) pipeline for demultiplexed RAD-seq data in FASTQ format. It is designed to prepare raw reads for downstream analysis with [Stacks](http://catchenlab.life.illinois.edu/stacks/) by performing initial assessment, adapter removal, and advanced filtering.

The process begins by running [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0) to generate baseline statistics, followed by [Cutadapt](https://toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/4.0+galaxy0) to trim user-specified adapter sequences. The workflow then utilizes [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0) for additional automated filtering and trimming to ensure high-quality input for subsequent genomic assembly or variant calling.

To facilitate easy interpretation of results, the workflow integrates [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy0) at multiple stages. These reports summarize the data quality before and after each processing step, allowing users to verify the effectiveness of the adapter clipping and read filtering. The final output consists of cleaned reads ready for the Stacks environment.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Demultiplexed reads | data_collection_input |  |


Ensure your demultiplexed RADseq reads are uploaded as a paired-end or single-end data collection in FASTQ format to maintain sample organization throughout the QC process. You must also provide two adapter sequences in FASTA format for the Cutadapt step to effectively trim library-specific contaminants. Using collections rather than individual datasets is essential for the MultiQC tools to correctly aggregate statistics into the three distinct reporting stages. For comprehensive parameter settings and adapter configuration details, refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 2 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/4.0+galaxy0 | Remove adapters from reads. Supply two adapter.fasta files (ask sequencing provider for adapter seqs). Default settings on except max error rate changed to 0.2, and min read length set to 70 |
| 3 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy0 |  |
| 4 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy0 |  |
| 5 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0 | Additional filtering and trimming options. All defaults are on. |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | FastQC on input dataset(s): Webpage | html_file |
| 1 | FastQC on input dataset(s): RawData | text_file |
| 2 | Cutadapt on input dataset(s): Read 1 Output | out1 |
| 2 | report | report |
| 3 | MultiQC on input dataset(s): Webpage | html_report |
| 3 | MultiQC on input dataset(s): Stats | stats |
| 4 | html_report | html_report |
| 4 | stats | stats |
| 5 | fastp on input dataset(s): Read 1 output | out1 |
| 5 | fastp on input dataset(s): HTML report | report_html |
| 5 | report_json | report_json |
| 6 | stats | stats |
| 6 | html_report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-QC_of_RADseq_reads.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-QC_of_RADseq_reads.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-QC_of_RADseq_reads.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-QC_of_RADseq_reads.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-QC_of_RADseq_reads.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-QC_of_RADseq_reads.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)