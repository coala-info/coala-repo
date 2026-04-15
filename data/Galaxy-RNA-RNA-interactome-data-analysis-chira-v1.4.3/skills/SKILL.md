---
name: rna-rna-interactome-data-analysis-chira-v143
description: This transcriptomics workflow processes FASTQ reads, genomic references, and annotations using the ChiRA tool suite, FastQC, and Cutadapt to perform comprehensive RNA-RNA interactome analysis. Use this skill when you need to identify and quantify chimeric RNA-RNA interactions from ligation-based sequencing data to characterize molecular binding events and post-transcriptional regulatory networks.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# rna-rna-interactome-data-analysis-chira-v143

## Overview

This workflow provides a comprehensive pipeline for analyzing RNA-RNA interactome data, specifically designed to identify and characterize chimeric reads that represent interactions between RNA molecules. It follows the best practices established by the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) for transcriptomics. The process begins with rigorous quality control using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and adapter trimming via [Cutadapt](https://cutadapt.readthedocs.io/) to prepare the raw sequencing reads for alignment.

The core of the analysis is powered by the [ChiRA tool suite](https://github.com/pavanpankaj/chira). The pipeline first collapses duplicate reads to streamline processing before mapping them against user-provided reference sequences and the genome. By merging overlapping alignments and quantifying the resulting loci, the workflow accurately identifies specific interaction sites across the transcriptome.

In the final stages, the workflow extracts detailed RNA-RNA interaction information and chimeric read data. It utilizes [Query Tabular](https://galaxyproject.org/training-material/topics/transcriptomics/tutorials/rna-interactome-chira/tutorial.html) to generate a searchable database of the results, allowing for easy exploration of binding partners and interaction strengths. This automated approach is essential for researchers studying the complex regulatory networks formed by RNA-RNA base pairing.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | reads_fastq | data_input |  |
| 1 | reference1_fasta | data_input |  |
| 2 | reference2_fasta | data_input |  |
| 3 | annotation_gtf | data_input |  |
| 4 | genome_fasta | data_input |  |


Ensure your input reads are in FASTQ format, while the reference sequences and genome must be provided as FASTA files alongside a matching GTF annotation. For high-throughput processing, organize your sequencing reads into a dataset collection to streamline the ChiRA tool suite execution. Refer to the `README.md` for comprehensive details on parameter settings and specific library preparation requirements. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 6 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.5 |  |
| 7 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 8 | ChiRA collapse | toolshed.g2.bx.psu.edu/repos/iuc/chira_collapse/chira_collapse/1.4.3+galaxy0 |  |
| 9 | ChiRA map | toolshed.g2.bx.psu.edu/repos/iuc/chira_map/chira_map/1.4.3+galaxy0 |  |
| 10 | ChiRA merge | toolshed.g2.bx.psu.edu/repos/iuc/chira_merge/chira_merge/1.4.3+galaxy0 |  |
| 11 | ChiRA qauntify | toolshed.g2.bx.psu.edu/repos/iuc/chira_quantify/chira_quantify/1.4.3+galaxy0 |  |
| 12 | ChiRA extract | toolshed.g2.bx.psu.edu/repos/iuc/chira_extract/chira_extract/1.4.3+galaxy0 |  |
| 13 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.0.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | html_file | html_file |
| 6 | out1 | out1 |
| 7 | html_file | html_file |
| 8 | out | out |
| 9 | mapped_bed | mapped_bed |
| 9 | unmapped_fasta | unmapped_fasta |
| 10 | merged_bed | merged_bed |
| 10 | segments_bed | segments_bed |
| 11 | loci | loci |
| 12 | interactions | interactions |
| 12 | chimeric_reads | chimeras |
| 13 | db | sqlitedb |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run rna-rna-interactome-data-analysis-chira.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run rna-rna-interactome-data-analysis-chira.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run rna-rna-interactome-data-analysis-chira.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init rna-rna-interactome-data-analysis-chira.ga -o job.yml`
- Lint: `planemo workflow_lint rna-rna-interactome-data-analysis-chira.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `rna-rna-interactome-data-analysis-chira.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)