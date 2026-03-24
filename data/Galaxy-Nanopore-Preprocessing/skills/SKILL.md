---
name: nanopore-preprocessing
description: "This microbiome workflow processes Nanopore sequencing collections through adapter trimming, quality control, host sequence removal, and taxonomic classification using tools like Porechop, minimap2, Kraken2, and fastp. Use this skill when you need to clean raw long-read sequencing data by removing host contamination and assessing microbial composition for downstream pathogen identification or metagenomic analysis."
homepage: https://workflowhub.eu/workflows/1492
---

# Nanopore Preprocessing

## Overview

This workflow provides a comprehensive pipeline for the quality control and contamination filtering of Nanopore sequencing data, specifically designed for microbiome research. It begins by trimming adapters using [Porechop](https://github.com/rrwick/Porechop) and performing initial quality assessments with [NanoPlot](https://github.com/wdecoster/NanoPlot), [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/), and [MultiQC](https://multiqc.info/). These steps ensure that raw reads are properly processed and evaluated before further analysis.

A central feature of the pipeline is the removal of host contamination. Reads are mapped to a reference genome using [minimap2](https://github.com/lh3/minimap2), and the resulting alignments are split to isolate non-host sequences. The workflow further refines the data using [Kraken2](https://ccb.jhu.edu/software/kraken2/) for taxonomic classification and [Krakentools](https://github.com/jenniferlu717/KrakenTools) to extract specific reads, ensuring the final dataset is free from unwanted genetic material.

The workflow concludes with a secondary round of quality control and detailed reporting. It generates comparative statistics, including the percentage of host reads removed and total sequence counts at various stages. Final outputs include cleaned FASTQ files, comprehensive [MultiQC](https://multiqc.info/) reports, and taxonomic summaries. This tool is maintained under the [MIT license](https://opensource.org/licenses/MIT) and aligns with [GTN](https://training.galaxyproject.org/) best practices for pathogfair and microgalaxy research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | samples_profile | parameter_input | based on the lab preparation of the samples during sequencing, there should be a sample profile better than the other, to be chosen as an optional input to Minimap2. e.g. PacBio/Oxford Nanpore  For more details check: https://github.com/lh3/minimap2?tab=readme-ov-file#use-cases |
| 1 | collection_of_all_samples | data_collection_input | Nanopore reads of each sample are all in a single fastq or fastq.gz file |


For this workflow, ensure your Nanopore sequencing data is organized into a list of datasets (collection) containing fastq or fastq.gz files to enable batch processing. You must also provide a samples profile as a parameter input to correctly map metadata during the QC and filtering stages. Refer to the README.md for comprehensive details on configuring the host removal and Kraken2 database parameters. For automated execution, you can initialize your environment using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Porechop | toolshed.g2.bx.psu.edu/repos/iuc/porechop/porechop/0.2.4+galaxy0 | Preprocessing (Trimming) |
| 3 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.42.0+galaxy1 | Quality Check Before Preprocessing |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 | Quality Check Before Preprocessing |
| 5 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.4+galaxy0 | Preprocessing |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 | Quality Control Before and After Preprocessing |
| 7 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.28+galaxy0 |  |
| 8 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.42.0+galaxy1 | Nanoplot Quality Check After Preprocessing |
| 9 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 | Quality Check After Preprocessing |
| 10 | Split BAM by reads mapping status | toolshed.g2.bx.psu.edu/repos/iuc/bamtools_split_mapped/bamtools_split_mapped/2.5.2+galaxy2 |  |
| 11 | Select | Grep1 |  |
| 12 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.15.1+galaxy2 |  |
| 13 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.15.1+galaxy2 |  |
| 14 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 15 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 16 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy1 |  |
| 17 | Cut | Cut1 |  |
| 18 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 19 | Krakentools: Extract Kraken Reads By ID | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_extract_kraken_reads/krakentools_extract_kraken_reads/1.2+galaxy1 |  |
| 20 | Select | Grep1 |  |
| 21 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 22 | Cut | Cut1 |  |
| 23 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 24 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 25 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 26 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 | Quality Control Before and After Preprocessing |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | porechop_output_trimmed_reads | outfile |
| 3 | nanoplot_on_reads_before_preprocessing_nanostats_post_filtering | nanostats_post_filtering |
| 3 | nanoplot_qc_on_reads_before_preprocessing_html_report | output_html |
| 3 | nanoplot_qc_on_reads_before_preprocessing_nanostats | nanostats |
| 4 | fastqc_quality_check_before_preprocessing_text_file | text_file |
| 4 | fastqc_quality_check_before_preprocessing_html_file | html_file |
| 5 | nanopore_sequenced_reads_processed_with_fastp_after_host_removal_html_report | report_html |
| 5 | nanopore_sequenced_reads_processed_with_fastp_after_host_removal | out1 |
| 6 | multiQC_stats_before_preprocessing | stats |
| 6 | multiQC_html_report_before_preprocessing | html_report |
| 7 | bam_map_to_host | alignment_output |
| 8 | nanoplot_qc_on_reads_after_preprocessing_html_report | output_html |
| 8 | nanoplot_on_reads_after_preprocessing_nanostats_post_filtering | nanostats_post_filtering |
| 8 | nanoplot_qc_on_reads_after_preprocessing_nanostats | nanostats |
| 9 | fastqc_quality_check_after_preprocessing_html_file | html_file |
| 9 | fastqc_quality_check_after_preprocessing_text_file | text_file |
| 10 | host_sequences_bam | mapped |
| 10 | non_host_sequences_bam | unmapped |
| 11 | total_sequences_before_hosts_sequences_removal | out_file1 |
| 12 | host_sequences_fastq | output |
| 13 | non_host_sequences_fastq | output |
| 16 | kraken2_with_kalamri_database_output | output |
| 16 | kraken2_with_kalamri_database_report | report_output |
| 17 | quality_retained_all_reads | out_file1 |
| 18 | hosts_qc_html | html_file |
| 18 | hosts_qc_text_file | text_file |
| 19 | collection_of_preprocessed_samples | output_1 |
| 20 | total_sequences_after_hosts_sequences_removal | out_file1 |
| 22 | quality_retained_hosts_reads | out_file1 |
| 25 | removed_hosts_percentage_tabular | out_file1 |
| 26 | multiQC_html_report_after_preprocessing | html_report |
| 26 | multiQC_stats_after_preprocessing | stats |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run nanopore-preprocessing.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run nanopore-preprocessing.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run nanopore-preprocessing.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init nanopore-preprocessing.ga -o job.yml`
- Lint: `planemo workflow_lint nanopore-preprocessing.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `nanopore-preprocessing.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
