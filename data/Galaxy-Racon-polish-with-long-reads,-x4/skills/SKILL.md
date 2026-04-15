---
name: racon-polish-with-long-reads-x4
description: This bioinformatics workflow performs four iterative rounds of genome assembly polishing by mapping long reads with Minimap2 and generating a consensus correction using Racon. Use this skill when you need to improve the base-call accuracy and structural integrity of a draft genome assembly by iteratively correcting errors using noisy long-read sequences.
homepage: https://usegalaxy.org.au/
metadata:
  docker_image: "N/A"
---

# racon-polish-with-long-reads-x4

## Overview

This workflow performs iterative polishing of a genome assembly using long-read sequencing data. It requires an initial assembly in FASTA format, a set of long reads, and specific [minimap2](https://github.com/lh3/minimap2) parameters tailored to the sequencing technology used (e.g., Oxford Nanopore or PacBio).

The pipeline executes four consecutive rounds of error correction to improve the consensus accuracy of the assembly. Each round consists of a two-step process: first, the long reads are mapped to the current assembly version using [minimap2](https://github.com/lh3/minimap2), and then [Racon](https://github.com/isovic/racon) is used to generate a refined consensus sequence based on the resulting overlaps.

By repeating this process four times, the workflow progressively reduces errors and improves the overall quality of the assembly. The final output is a polished assembly that has undergone multiple stages of refinement, making it suitable for downstream genomic analysis. This workflow is tagged under LG-WF.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Assembly to be polished | data_input |  |
| 1 | long reads | data_input |  |
| 2 | minimap setting (for long reads) | parameter_input |  |


Ensure the assembly is in FASTA format and long reads are provided as FASTQ or FASTA files. Using data collections is recommended if you are polishing multiple assemblies simultaneously to maintain organization across the four iterative mapping and polishing steps. Consult the README.md for specific guidance on selecting the appropriate minimap2 presets for your specific long-read technology. You may use `planemo workflow_job_init` to create a `job.yml` for streamlined command-line execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.20+galaxy2 | Map raw reads to assembly; output paf |
| 4 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.4.13 |  |
| 5 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.20+galaxy2 | Map raw reads to assembly; output paf |
| 6 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.4.13 |  |
| 7 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.20+galaxy2 | Map raw reads to assembly; output paf |
| 8 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.4.13 |  |
| 9 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.20+galaxy2 | Map raw reads to assembly; output paf |
| 10 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.4.13 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 10 | Assembly polished by long reads using Racon | consensus |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Racon_polish_with_long_reads_x4.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Racon_polish_with_long_reads_x4.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Racon_polish_with_long_reads_x4.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Racon_polish_with_long_reads_x4.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Racon_polish_with_long_reads_x4.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Racon_polish_with_long_reads_x4.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)