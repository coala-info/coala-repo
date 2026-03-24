---
name: mgnifys-amplicon-pipeline-v50-quality-control-se
description: "This metagenomics workflow processes single-end amplicon reads through a quality control pipeline using FastQC, Trimmomatic, PRINSEQ, and MultiQC to generate cleaned FASTA sequences and summary reports. Use this skill when you need to remove adapter sequences, trim low-quality bases, and filter out short or ambiguous reads from single-end environmental sequencing datasets to ensure high-quality input for taxonomic classification."
homepage: https://workflowhub.eu/workflows/1850
---

# MGnify's amplicon pipeline v5.0 - Quality control SE

## Overview

This Galaxy workflow is a specialized subworkflow of the MGnify amplicon pipeline v5.0, designed specifically for the quality control (QC) of single-end metagenomics reads. It provides a standardized approach to cleaning raw sequencing data, ensuring that only high-quality sequences proceed to downstream taxonomic classification or ASV/OTU picking.

The process begins with initial quality assessment using [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1), followed by rigorous trimming and filtering. [Trimmomatic](https://toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.39+galaxy2) is employed to remove low-quality bases via sliding window averages and to enforce minimum length requirements. Further refinement is performed using [PRINSEQ](https://toolshed.g2.bx.psu.edu/repos/iuc/prinseq/prinseq/0.20.4+galaxy2) and [Filter FASTQ](https://toolshed.g2.bx.psu.edu/repos/devteam/fastq_filter/fastq_filter/1.1.5+galaxy2) to filter out sequences based on ambiguity (N) thresholds and specific length constraints.

Throughout the pipeline, multiple FastQC checkpoints monitor the data's progression, culminating in a final [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3) report that aggregates statistics across all processing steps. The primary outputs are cleaned, formatted FASTA files and comprehensive quality reports, providing a transparent overview of the read filtering performance under the Apache-2.0 license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Single-end reads | data_collection_input | Single-end reads collection. |
| 1 | Trimmomatic - SLIDING WINDOW - Average quality required | parameter_input | Average quality required. |
| 2 | Trimmomatic - LEADING | parameter_input | Cut bases off the start of a read, if below a threshold quality. |
| 3 | Trimmomatic - SLIDING WINDOW - Number of bases to average across | parameter_input | Number of bases to average across. |
| 4 | Trimmomatic - TRAILING | parameter_input | Cut bases off the end of a read, if below a threshold quality. |
| 5 | Trimmomatic - MINLEN | parameter_input | Minimum length of reads to be kept. |
| 6 | Length filtering - Minimum size | parameter_input | Minimum sequence length. |
| 7 | Ambiguity filtering - Maximal N percentage threshold to conserve sequences | parameter_input | Maximal N percentage threshold to conserve sequences. |


Ensure your input single-end reads are in fastqsanger or fastqsanger.gz format and organized into a data collection to enable efficient batch processing through the Trimmomatic and PRINSEQ steps. While default parameters for sliding windows and length filtering are provided, you should adjust these based on your specific sequencing quality profiles. Refer to the README.md for comprehensive details on parameter thresholds and expected output statistics. For automated execution and testing, you can initialize a job configuration using `planemo workflow_job_init`. Always verify that your sequence identifiers are consistent, as the workflow includes several text replacement steps to maintain compatibility across the pipeline.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 8 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 9 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.39+galaxy2 |  |
| 10 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy0 |  |
| 11 | Filter FASTQ | toolshed.g2.bx.psu.edu/repos/devteam/fastq_filter/fastq_filter/1.1.5+galaxy2 |  |
| 12 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 13 | PRINSEQ | toolshed.g2.bx.psu.edu/repos/iuc/prinseq/prinseq/0.20.4+galaxy2 |  |
| 14 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 15 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy0 |  |
| 16 | FASTQ to FASTA | toolshed.g2.bx.psu.edu/repos/devteam/fastqtofasta/fastq_to_fasta_python/1.1.5+galaxy2 |  |
| 17 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 18 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy0 |  |
| 19 | FASTA Width | toolshed.g2.bx.psu.edu/repos/devteam/fasta_formatter/cshl_fasta_formatter/1.0.1+galaxy2 |  |
| 20 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy0 |  |
| 21 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 19 | Single-end post quality control FASTA files | output |
| 21 | Single-end MultiQC report | html_report |
| 21 | Single-end MultiQC statistics | stats |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run mgnify-amplicon-pipeline-v5-quality-control-single-end.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run mgnify-amplicon-pipeline-v5-quality-control-single-end.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run mgnify-amplicon-pipeline-v5-quality-control-single-end.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init mgnify-amplicon-pipeline-v5-quality-control-single-end.ga -o job.yml`
- Lint: `planemo workflow_lint mgnify-amplicon-pipeline-v5-quality-control-single-end.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `mgnify-amplicon-pipeline-v5-quality-control-single-end.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
