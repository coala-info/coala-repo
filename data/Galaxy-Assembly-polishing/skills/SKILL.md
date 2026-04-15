---
name: assembly-polishing
description: This bioinformatics workflow improves the accuracy of a draft genome assembly using long and short reads through iterative polishing with Racon and Medaka. Use this skill when you need to correct base-call errors and improve the consensus sequence of a de novo assembly using a hybrid approach of nanopore and Illumina sequencing data.
homepage: https://usegalaxy.org.au/
metadata:
  docker_image: "N/A"
---

# assembly-polishing

## Overview

This workflow provides a comprehensive pipeline for improving genome assembly quality through a hybrid polishing approach. It utilizes both long reads and Illumina short reads to iteratively correct errors and refine the consensus sequence. The process begins with four rounds of polishing using [Racon](https://github.com/isovic/racon) with long-read data, followed by a high-accuracy consensus step via the [medaka consensus pipeline](https://github.com/nanoporetech/medaka).

Following the long-read enhancements, the assembly undergoes further refinement using Illumina short reads. This stage consists of two additional Racon iterations specifically configured for short-read data to improve base-level accuracy. The workflow is tagged as **LG-WF** and is designed to handle complex polishing tasks in a structured, multi-step environment.

Throughout the execution, the workflow generates detailed [Fasta Statistics](https://galaxyproject.org/toolshed/) after each major polishing phase. These outputs allow users to monitor improvements in assembly metrics across the Racon (long-read), Medaka, and Racon (short-read) stages, ensuring transparency in the assembly's evolution.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Assembly to be polished | data_input |  |
| 1 | long reads | data_input |  |
| 2 | minimap setting (for long reads) | parameter_input |  |
| 3 | Illumina reads R1 | data_input |  |


Ensure your assembly is in FASTA format and reads are provided as FASTQ files, utilizing dataset collections if you intend to run the polishing steps on multiple samples simultaneously. Verify that the long reads and Illumina R1 data are high-quality, as the Racon and Medaka subworkflows rely on accurate mapping for effective error correction. Consult the `README.md` for comprehensive details on selecting the appropriate Medaka model and minimap2 presets for your specific sequencing technology. For automated execution, use `planemo workflow_job_init` to create a `job.yml` template for your input parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Racon polish with long reads, x4 | (subworkflow) |  |
| 5 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.3 |  |
| 6 | medaka consensus pipeline | toolshed.g2.bx.psu.edu/repos/iuc/medaka_consensus_pipeline/medaka_consensus_pipeline/1.3.2+galaxy0 |  |
| 7 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.3 |  |
| 8 | Racon polish with Illumina reads (R1 only), x2 | (subworkflow) |  |
| 9 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | Fasta statistics after Racon long read polish | stats |
| 6 | Assembly polished by long reads using Medaka | out_consensus |
| 7 | Fasta statistics after Medaka polish | stats |
| 9 | Fasta statistics after Racon short read polish | stats |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Assembly_polishing.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Assembly_polishing.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Assembly_polishing.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Assembly_polishing.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Assembly_polishing.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Assembly_polishing.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)