---
name: debruijn-graph-velvet-optimiser-and-spades-assembly
description: "This Galaxy workflow performs de novo genome assembly on paired-end FASTQ reads using VelvetOptimiser and SPAdes to generate contigs, assembly statistics, and visualization plots. Use this skill when you need to reconstruct a microbial or small genome from short-read sequencing data and compare the performance of different De Bruijn graph-based assembly algorithms."
homepage: https://workflowhub.eu/workflows/2047
---

# Debruijn Graph Velvet Optimiser and SPAdes Assembly

## Overview

This Galaxy workflow performs *de novo* genome assembly using two prominent De Bruijn graph-based assemblers: Velvet and SPAdes. It is designed to process paired-end sequencing data, accepting either individual FASTQ files or a paired-end data collection as input. The pipeline is particularly useful for comparing different assembly algorithms or optimizing parameters for short-read data.

The workflow first utilizes [VelvetOptimiser](https://github.com/slugger70/VelvetOptimiser) to automatically determine the ideal k-mer size and coverage thresholds, streamlining the often complex task of parameter tuning for the Velvet assembler. In parallel, it executes the [SPAdes](https://github.com/ablab/spades) assembly pipeline, which is known for its versatility in handling various genomic datasets.

To evaluate the results, the workflow generates detailed assembly metrics using [Fasta Statistics](https://github.com/galaxyproject/tools-iuc/tree/master/tools/fasta_stats) for both outputs. It also includes a [Bandage Image](https://rrwick.github.io/Bandage/) step to provide a graphical visualization of the assembly graph, allowing users to visually inspect the connectivity and fragmentation of the assembled contigs.

This resource is associated with the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/). It serves as a robust template for [Assembly](https://galaxyproject.org/use/assembly/) benchmarking and quality assessment.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mutant_R1.fastq | data_input |  |
| 1 | mutant_R2.fastq | data_input |  |
| 2 | Input Paired Reads Collection | data_collection_input |  |


Ensure your input sequencing data is in FASTQ format, as the workflow is designed to process paired-end reads for de novo assembly. You can provide these as individual datasets for the forward and reverse reads or utilize a paired-end dataset collection to streamline the analysis of multiple samples. For comprehensive details on parameter tuning and tool-specific requirements, please refer to the README.md file. Automated execution can be configured by generating a job.yml file using the planemo workflow_job_init command.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | VelvetOptimiser | toolshed.g2.bx.psu.edu/repos/simon-gladman/velvetoptimiser/velvetoptimiser/2.2.6 |  |
| 4 | SPAdes | toolshed.g2.bx.psu.edu/repos/nml/spades/spades/4.2.0+galaxy0 |  |
| 5 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.1 |  |
| 6 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy0 |  |
| 7 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | contigs | contigs |
| 3 | stats | stats |
| 3 | logfile | logfile |
| 4 | spades_log | out_l |
| 5 | fasta_stats_velvet | stats |
| 6 | outfile | outfile |
| 7 | fasta_stats_spades | stats |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run debruijn-graph-velvet-optimiser-and-spades-assembly.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run debruijn-graph-velvet-optimiser-and-spades-assembly.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run debruijn-graph-velvet-optimiser-and-spades-assembly.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init debruijn-graph-velvet-optimiser-and-spades-assembly.ga -o job.yml`
- Lint: `planemo workflow_lint debruijn-graph-velvet-optimiser-and-spades-assembly.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `debruijn-graph-velvet-optimiser-and-spades-assembly.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
