---
name: gtn-preprocessing-of-10x-scrna-seq-data
description: "This single-cell transcriptomics workflow processes raw 10X Genomics FASTQ files using RNA STARSolo for alignment and DropletUtils for barcode processing and quality control. Use this skill when you need to transform raw sequencing reads from 10X Chromium platforms into a filtered gene expression matrix while accounting for cell barcodes and unique molecular identifiers."
homepage: https://workflowhub.eu/workflows/1546
---

# GTN - Preprocessing of 10X scRNA-seq data

## Overview

This workflow provides a standardized pipeline for the initial preprocessing of 10X Genomics single-cell RNA-sequencing (scRNA-seq) data. It processes raw FASTQ files—specifically paired-end reads containing cell barcodes, UMIs, and cDNA sequences—alongside a reference genome and GTF annotation file to generate a digital expression matrix.

The core of the analysis is performed by [RNA STARSolo](https://toolshed.g2.bx.psu.edu/repos/iuc/rna_starsolo/rna_starsolo/2.7.11a+galaxy1), which handles sequence alignment, cell barcode demultiplexing, and UMI quantification in a single step. By utilizing a barcode whitelist, the tool accurately assigns reads to individual cells and produces the raw gene-by-cell count matrices required for downstream study.

Following quantification, the workflow utilizes [DropletUtils](https://toolshed.g2.bx.psu.edu/repos/iuc/dropletutils/dropletutils/1.10.0+galaxy2) to refine the data. These steps are essential for distinguishing between genuine cells and empty droplets containing ambient RNA, ensuring that only high-quality cellular data is retained for further transcriptomics analysis.

Developed as part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), this workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/). It serves as a foundational tool for single-cell researchers to move from raw sequencing outputs to filtered expression data ready for clustering and differential expression analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Reference Genome | parameter_input |  |
| 1 | Homo_sapiens.GRCh37.75.gtf | data_input |  |
| 2 | subset_pbmc_1k_v3_S1_L001_R1_001.fastq.gz | data_input |  |
| 3 | subset_pbmc_1k_v3_S1_L002_R1_001.fastq.gz | data_input |  |
| 4 | subset_pbmc_1k_v3_S1_L001_R2_001.fastq.gz | data_input |  |
| 5 | subset_pbmc_1k_v3_S1_L002_R2_001.fastq.gz | data_input |  |
| 6 | 3M-february-2018.txt.gz | data_input |  |


Ensure the sequencing reads are uploaded as compressed `.fastq.gz` files and the annotation as a `.gtf` file to maintain compatibility with RNA STARSolo. For efficient processing of multiple lanes, organize the paired-end reads into a list:paired collection before running the workflow. The barcode whitelist must be provided as a compressed text file to match the 10X Genomics chemistry used. Refer to the `README.md` for comprehensive details on specific parameter configurations and reference genome versions. You can use `planemo workflow_job_init` to automatically generate a `job.yml` for local execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | RNA STARSolo | toolshed.g2.bx.psu.edu/repos/iuc/rna_starsolo/rna_starsolo/2.7.11a+galaxy1 |  |
| 8 | DropletUtils | toolshed.g2.bx.psu.edu/repos/iuc/dropletutils/dropletutils/1.10.0+galaxy2 |  |
| 9 | DropletUtils | toolshed.g2.bx.psu.edu/repos/iuc/dropletutils/dropletutils/1.10.0+galaxy2 |  |
| 10 | DropletUtils | toolshed.g2.bx.psu.edu/repos/iuc/dropletutils/dropletutils/1.10.0+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run scrna-seq-preprocessing-tenx.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run scrna-seq-preprocessing-tenx.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run scrna-seq-preprocessing-tenx.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init scrna-seq-preprocessing-tenx.ga -o job.yml`
- Lint: `planemo workflow_lint scrna-seq-preprocessing-tenx.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `scrna-seq-preprocessing-tenx.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
