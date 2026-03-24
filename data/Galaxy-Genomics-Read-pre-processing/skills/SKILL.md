---
name: covid-19-genomics-1-read-pre-processing-with-download
description: "This workflow downloads raw SARS-CoV-2 sequencing data from SRA using Illumina and ONT accessions and performs quality control and read filtering using tools like fastp, FastQC, and BWA-MEM. Use this skill when you need to retrieve public COVID-19 datasets and generate high-quality, filtered read sets for genomic surveillance or viral evolution studies."
homepage: https://workflowhub.eu/workflows/2
---

# COVID-19 - Genomics [1] Read pre-processing with download

## Overview

This Galaxy workflow automates the initial retrieval and quality control of raw SARS-CoV-2 sequencing data. It is designed to handle both Illumina (short-read) and ONT (long-read) accessions simultaneously. The process begins by downloading raw reads from the SRA using [fasterq-dump](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4+galaxy1), ensuring that the most current genomic data is available for downstream analysis.

For Illumina data, the workflow performs adapter trimming and quality filtering via [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1), followed by alignment with [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1). ONT reads are processed using [NanoPlot](https://toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.25.0+galaxy1) for visualization and [minimap2](https://toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17+galaxy0) for mapping. Both pipelines include rigorous filtering steps to remove low-quality alignments and non-specific sequences.

The workflow concludes by generating comprehensive quality reports using [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7) and [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1). These reports provide a consolidated view of the sequencing run metrics, allowing researchers to verify the integrity of the pre-processed reads before proceeding to variant calling or assembly. Final outputs include cleaned FASTQ files and merged BAM files ready for further genomic investigation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | List of Illumina accessions | data_input |  |
| 1 | List of ONT accessions | data_input |  |


Provide input accessions as simple text files containing one SRA identifier per line, ensuring they are organized into Galaxy data collections for efficient batch processing of both Illumina and ONT reads. The workflow is designed to handle these collections through automated download and quality control steps, so verify that your accession lists are correctly assigned to their respective input ports. For comprehensive guidance on specific tool parameters and data formatting, consult the `README.md` file. You may also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined job submission and input management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4+galaxy1 |  |
| 3 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4+galaxy1 |  |
| 4 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 5 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.25.0+galaxy1 |  |
| 6 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 7 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17+galaxy0 |  |
| 8 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 9 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 10 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 11 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 12 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 13 | MergeSamFiles | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MergeSamFiles/2.18.2.1 |  |
| 14 | MergeSamFiles | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MergeSamFiles/2.18.2.1 |  |
| 15 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 16 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | list_paired | list_paired |
| 3 | output_collection | output_collection |
| 4 | output_paired_coll | output_paired_coll |
| 5 | output_html | output_html |
| 8 | html_report | html_report |
| 10 | html_report | html_report |
| 15 | nonspecific | nonspecific |
| 16 | forward | forward |
| 16 | reverse | reverse |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Genomics-1-PreProcessing_with_download.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Genomics-1-PreProcessing_with_download.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Genomics-1-PreProcessing_with_download.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Genomics-1-PreProcessing_with_download.ga -o job.yml`
- Lint: `planemo workflow_lint Genomics-1-PreProcessing_with_download.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Genomics-1-PreProcessing_with_download.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
