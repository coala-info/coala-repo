---
name: rna-rna-interactome-analysis-using-bwa-mem
description: This transcriptomics workflow performs RNA-RNA interactome analysis by processing FASTQ reads against reference and genomic FASTA files using Cutadapt, BWA-MEM, and the ChiRA tool suite. Use this skill when you need to identify and quantify chimeric RNA-RNA interactions from high-throughput sequencing data to characterize complex regulatory networks between different RNA species.
homepage: https://usegalaxy.eu
metadata:
  docker_image: "N/A"
---

# rna-rna-interactome-analysis-using-bwa-mem

## Overview

This Galaxy workflow provides a comprehensive pipeline for RNA-RNA interactome analysis, specifically designed to identify and characterize chimeric reads from high-throughput sequencing data. Utilizing the [ChiRA tools suite](https://toolshed.g2.bx.psu.edu/view/iuc/chira_extract/), the process begins with raw FASTQ reads, performing adapter trimming via [Cutadapt](https://toolshed.g2.bx.psu.edu/view/lparsons/cutadapt/) and quality control with [FastQC](https://toolshed.g2.bx.psu.edu/view/devteam/fastqc/).

The core analysis involves collapsing duplicate reads and mapping them against multiple reference sources using the BWA-MEM algorithm. The workflow integrates genomic FASTA files, specific reference sequences, and GTF annotations to accurately localize interaction sites. Following alignment, the pipeline merges overlapping segments, quantifies expression levels at specific loci, and extracts detailed information on chimeric fragments and their corresponding RNA-RNA interactions.

The final outputs include BED files of mapped segments, quantified loci, and structured tables of identified interactions. A SQLite database is also generated via [Query Tabular](https://toolshed.g2.bx.psu.edu/view/iuc/query_tabular/) to facilitate downstream data exploration and filtering. This workflow is particularly useful for researchers studying transcriptomics and complex RNA regulatory networks.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Reads FASTQ file | data_input |  |
| 1 | 1st reference FASTA file | data_input |  |
| 2 | 2nd reference FASTA file | data_input |  |
| 3 | Annotation GTF file | data_input |  |
| 4 | Genomic FASTA file | data_input |  |


Ensure your input FASTQ reads are quality-trimmed and that reference files are provided in standard FASTA and GTF formats for accurate mapping with BWA-MEM and ChiRA. While this workflow typically processes individual datasets, you can use dataset collections to manage multiple samples efficiently. Refer to the `README.md` for comprehensive details on parameter settings and specific reference genome requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

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
planemo run Galaxy-Workflow-RNA-RNA_interactome_analysis_using_BWA-MEM.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-RNA-RNA_interactome_analysis_using_BWA-MEM.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-RNA-RNA_interactome_analysis_using_BWA-MEM.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-RNA-RNA_interactome_analysis_using_BWA-MEM.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-RNA-RNA_interactome_analysis_using_BWA-MEM.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-RNA-RNA_interactome_analysis_using_BWA-MEM.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)