---
name: debruijn-graph-velvet-full-and-spades-assembly
description: This Galaxy workflow performs de novo genome assembly on paired-end FASTQ reads using the De Bruijn graph-based tools Velvet and SPAdes, providing assembly statistics and Bandage visualizations for quality assessment. Use this skill when you need to reconstruct a microbial genome from short-read sequencing data and evaluate the structural integrity of the resulting contigs through comparative assembly methods.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# debruijn-graph-velvet-full-and-spades-assembly

## Overview

This workflow performs *de novo* genome assembly using two prominent De Bruijn graph-based assemblers: Velvet and SPAdes. It is designed to process paired-end sequencing data, accepting either individual FASTQ files or a paired dataset collection as input.

The Velvet pipeline is automated using [VelvetOptimiser](https://toolshed.g2.bx.psu.edu/repos/simon-gladman/velvetoptimiser/velvetoptimiser/2.2.6), which searches for optimal parameter settings (such as k-mer size and coverage cutoff) before running the core `velveth` and `velvetg` steps. This ensures a high-quality assembly without manual k-mer tuning.

In parallel, the workflow utilizes [SPAdes](https://toolshed.g2.bx.psu.edu/repos/nml/spades/spades/4.2.0+galaxy0) to generate an alternative assembly. Both the Velvet and SPAdes outputs are then evaluated using [Fasta Statistics](https://toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.1) to provide contig metrics and [Bandage Image](https://toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4) to visualize the connectivity of the resulting assembly graphs.

This [GTN](https://training.galaxyproject.org/) inspired workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and provides a comprehensive comparison between different assembly algorithms within the Galaxy environment.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mutant_R1.fastq | data_input |  |
| 1 | mutant_R2.fastq | data_input |  |
| 2 | Input Paired Reads Collection | data_collection_input |  |


Ensure your input files are in FASTQ format, providing either individual forward and reverse datasets or a paired-end collection to accommodate both Velvet and SPAdes requirements. Using a paired dataset collection is recommended for more efficient data handling when processing multiple samples through these assembly pipelines. For automated testing and execution, you can initialize a job configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on parameter tuning and specific library preparation requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | VelvetOptimiser | toolshed.g2.bx.psu.edu/repos/simon-gladman/velvetoptimiser/velvetoptimiser/2.2.6 |  |
| 4 | velveth | toolshed.g2.bx.psu.edu/repos/devteam/velvet/velveth/1.2.10.3 |  |
| 5 | SPAdes | toolshed.g2.bx.psu.edu/repos/nml/spades/spades/4.2.0+galaxy0 |  |
| 6 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.1 |  |
| 7 | velvetg | toolshed.g2.bx.psu.edu/repos/devteam/velvet/velvetg/1.2.10.2 |  |
| 8 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 9 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.1 |  |
| 10 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | stats | stats |
| 3 | logfile | logfile |
| 3 | contigs | contigs |
| 5 | spades_log | out_l |
| 6 | fasta_stats_velvet | stats |
| 8 | outfile | outfile |
| 9 | fasta_stats_spades | stats |
| 10 | outfile | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run debruijn-graph-velvet-full-and-spades-assembly.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run debruijn-graph-velvet-full-and-spades-assembly.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run debruijn-graph-velvet-full-and-spades-assembly.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init debruijn-graph-velvet-full-and-spades-assembly.ga -o job.yml`
- Lint: `planemo workflow_lint debruijn-graph-velvet-full-and-spades-assembly.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `debruijn-graph-velvet-full-and-spades-assembly.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)