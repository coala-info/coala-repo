---
name: debruijn-graph-spades-assembly
description: This Galaxy workflow performs de novo genome assembly on paired-end read collections using the SPAdes assembler, followed by assembly quality assessment with Fasta Statistics and visualization via Bandage. Use this skill when you need to reconstruct a genome from sequencing data and evaluate the resulting contigs through statistical summaries and graphical representations of the assembly graph.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# debruijn-graph-spades-assembly

## Overview

This workflow performs *de novo* genome assembly using the [SPAdes](https://github.com/ablab/spades) assembler, a tool specifically designed for handling small genomes and single-cell data through De Bruijn graph construction. It accepts a collection of paired-end reads as the primary input to reconstruct genomic sequences into contigs and scaffolds.

The process begins with the SPAdes assembly engine, followed by two downstream analysis steps to evaluate the results. [Fasta Statistics](https://github.com/galaxyproject/tools-iuc/tree/master/tools/fasta_stats) generates essential metrics such as N50 and total assembly length, while [Bandage](https://rrwick.github.io/Bandage/) produces a high-resolution image of the assembly graph to help users visualize the connectivity and complexity of the assembled sequences.

The final outputs include the SPAdes execution log, a statistical summary of the assembly, and the Bandage visualization. This workflow is categorized under [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) for assembly education and is provided under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license. For detailed setup instructions, refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Paired Reads Collection | data_collection_input |  |


Ensure your input is a paired-end list collection containing fastq or fastq.gz files, as SPAdes requires high-quality sequencing data for optimal de novo assembly. Using a paired collection simplifies the workflow by automatically matching forward and reverse reads for the assembly step and subsequent visualization. Refer to the included README.md for specific parameter tuning and detailed data preparation instructions. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | SPAdes | toolshed.g2.bx.psu.edu/repos/nml/spades/spades/4.2.0+galaxy0 |  |
| 2 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.1 |  |
| 3 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | spades_log | out_l |
| 2 | fasta_stats_spades | stats |
| 3 | outfile | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run debruijn-graph-spades-assembly.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run debruijn-graph-spades-assembly.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run debruijn-graph-spades-assembly.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init debruijn-graph-spades-assembly.ga -o job.yml`
- Lint: `planemo workflow_lint debruijn-graph-spades-assembly.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `debruijn-graph-spades-assembly.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)