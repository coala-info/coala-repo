---
name: ont-assembly-flye-ahrenslab
description: This workflow performs de novo genome assembly of Oxford Nanopore long-read data using Filtlong for quality filtering, Flye for assembly, and Racon and Nanopolish for iterative sequence polishing. Use this skill when you need to generate a high-quality consensus genome sequence from raw nanopore signal and read data by correcting assembly errors through signal-level polishing.
homepage: https://workflowhub.eu/workflows/51
metadata:
  docker_image: "N/A"
---

# ont-assembly-flye-ahrenslab

## Overview

This Galaxy workflow is designed for the *de novo* assembly and polishing of Oxford Nanopore Technologies (ONT) long-read sequencing data. It processes raw ONT data, accepting both FASTQ files and fast5 signal data as primary inputs to generate high-quality genomic sequences.

The pipeline begins with a pre-processing stage where [filtlong](https://github.com/rrwick/Filtlong) is used to filter reads based on quality and length. The filtered reads are then assembled using [Flye](https://github.com/fenderglass/Flye), a specialized assembler for long, noisy genomic reads. 

Following the initial assembly, the workflow performs multiple rounds of refinement to improve consensus accuracy. It utilizes [minimap2](https://github.com/lh3/minimap2) for read mapping and [Racon](https://github.com/isovic/racon) for rapid polishing. The final stage employs [Nanopolish variants](https://github.com/jts/nanopolish), which leverages the original fast5 signal data to further correct errors and produce a polished final assembly.

This workflow is tagged for **ONT** applications and provides a robust automated path from raw nanopore reads to a refined assembly. For specific configuration details and execution steps, please refer to the [README.md](README.md) located in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | PkorrP19E3_ONT_fast5.tar.gz | data_input |  |
| 1 | ftp://biftp.informatik.uni-freiburg.de/pub/T0/Ahrens/SRR6982805.fastq | data_input |  |


For successful execution, provide raw ONT reads in FASTQ format for the initial assembly and a compressed archive of FAST5 files specifically for signal-level polishing with Nanopolish. Ensure these inputs are uploaded as individual datasets or organized into collections if you are scaling the workflow for multiple samples. Consult the `README.md` for comprehensive details on specific data preparation requirements and parameter configurations. You may use `planemo workflow_job_init` to create a `job.yml` file for streamlined input mapping and automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | filtlong | toolshed.g2.bx.psu.edu/repos/iuc/filtlong/filtlong/0.2.0 |  |
| 3 | Assembly | toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.3.5 |  |
| 4 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.12 |  |
| 5 | BAM-to-SAM | toolshed.g2.bx.psu.edu/repos/devteam/bam_to_sam/bam_to_sam/2.0.1 |  |
| 6 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.3.1 |  |
| 7 | Nanopolish variants | toolshed.g2.bx.psu.edu/repos/bgruening/nanopolish_variants/nanopolish_variants/0.1.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ONT_--_Assembly-Flye-AhrensLab.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ONT_--_Assembly-Flye-AhrensLab.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ONT_--_Assembly-Flye-AhrensLab.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ONT_--_Assembly-Flye-AhrensLab.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ONT_--_Assembly-Flye-AhrensLab.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ONT_--_Assembly-Flye-AhrensLab.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)