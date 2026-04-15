---
name: combined-workflows-for-large-genome-assembly-upgraded
description: This Galaxy workflow performs large genome assembly using long and short reads through a pipeline involving kmer counting with Meryl, read trimming with fastp, assembly with Flye, and subsequent polishing and quality assessment. Use this skill when you need to generate high-quality de novo assemblies for large genomes by combining hybrid sequencing data to ensure high accuracy and structural completeness.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# combined-workflows-for-large-genome-assembly-upgraded

## Overview

This Galaxy workflow provides a comprehensive pipeline for the assembly and refinement of large genomes using a hybrid approach. It processes long-read sequencing data alongside paired-end short reads (R1 and R2), utilizing specific minimap settings and an optional reference genome for comparative quality assessment.

The pipeline initiates with essential pre-processing steps, including k-mer counting via [meryl](https://github.com/marbl/meryl) and extensive data quality control. Short reads are automatically trimmed and filtered using [fastp](https://github.com/OpenGene/fastp) to ensure high-quality input for the subsequent assembly stages.

The core assembly is performed using [Flye](https://github.com/fenderglass/Flye), a tool optimized for large and complex genomes. Following the initial assembly, the workflow executes a polishing subworkflow to improve base-level accuracy. The process concludes with a thorough quality assessment, leveraging tools like Quast to evaluate the final assembly against the provided reference.

This upgraded workflow is tagged for [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards and is released under the GPL-3.0-or-later license, ensuring it meets community requirements for reproducible large-scale genomic analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | long reads | data_input |  |
| 1 | R1 | data_input |  |
| 2 | R2 | data_input |  |
| 3 | minimap settings (for long reads) | parameter_input |  |
| 4 | Reference genome for Quast | data_input |  |


Ensure your long reads and paired-end short reads are in FASTQ format, while the reference genome for quality assessment must be a FASTA file. For efficient processing of large datasets, we recommend organizing your short reads into paired-end collections rather than individual datasets to streamline the subworkflow execution. Please refer to the README.md for comprehensive details on configuring the minimap settings and other tool-specific parameters. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated input configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | kmer counting - meryl - upgraded | (subworkflow) |  |
| 6 | Data QC - upgraded | (subworkflow) |  |
| 7 | Trim and filter reads - fastp - upgraded  | (subworkflow) |  |
| 8 | Assembly with Flye - upgraded | (subworkflow) |  |
| 9 | Assembly polishing - upgraded | (subworkflow) |  |
| 10 | Assess genome quality - upgraded | (subworkflow) |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-combined-workflows-for-large-genome-assembly.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-combined-workflows-for-large-genome-assembly.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-combined-workflows-for-large-genome-assembly.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-combined-workflows-for-large-genome-assembly.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-combined-workflows-for-large-genome-assembly.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-combined-workflows-for-large-genome-assembly.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)