---
name: assembly-polishing-upgraded
description: "This bioinformatics workflow improves the accuracy of a genome assembly using long and short reads through iterative rounds of Racon polishing and Medaka consensus processing. Use this skill when you need to correct base-call errors and improve the structural integrity of a draft assembly by leveraging both high-coverage long reads and high-accuracy Illumina data."
homepage: https://workflowhub.eu/workflows/1578
---

# Assembly polishing - upgraded

## Overview

This workflow provides a comprehensive pipeline for refining genome assemblies by combining long-read and short-read sequencing data. It begins by performing four successive rounds of polishing using long reads via a [Racon](https://github.com/isovic/racon) subworkflow, followed by a consensus refinement step using the [medaka consensus pipeline](https://github.com/nanoporetech/medaka). This initial phase focuses on correcting large-scale errors and improving the structural accuracy of the draft assembly.

Following the long-read refinement, the workflow incorporates Illumina short-read data to address fine-scale errors and indels. It executes two additional iterations of Racon polishing specifically utilizing Illumina R1 reads. Throughout the process, the [Fasta Statistics](https://github.com/galaxyproject/tools-iuc/tree/master/tools/fasta_stats) tool is used to generate quality metrics, allowing for a comparative analysis of the assembly at various stages of the polishing process.

Designed for the Galaxy ecosystem and aligned with [GTN (Galaxy Training Network)](https://training.galaxyproject.org/) standards, this "upgraded" version offers a robust approach to generating high-accuracy consensus sequences. The final output is a polished assembly that has been optimized through both neural network-based consensus (Medaka) and iterative mapping-based correction (Racon).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Assembly to be polished | data_input |  |
| 1 | long reads | data_input |  |
| 2 | minimap setting (for long reads) | parameter_input |  |
| 3 | Illumina reads R1 | data_input |  |


Ensure your assembly is in FASTA format and your long and short reads are provided as FASTQ files, preferably compressed. While individual datasets are suitable for single runs, organizing your reads into collections is recommended for more efficient batch processing. Consult the README.md for comprehensive details on parameter settings and specific tool configurations. You can also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Racon polish with long reads, x4 - upgraded | (subworkflow) |  |
| 5 | medaka consensus pipeline | toolshed.g2.bx.psu.edu/repos/iuc/medaka_consensus_pipeline/medaka_consensus_pipeline/1.7.2+galaxy1 |  |
| 6 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 |  |
| 7 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 |  |
| 8 | Racon polish with Illumina reads (R1 only), x2 - upgraded | (subworkflow) |  |
| 9 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | Assembly polished by long reads using Medaka | out_consensus |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-assembly-polishing.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-assembly-polishing.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-assembly-polishing.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-assembly-polishing.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-assembly-polishing.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-assembly-polishing.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
