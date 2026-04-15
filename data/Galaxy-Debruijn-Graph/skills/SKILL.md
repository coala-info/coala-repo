---
name: debruijn-graph
description: This Galaxy workflow performs de novo genome assembly on paired-end mutant reads using VelvetOptimiser and SPAdes to generate comparative assembly statistics. Use this skill when you need to reconstruct a genome from raw sequencing data and evaluate the performance of different De Bruijn graph-based assembly algorithms.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# debruijn-graph

## Overview

This Galaxy workflow performs *de novo* genome assembly using De Bruijn Graph (DBG) algorithms, a standard approach for reconstructing genomes from short-read sequencing data. It accepts paired-end reads (`mutant_R1` and `mutant_R2`) as primary inputs to generate and compare genomic contigs.

The pipeline employs two distinct assembly strategies to ensure robust results. It first utilizes [VelvetOptimiser](https://toolshed.g2.bx.psu.edu/repos/simon-gladman/velvetoptimiser/velvetoptimiser/2.2.6) to automatically determine the optimal k-mer size and coverage parameters for the Velvet assembler. Simultaneously, it runs [SPAdes](https://toolshed.g2.bx.psu.edu/repos/nml/spades/spades/3.12.0+galaxy1), a versatile assembly toolkit designed to handle varying coverage depths and library types.

The final stage of the workflow focuses on assembly evaluation. Both the Velvet and SPAdes outputs are processed through [Fasta Statistics](https://toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.1) to generate comparative metrics. These outputs allow researchers to assess the quality, contiguity, and N50 scores of the resulting assemblies, following best practices often found in [GTN](https://training.galaxyproject.org/) training materials for microbial assembly.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mutant_R1 | data_input |  |
| 1 | mutant_R2 | data_input |  |


Ensure your input files are in FASTQ format, typically provided as paired-end reads for the mutant_R1 and mutant_R2 inputs. While the workflow accepts individual datasets, using paired dataset collections can help organize your history when running multiple assembly iterations. Please consult the README.md for exhaustive documentation on data preparation and tool configurations. You may also use planemo workflow_job_init to create a job.yml for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | VelvetOptimiser | toolshed.g2.bx.psu.edu/repos/simon-gladman/velvetoptimiser/velvetoptimiser/2.2.6 |  |
| 3 | SPAdes | toolshed.g2.bx.psu.edu/repos/nml/spades/spades/3.12.0+galaxy1 |  |
| 4 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.1 |  |
| 5 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | fasta_stats_velvet | stats |
| 5 | fasta_stats_spades | stats |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run debruijn-graph.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run debruijn-graph.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run debruijn-graph.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init debruijn-graph.ga -o job.yml`
- Lint: `planemo workflow_lint debruijn-graph.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `debruijn-graph.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)