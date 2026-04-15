---
name: covid-19-genomics-2-assembly-of-genome-sequence
description: This Galaxy workflow performs hybrid assembly of SARS-CoV-2 genomes from Illumina and ONT reads using Unicycler and SPAdes, followed by assembly visualization with Bandage. Use this skill when you need to reconstruct a complete viral consensus sequence from pre-processed sequencing data to investigate pathogen evolution or track transmission variants.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-genomics-2-assembly-of-genome-sequence

## Overview

This workflow is designed for the *de novo* assembly of the SARS-CoV-2 genome using pre-processed sequencing data. It supports a hybrid assembly approach by accepting three primary inputs: forward and reverse Illumina short reads and long-read data from Oxford Nanopore Technologies (ONT).

The core of the assembly process is handled by [Unicycler](https://toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.6.0) and [SPAdes](https://toolshed.g2.bx.psu.edu/repos/nml/spades/spades/3.12.0+galaxy1). Unicycler functions as a hybrid assembler, leveraging the high accuracy of short reads to resolve the structural scaffolding provided by long reads, resulting in more complete and contiguous viral genome sequences.

To evaluate the results, the workflow utilizes [Bandage](https://toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy1) to generate both assembly statistics and visual representations of the assembly graphs. These steps allow researchers to inspect the connectivity of contigs and verify the quality of the reconstructed COVID-19 genomic sequence.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Forward reads | data_input |  |
| 1 | Reverse reads | data_input |  |
| 2 | ONT reads | data_input |  |


Ensure the input files are in fastqsanger or fastqsanger.gz format, specifically using pre-processed Illumina paired-end reads and Oxford Nanopore (ONT) long reads for hybrid assembly. While individual datasets can be used, organizing Illumina data into paired-end collections simplifies the workflow execution when processing multiple samples. Refer to the README.md for comprehensive instructions on parameter settings and specific data preparation requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated job configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Create assemblies with Unicycler | toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.6.0 |  |
| 4 | SPAdes | toolshed.g2.bx.psu.edu/repos/nml/spades/spades/3.12.0+galaxy1 |  |
| 5 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy1 |  |
| 6 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy2 |  |
| 7 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy2 |  |
| 8 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Genomics-2-Assembly.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Genomics-2-Assembly.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Genomics-2-Assembly.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Genomics-2-Assembly.ga -o job.yml`
- Lint: `planemo workflow_lint Genomics-2-Assembly.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Genomics-2-Assembly.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)