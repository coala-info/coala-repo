---
name: qc-and-trimming-of-rnaseq-reads-tsi
description: This RNA-seq workflow processes paired-end read collections through quality control and adapter trimming using FastQC, Trimmomatic, and MultiQC before concatenating the results into merged R1 and R2 files. Use this skill when you need to assess raw sequence quality, remove low-quality bases and TruSeq3 adapters, and prepare clean, consolidated datasets for downstream transcriptomic analysis.
homepage: https://www.biocommons.org.au/
metadata:
  docker_image: "N/A"
---

# qc-and-trimming-of-rnaseq-reads-tsi

## Overview

This Galaxy workflow performs quality control and adapter trimming for paired-end RNA-seq data. It processes collections of R1 and R2 files, typically grouped by tissue type, using [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0) to assess raw read quality. The results are aggregated into a [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1) report to provide a comprehensive overview of the initial data state.

Trimming is handled by [Trimmomatic](https://toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.36.6), configured with an initial ILLUMINACLIP step for TruSeq3 adapters and specific sliding window and length filters (SLIDINGWINDOW:4:5, LEADING:5, TRAILING:5, MINLEN:25). Only paired reads are retained. Following trimming, a second round of FastQC and MultiQC is performed to verify quality improvements. The workflow then concatenates the processed datasets into two final outputs: a merged trimmed R1 file and a merged trimmed R2 file.

The workflow generates several diagnostic outputs, including a MultiQC table formatted to show the percentage of reads retained after trimming. Users should note a known display issue where some MultiQC plots may be labeled as "R1" despite containing data from both read sets. Additionally, if the workflow report text resets to default, it can be restored by copying the report configuration from an earlier version of the workflow.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Paired end RNAseq collection - R1 | data_collection_input |  |
| 1 | Paired end RNAseq collection - R2 | data_collection_input |  |


Ensure your input RNA-seq data are organized into two separate list collections for R1 and R2 fastq.gz files, specifically grouped by a single tissue type per run. While Trimmomatic is pre-configured for TruSeq3 adapters and specific quality thresholds, you can adjust these parameters at runtime to suit your specific library preparation. For automated testing or command-line execution, you can generate a template for your input parameters using `planemo workflow_job_init`. Be aware that MultiQC plots may mislabel combined R1/R2 data as "R1" due to upstream log formatting, so verify your sample counts in the final report. Refer to the README.md for comprehensive details on restoring workflow report text and interpreting the percentage of retained reads.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 3 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 4 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.36.6 |  |
| 5 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 7 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |
| 8 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |
| 9 | Extract dataset | __EXTRACT_DATASET__ |  |
| 10 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 11 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 12 | Cut | Cut1 |  |
| 13 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 14 | Remove beginning | Remove beginning1 |  |
| 15 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | R1_html_file | html_file |
| 2 | R1_text_file | text_file |
| 3 | R2_html_file | html_file |
| 3 | R2_text_file | text_file |
| 4 | fastq_out_r2_unpaired | fastq_out_r2_unpaired |
| 4 | err_file | err_file |
| 4 | fastq_out_r2_paired | fastq_out_r2_paired |
| 4 | fastq_out_r1_unpaired | fastq_out_r1_unpaired |
| 4 | fastq_out_r1_paired | fastq_out_r1_paired |
| 5 | multiqc_raw_reads_html_report | html_report |
| 5 | raw_reads_stats | stats |
| 6 | after trimming stats | stats |
| 6 | multiqc_of_trimmomatic_logs_html_report | html_report |
| 7 | Merged trimmed R1 files | out_file1 |
| 8 | Merged trimmed R2 files | out_file1 |
| 10 | html_file | html_file |
| 10 | text_file | text_file |
| 11 | html_file | html_file |
| 11 | text_file | text_file |
| 13 | trimmed_stats | stats |
| 13 | multiqc_trimmed_html_report | html_report |
| 15 | Percentage of reads kept after Trimmomatic | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-QC-and-trimming-RNAseq-TSI.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-QC-and-trimming-RNAseq-TSI.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-QC-and-trimming-RNAseq-TSI.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-QC-and-trimming-RNAseq-TSI.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-QC-and-trimming-RNAseq-TSI.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-QC-and-trimming-RNAseq-TSI.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)