---
name: racon-polish-with-illumina-reads-r1-only-x2-upgraded
description: This Galaxy workflow polishes a genome assembly using Illumina R1 reads through two successive rounds of mapping with Minimap2 and consensus correction with Racon. Use this skill when you need to improve the base-level accuracy of a draft genome assembly by correcting errors using high-quality short-read sequencing data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# racon-polish-with-illumina-reads-r1-only-x2-upgraded

## Overview

This Galaxy workflow performs iterative polishing of a genome assembly using short-read Illumina data (specifically R1 reads). It is designed to improve the consensus accuracy of an initial assembly by identifying and correcting base-level errors through two successive rounds of alignment and polishing.

The process begins by mapping the Illumina R1 reads to the input assembly using [minimap2](https://github.com/lh3/minimap2). The resulting overlaps are then processed by [Racon](https://github.com/isovic/racon) to generate a refined consensus sequence. To ensure maximum accuracy, the workflow automatically repeats this cycle, using the first polished output as the reference for a second round of [minimap2](https://github.com/lh3/minimap2) mapping and [Racon](https://github.com/isovic/racon) polishing.

Licensed under GPL-3.0-or-later, this workflow is categorized under [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards. It provides a streamlined, automated approach for researchers looking to enhance assembly quality using single-end short-read datasets.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Assembly to be polished | data_input |  |
| 1 | Illumina reads, R1, in fastq.gz format | data_input |  |


Ensure your assembly is in FASTA format and your Illumina R1 reads are provided as compressed FASTQ.GZ files to ensure compatibility with Minimap2 and Racon. While individual datasets are suitable for single runs, utilizing Galaxy collections is recommended for scaling the workflow across multiple samples efficiently. Refer to the README.md for comprehensive details on parameter configurations and specific tool requirements. You can also use `planemo workflow_job_init` to generate a `job.yml` for streamlined execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 |  |
| 3 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.5.0+galaxy1 |  |
| 4 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0 |  |
| 5 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.5.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | Assembly polished by short reads using Racon | consensus |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-racon-polish-with-illumina-reads-x2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-racon-polish-with-illumina-reads-x2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-racon-polish-with-illumina-reads-x2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-racon-polish-with-illumina-reads-x2.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-racon-polish-with-illumina-reads-x2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-racon-polish-with-illumina-reads-x2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)