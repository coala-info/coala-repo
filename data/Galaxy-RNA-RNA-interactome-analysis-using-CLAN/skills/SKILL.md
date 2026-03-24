---
name: rna-rna-interactome-analysis-using-clan
description: "This workflow performs RNA-RNA interactome analysis on FASTQ reads and reference sequences using the ChiRA tools suite and the CLAN aligner. Use this skill when you need to identify and quantify chimeric RNA-RNA interactions from high-throughput sequencing data to characterize post-transcriptional regulatory networks."
homepage: https://workflowhub.eu/workflows/67
---

# RNA-RNA interactome analysis using CLAN

## Overview

This Galaxy workflow facilitates the comprehensive analysis of RNA-RNA interactome data using the [ChiRA tools suite](https://usegalaxy.eu/training-material/topics/transcriptomics/tutorials/rna-interactome/tutorial.html). It is specifically designed to process chimeric reads to identify and quantify interactions between different RNA molecules, utilizing [CLAN](https://github.com/jsh58/clan) as the primary alignment tool.

The pipeline begins with raw sequence preprocessing, including adapter trimming via [Cutadapt](https://github.com/marcelm/cutadapt) and quality control assessments using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/). Following initial processing, [ChiRA collapse](https://chira.readthedocs.io/en/latest/) deduplicates reads to streamline downstream mapping. The workflow then maps these reads against provided reference and genomic FASTA files, merging overlapping segments to define distinct interaction loci.

In the final stages, the workflow quantifies the identified interactions and extracts detailed information on chimeric fragments. The results are output as BED files for mapped segments and tabular formats for interactions, with a [Query Tabular](https://galaxyproject.org/tutorials/rb_rnaseq/) step providing a SQLite database for flexible data exploration. This workflow is essential for researchers studying transcriptomics and complex RNA regulatory networks.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Reads FASTQ file | data_input |  |
| 1 | 1st reference FASTA file | data_input |  |
| 2 | 2nd reference FASTA file | data_input |  |
| 3 | Annotation GTF file | data_input |  |
| 4 | Genomic FASTA file | data_input |  |


Ensure your input FASTQ reads are adapter-trimmed and quality-checked, while providing reference sequences in FASTA format and genomic annotations in GTF format for accurate mapping with CLAN. Use individual datasets for the primary inputs, though large-scale analyses may benefit from organizing reads into collections before processing through the ChiRA tool suite. Refer to the README.md for comprehensive parameter descriptions and specific configuration requirements for each tool step. You can streamline the setup of your execution environment by using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.5 |  |
| 6 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 7 | ChiRA collapse | toolshed.g2.bx.psu.edu/repos/iuc/chira_collapse/chira_collapse/1.4.3+galaxy0 |  |
| 8 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 9 | ChiRA map | toolshed.g2.bx.psu.edu/repos/iuc/chira_map/chira_map/1.4.3+galaxy0 |  |
| 10 | ChiRA merge | toolshed.g2.bx.psu.edu/repos/iuc/chira_merge/chira_merge/1.4.3+galaxy0 |  |
| 11 | ChiRA qauntify | toolshed.g2.bx.psu.edu/repos/iuc/chira_quantify/chira_quantify/1.4.3+galaxy0 |  |
| 12 | ChiRA extract | toolshed.g2.bx.psu.edu/repos/iuc/chira_extract/chira_extract/1.4.3+galaxy0 |  |
| 13 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.0.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | out1 | out1 |
| 6 | html_file | html_file |
| 7 | out | out |
| 8 | html_file | html_file |
| 9 | mapped_bed | mapped_bed |
| 10 | segments_bed | segments_bed |
| 10 | merged_bed | merged_bed |
| 11 | loci | loci |
| 12 | chimeras | chimeras |
| 12 | interactions | interactions |
| 13 | sqlitedb | sqlitedb |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-RNA-RNA_interactome_analysis_using_CLAN.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-RNA-RNA_interactome_analysis_using_CLAN.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-RNA-RNA_interactome_analysis_using_CLAN.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-RNA-RNA_interactome_analysis_using_CLAN.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-RNA-RNA_interactome_analysis_using_CLAN.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-RNA-RNA_interactome_analysis_using_CLAN.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
