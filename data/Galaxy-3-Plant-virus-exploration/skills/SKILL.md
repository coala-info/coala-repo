---
name: 3-plant-virus-exploration
description: "This workflow processes raw sequencing reads from plant samples using fastp for quality control and Shovill for de novo assembly to identify viral sequences. Use this skill when you need to detect and characterize known or novel plant viruses within high-throughput sequencing datasets through reference-free assembly."
homepage: https://workflowhub.eu/workflows/103
---

# 3: Plant virus exploration

## Overview

This workflow is designed for the *de novo* exploration of plant viruses, enabling researchers to identify and characterize viral sequences from raw sequencing data. By focusing on virology and pathogen discovery, it provides a streamlined path for analyzing samples where a reference genome may not be readily available.

The process begins with [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.20.1+galaxy0), which performs essential quality control, adapter trimming, and read filtering. These cleaned reads are then passed to [Shovill](https://toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy0), a tool that optimizes the assembly process to generate high-quality contigs from the input data.

Users receive comprehensive outputs, including an HTML quality report, processed sequence files, and the final assembled contigs. This workflow is particularly useful for "DE_NOVO" assembly tasks in virology, providing the necessary logs and data structures to support further downstream exploration and virus identification.

## Inputs and data preparation

_None listed._


This workflow requires raw sequencing reads in FASTQ format, which should be organized into a paired dataset collection to streamline the assembly process. Using collections ensures that fastp and Shovill process paired files correctly while maintaining data organization throughout the de novo exploration. Please refer to the README.md for exhaustive details on data preparation and specific tool configurations. You can also utilize `planemo workflow_job_init` to generate a `job.yml` for automated job submission.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.20.1+galaxy0 |  |
| 1 | Shovill | toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | out2 | out2 |
| 0 | fastp on input dataset(s): HTML report | report_html |
| 0 | fastp on input dataset(s): Read 1 output | out1 |
| 1 | Shovill on input dataset(s) Log file | shovill_std_log |
| 1 | Shovill on input dataset(s): Contigs | contigs |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-3__Plant_virus_exploration.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-3__Plant_virus_exploration.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-3__Plant_virus_exploration.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-3__Plant_virus_exploration.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-3__Plant_virus_exploration.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-3__Plant_virus_exploration.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
