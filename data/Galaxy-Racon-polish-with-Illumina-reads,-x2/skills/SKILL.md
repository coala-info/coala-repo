---
name: racon-polish-with-illumina-reads-r1-only-x2
description: This Galaxy workflow performs two rounds of assembly polishing by mapping Illumina R1 reads to a draft genome using Minimap2 and refining the sequence with Racon. Use this skill when you need to correct base-level errors, such as indels or mismatches, in a draft assembly using high-accuracy short-read sequencing data to improve overall consensus quality.
homepage: https://usegalaxy.org.au/
metadata:
  docker_image: "N/A"
---

# racon-polish-with-illumina-reads-r1-only-x2

## Overview

This Galaxy workflow performs iterative polishing of a genome assembly using Illumina short reads (R1 only). It is designed to improve the consensus accuracy of an initial assembly by correcting base-level errors using high-accuracy short-read data. The workflow requires two primary inputs: the assembly to be polished and the corresponding Illumina R1 reads in `fastq.gz` format.

The pipeline executes two consecutive rounds of polishing to maximize assembly quality. Each round begins by mapping the short reads to the current assembly version using [minimap2](https://github.com/lh3/minimap2). The resulting alignments are then processed by [Racon](https://github.com/isovic/racon), which utilizes the mapping information to generate a refined consensus sequence.

By repeating the mapping and polishing steps twice, the workflow ensures a more thorough correction of errors that might have been missed in a single pass. The final output is a polished assembly file that has undergone two iterations of Racon refinement, making it suitable for downstream genomic analysis. This workflow is tagged as **LG-WF**.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Assembly to be polished | data_input |  |
| 1 | Illumina reads, R1, in fastq.gz format | data_input |  |


Ensure the assembly is in FASTA format and the Illumina R1 reads are provided as FASTQ.GZ files for optimal compatibility with Minimap2 and Racon. While individual datasets work for single assemblies, using a dataset collection for the Illumina reads is recommended if processing multiple samples in parallel. Refer to the README.md for specific parameter configurations and detailed preprocessing requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.20+galaxy2 |  |
| 3 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.4.13 |  |
| 4 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.20+galaxy2 |  |
| 5 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.4.13 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | Assembly polished by short reads using Racon | consensus |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Racon_polish_with_Illumina_reads_x2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Racon_polish_with_Illumina_reads_x2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Racon_polish_with_Illumina_reads_x2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Racon_polish_with_Illumina_reads_x2.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Racon_polish_with_Illumina_reads_x2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Racon_polish_with_Illumina_reads_x2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)