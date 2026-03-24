---
name: nanopore-preprocessing
description: "This workflow performs quality control, adapter trimming, and host contamination removal for Nanopore microbiome sequencing data using tools like Porechop, fastp, minimap2, and Kraken2. Use this skill when you need to filter host DNA and discard low-quality reads from long-read sequencing samples to prepare clean pathogen or environmental sequences for downstream taxonomic analysis."
homepage: https://workflowhub.eu/workflows/1061
---

# Nanopore Preprocessing

## Overview

This Nanopore Preprocessing workflow is designed for the initial quality control and cleaning of long-read sequencing data, specifically tailored for microbiome and pathogen detection. It begins by assessing raw data quality using [NanoPlot](https://github.com/wdecoster/NanoPlot) and [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/), followed by adapter trimming with [Porechop](https://github.com/rrwick/Porechop) to ensure high-quality base content for downstream analysis.

A critical component of this workflow is the removal of host-derived sequences to isolate pathogen DNA. Using [minimap2](https://github.com/lh3/minimap2), reads are mapped against a provided host reference genome; subsequent steps split the data to retain only non-host sequences. This process reduces computational overhead and prevents host contamination from biasing further taxonomic or assembly tasks.

The workflow further refines the dataset using [Kraken2](https://github.com/DerrickWood/kraken2) for taxonomic classification and [fastp](https://github.com/OpenGene/fastp) for additional filtering. It generates comprehensive reports via [MultiQC](https://multiqc.info/), providing users with detailed statistics on read counts, host percentages, and quality metrics before and after preprocessing. 

This workflow is a core component of the microGalaxy and PathoGFAIR initiatives. For step-by-step instructions and practical examples, users can refer to this [GTN tutorial](https://training.galaxyproject.org/training-material/topics/microbiome/tutorials/pathogen-detection-from-nanopore-foodborne-data/tutorial.html).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | samples_profile | parameter_input | based on the lab preparation of the samples during sequencing, there should be a sample profile better than the other, to be chosen as an optional input to Minimap2. e.g. PacBio/Oxford Nanpore  For more details check: https://github.com/lh3/minimap2?tab=readme-ov-file#use-cases |
| 1 | host_reference_genome | parameter_input | Where the samples are coming from, Human, Chicken, Cow, etc. |
| 2 | collection_of_all_samples | data_collection_input | Nanopore reads of each sample are all in a single fastq or fastq.gz file |


To prepare your data, ensure all Nanopore reads are organized into a list of datasets collection using the `fastqsanger` or `fastqsanger.gz` format. You must also provide a host reference genome in FASTA format and a samples profile parameter to correctly drive the filtering and mapping steps. For comprehensive guidance on formatting these inputs and configuring the workflow parameters, please refer to the `README.md`. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Porechop | toolshed.g2.bx.psu.edu/repos/iuc/porechop/porechop/0.2.4+galaxy0 | Preprocessing (Trimming) |
| 4 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.42.0+galaxy1 | Quality Check Before Preprocessing |
| 5 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 | Quality Check Before Preprocessing |
| 6 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.4+galaxy0 | Preprocessing |
| 7 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 | Quality Control Before and After Preprocessing |
| 8 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.28+galaxy0 |  |
| 9 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.42.0+galaxy1 | Nanoplot Quality Check After Preprocessing |
| 10 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 | Quality Check After Preprocessing |
| 11 | Split BAM by reads mapping status | toolshed.g2.bx.psu.edu/repos/iuc/bamtools_split_mapped/bamtools_split_mapped/2.5.2+galaxy2 |  |
| 12 | Select | Grep1 |  |
| 13 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.15.1+galaxy2 |  |
| 14 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.15.1+galaxy2 |  |
| 15 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 16 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 17 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy1 |  |
| 18 | Cut | Cut1 |  |
| 19 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 20 | Krakentools: Extract Kraken Reads By ID | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_extract_kraken_reads/krakentools_extract_kraken_reads/1.2+galaxy1 |  |
| 21 | Select | Grep1 |  |
| 22 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 23 | Cut | Cut1 |  |
| 24 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 25 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 26 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 27 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 | Quality Control Before and After Preprocessing |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | porechop_output_trimmed_reads | outfile |
| 4 | nanoplot_qc_on_reads_before_preprocessing_html_report | output_html |
| 4 | nanoplot_qc_on_reads_before_preprocessing_nanostats | nanostats |
| 4 | nanoplot_on_reads_before_preprocessing_nanostats_post_filtering | nanostats_post_filtering |
| 5 | fastqc_quality_check_before_preprocessing_html_file | html_file |
| 5 | fastqc_quality_check_before_preprocessing_text_file | text_file |
| 6 | nanopore_sequenced_reads_processed_with_fastp_after_host_removal_html_report | report_html |
| 6 | nanopore_sequenced_reads_processed_with_fastp_after_host_removal | out1 |
| 7 | multiQC_html_report_before_preprocessing | html_report |
| 7 | multiQC_stats_before_preprocessing | stats |
| 8 | bam_map_to_host | alignment_output |
| 9 | nanoplot_qc_on_reads_after_preprocessing_html_report | output_html |
| 9 | nanoplot_qc_on_reads_after_preprocessing_nanostats | nanostats |
| 9 | nanoplot_on_reads_after_preprocessing_nanostats_post_filtering | nanostats_post_filtering |
| 10 | fastqc_quality_check_after_preprocessing_text_file | text_file |
| 10 | fastqc_quality_check_after_preprocessing_html_file | html_file |
| 11 | host_sequences_bam | mapped |
| 11 | non_host_sequences_bam | unmapped |
| 12 | total_sequences_before_hosts_sequences_removal | out_file1 |
| 13 | host_sequences_fastq | output |
| 14 | non_host_sequences_fastq | output |
| 17 | kraken2_with_kalamri_database_output | output |
| 17 | kraken2_with_kalamri_database_report | report_output |
| 18 | quality_retained_all_reads | out_file1 |
| 19 | hosts_qc_html | html_file |
| 19 | hosts_qc_text_file | text_file |
| 20 | collection_of_preprocessed_samples | output_1 |
| 21 | total_sequences_after_hosts_sequences_removal | out_file1 |
| 23 | quality_retained_hosts_reads | out_file1 |
| 26 | removed_hosts_percentage_tabular | out_file1 |
| 27 | multiQC_stats_after_preprocessing | stats |
| 27 | multiQC_html_report_after_preprocessing | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Nanopore-Pre-Processing.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Nanopore-Pre-Processing.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Nanopore-Pre-Processing.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Nanopore-Pre-Processing.ga -o job.yml`
- Lint: `planemo workflow_lint Nanopore-Pre-Processing.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Nanopore-Pre-Processing.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
