---
name: covid-19-genomics-1-read-pre-processing-without-downloading
description: "This SARS-CoV-2 genomics workflow processes Illumina paired-end and Oxford Nanopore sequencing data using tools such as fastp, FastQC, BWA-MEM, and minimap2 to perform quality control and read filtering. Use this skill when you need to clean raw viral sequencing reads and remove low-quality data to prepare high-quality inputs for downstream COVID-19 genomic analysis."
homepage: https://workflowhub.eu/workflows/4
---

# COVID-19 - Genomics [1] Read pre-processing without downloading from SRA

## Overview

This workflow is designed for the initial preprocessing of raw SARS-CoV-2 genomic data, supporting both Illumina paired-end and Oxford Nanopore Technologies (ONT) single-end read collections. It provides a standardized pipeline to prepare sequencing data for downstream analysis, focusing on quality control and filtering of raw reads.

The pipeline begins with comprehensive quality assessment and trimming. It utilizes [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.3.3) for Illumina data and [NanoPlot](https://toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.28.2+galaxy1) for ONT data to handle adapter trimming and low-quality base removal. Visual quality reports are generated via [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72) and aggregated using [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7) to ensure data integrity.

Following initial QC, reads are aligned to a reference genome using [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1) for short reads and [minimap2](https://toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.12) for long reads. The workflow then applies [samtool_filter2](https://toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8) to refine the alignments and [Picard MergeSamFiles](https://toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MergeSamFiles/2.18.2.1) to consolidate the processed data.

In the final stage, the filtered alignments are converted back into standardized fastq formats using [samtools fastx](https://toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1). This produces cleaned, pre-processed read sets ready for assembly or variant calling, along with detailed HTML reports summarizing the preprocessing statistics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Illumina Paired end collection | data_collection_input |  |
| 1 | ONT single end collection | data_collection_input |  |


Ensure your input data is organized into paired-end (Illumina) or single-end (ONT) list collections containing fastq or fastq.gz files to enable efficient batch processing through fastp and minimap2. If you are starting from SRA accessions, use the Faster Download and Dump tool to populate these collections directly within Galaxy. Refer to the README.md for comprehensive instructions on parameter settings and quality control thresholds. You can automate the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.3.3 |  |
| 3 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.28.2+galaxy1 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72 |  |
| 5 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.12 |  |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 7 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 8 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 9 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8 |  |
| 10 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8 |  |
| 11 | MergeSamFiles | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MergeSamFiles/2.18.2.1 |  |
| 12 | MergeSamFiles | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MergeSamFiles/2.18.2.1 |  |
| 13 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 14 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | report_json | report_json |
| 2 | output_paired_coll | output_paired_coll |
| 2 | report_html | report_html |
| 6 | html_report | html_report |
| 7 | bam_output | bam_output |
| 8 | html_report | html_report |
| 13 | nonspecific | nonspecific |
| 14 | forward | forward |
| 14 | reverse | reverse |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Genomics-1-PreProcessing_without_downloading_from_SRA.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Genomics-1-PreProcessing_without_downloading_from_SRA.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Genomics-1-PreProcessing_without_downloading_from_SRA.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Genomics-1-PreProcessing_without_downloading_from_SRA.ga -o job.yml`
- Lint: `planemo workflow_lint Genomics-1-PreProcessing_without_downloading_from_SRA.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Genomics-1-PreProcessing_without_downloading_from_SRA.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
