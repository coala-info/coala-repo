---
name: makeafakeinput
description: "This Galaxy workflow processes paired-end FASTQ sequencing data using Bowtie2, Cutadapt, and seqtk to generate downsampled, representative datasets. Use this skill when you need to create small, functional subsets of genomic data that maintain specific biological characteristics for educational tutorials or tool testing."
homepage: https://workflowhub.eu/workflows/1629
---

# MakeAFakeInput

## Overview

This workflow, **MakeAFakeInput**, is designed to facilitate the creation of small, representative datasets for [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials. It takes large paired-end FASTQ files as input and processes them to generate manageable subsets that maintain biological relevance for educational purposes.

The pipeline utilizes a combination of sequence alignment and text manipulation tools to downsample data. It begins by processing raw reads with [Cutadapt](https://cutadapt.readthedocs.io/) and [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) to align sequences. It then employs various text processing utilities—such as `sed`, `cut`, and `uniq`—alongside [seqtk_subseq](https://github.com/lh3/seqtk) to filter, transform, and extract specific read subsets.

This tool is particularly useful for contributors looking to develop new training materials without requiring students to process massive raw datasets. By automating the extraction of specific reads, it ensures that tutorial inputs are lightweight yet functional for demonstrating specific bioinformatics workflows.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | SRR891268_R1_20M.fastq.gz | data_input |  |
| 1 | SRR891268_R2_20M.fastq.gz | data_input |  |


Ensure your input files are in FASTQ format, typically provided as individual datasets for paired-end reads like the SRR891268 samples used here. If you are processing multiple samples, consider organizing them into a dataset collection to streamline the downstream Cutadapt and Bowtie2 steps. For automated testing and execution, you can use `planemo workflow_job_init` to generate a `job.yml` file containing these input parameters. Refer to the README.md for comprehensive details on parameter settings and data preparation specific to this tutorial.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FASTQ to Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fastq_to_tabular/fastq_to_tabular/1.1.1 |  |
| 3 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/1.16.5 |  |
| 4 | Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 5 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3 |  |
| 6 | Select random lines | random_lines1 |  |
| 7 | BAM-to-SAM | toolshed.g2.bx.psu.edu/repos/devteam/bam_to_sam/bam_to_sam/2.0.1 |  |
| 8 | Filter | Filter1 |  |
| 9 | Cut | Cut1 |  |
| 10 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/1.1.0 |  |
| 11 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 12 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.0 |  |
| 13 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/1.1.0 |  |
| 14 | seqtk_subseq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_subseq/1.3.1 |  |
| 15 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 16 | seqtk_subseq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_subseq/1.3.1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-makeafakeinput.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-makeafakeinput.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-makeafakeinput.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-makeafakeinput.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-makeafakeinput.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-makeafakeinput.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
