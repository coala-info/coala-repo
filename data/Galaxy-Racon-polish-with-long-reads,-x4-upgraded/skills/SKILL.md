---
name: racon-polish-with-long-reads-x4-upgraded
description: "This Galaxy workflow performs four rounds of iterative genome assembly polishing using long reads mapped with minimap2 and processed by Racon. Use this skill when you need to improve the consensus accuracy and structural integrity of a draft genome assembly by correcting base-call errors using long-read sequencing data."
homepage: https://workflowhub.eu/workflows/1599
---

# Racon polish with long reads, x4 - upgraded

## Overview

This workflow provides an automated pipeline for improving the quality of a genome assembly using long-read sequencing data. It takes an initial assembly and a set of long reads as primary inputs, utilizing [minimap2](https://github.com/lh3/minimap2) for sequence alignment and [Racon](https://github.com/isovic/racon) for consensus correction.

The process consists of four successive iterations of mapping and polishing. In each round, the long reads are aligned to the current version of the assembly to identify errors; Racon then processes these alignments to generate a more accurate consensus sequence. This iterative approach ensures that the final output is a highly refined assembly with significantly reduced base-call errors.

Developed as an "upgraded" version often utilized in [GTN](https://training.galaxyproject.org/) tutorials, this workflow is licensed under [GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.en.html). It offers a standardized, repeatable method for assembly refinement within the Galaxy ecosystem, specifically optimized for long-read datasets.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Assembly to be polished | data_input |  |
| 1 | long reads | data_input |  |
| 2 | minimap setting (for long reads) | parameter_input |  |


Ensure your assembly is in FASTA format and long reads are provided as FASTQ or FASTA files to ensure compatibility with minimap2 and Racon. While individual datasets are suitable for single runs, using data collections is recommended for scaling the workflow across multiple samples. Be sure to select the correct minimap2 preset, such as map-ont or map-pb, to match your specific sequencing technology. Refer to the README.md for comprehensive details on parameter configurations and performance expectations. You can also use `planemo workflow_job_init` to quickly generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 | Map raw reads to assembly; output paf |
| 4 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.5.0+galaxy1 |  |
| 5 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 | Map raw reads to assembly; output paf |
| 6 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.5.0+galaxy1 |  |
| 7 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 | Map raw reads to assembly; output paf |
| 8 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.5.0+galaxy1 |  |
| 9 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 | Map raw reads to assembly; output paf |
| 10 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.5.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 10 | Assembly polished by long reads using Racon | consensus |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-racon-polish-with-long-reads-x4.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-racon-polish-with-long-reads-x4.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-racon-polish-with-long-reads-x4.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-racon-polish-with-long-reads-x4.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-racon-polish-with-long-reads-x4.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-racon-polish-with-long-reads-x4.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
