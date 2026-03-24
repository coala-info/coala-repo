---
name: assembly-polishing-with-long-reads
description: "This workflow performs four rounds of iterative genome assembly polishing by mapping long reads to a draft assembly with minimap2 and generating consensus sequences using Racon. Use this skill when you need to improve the base-level accuracy and correct errors in a draft genome assembly using PacBio or Oxford Nanopore sequencing data."
homepage: https://workflowhub.eu/workflows/563
---

# Assembly polishing with long reads

## Overview

This workflow is designed to improve the quality of a genome assembly by polishing it with long-read sequencing data. It utilizes an iterative approach involving [minimap2](https://toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0) for read mapping and [Racon](https://toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.5.0+galaxy1) for consensus correction to refine the initial contigs.

The pipeline executes four consecutive rounds of polishing. In each cycle, the long reads are mapped back to the current version of the assembly to generate overlaps, which [Racon](https://toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.5.0+galaxy1) then uses to correct errors and produce an updated consensus. The output of each round serves as the input for the next, progressively refining the assembly through four stages of correction.

Users must provide the initial assembly in FASTA format and the corresponding long reads. The workflow is compatible with various technologies; users should specify the appropriate [minimap2](https://toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.26+galaxy0) parameter—such as `map-pb` for PacBio, `map-hifi` for HiFi, or `map-ont` for Oxford Nanopore—to ensure optimal mapping performance. The final output is a polished assembly in FASTA format, released under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Assembly to be polished | data_input |  |
| 1 | long reads | data_input |  |
| 2 | minimap setting (for long reads) | parameter_input |  |


Ensure your assembly is in FASTA format and your long reads are provided as FASTQ (optionally gzipped), using individual datasets for single-sample runs. When configuring the workflow, you must manually specify the correct minimap2 preset—such as `map-pb`, `map-hifi`, or `map-ont`—to match your specific sequencing technology. Refer to the README.md for comprehensive details on the iterative polishing logic and parameter requirements. For automated execution, you can initialize a job template using `planemo workflow_job_init` to generate a `job.yml` file.

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
planemo run Assembly-polishing-with-long-reads.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Assembly-polishing-with-long-reads.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Assembly-polishing-with-long-reads.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Assembly-polishing-with-long-reads.ga -o job.yml`
- Lint: `planemo workflow_lint Assembly-polishing-with-long-reads.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Assembly-polishing-with-long-reads.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
