---
name: assembly-with-flye-upgraded
description: This Galaxy workflow performs de novo assembly of long-read sequencing data using Flye and evaluates the resulting assembly with Quast, Fasta Statistics, and Bandage visualization. Use this skill when you need to generate high-quality contiguous sequences from PacBio or Oxford Nanopore reads and assess the structural integrity and completeness of the genomic assembly.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# assembly-with-flye-upgraded

## Overview

This Galaxy workflow performs *de novo* assembly of long-read sequencing data using [Flye](https://toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9.3+galaxy0). It is designed to process raw long reads to produce a polished consensus assembly along with detailed assembly graphs in GFA format.

Following the assembly, the workflow automates quality assessment and statistical analysis. It utilizes [Quast](https://toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.2.0+galaxy1) to generate a comprehensive HTML report of assembly metrics and [Fasta Statistics](https://toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0) to summarize sequence lengths and contiguity.

To aid in structural interpretation, the workflow generates visual representations of the assembly. [Bandage Image](https://toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4) provides a high-level view of the assembly graph, while a custom bar chart visualizes the distribution of contig sizes.

This workflow is associated with the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) and is licensed under [GPL-3.0-or-later](https://spdx.org/licenses/GPL-3.0-or-later.html). It serves as a robust pipeline for researchers needing both a final consensus sequence and the underlying graph data for complex genomic regions.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | long reads | data_input |  |


Ensure your long-read input data is in FASTQ or FASTA format, typically sourced from Oxford Nanopore or PacBio sequencing platforms. While the workflow accepts individual datasets, utilizing dataset collections is recommended for efficiently managing and processing multiple samples in a single run. Refer to the accompanying README.md for comprehensive details on parameter configurations and specific tool requirements. You can also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Flye | toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9.3+galaxy0 |  |
| 2 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 |  |
| 3 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.2.0+galaxy1 |  |
| 4 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 5 | Bar chart | barchart_gnuplot |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Flye assembly on input dataset(s) (consensus) | consensus |
| 1 | Flye assembly on input dataset(s) (assembly_graph) | assembly_graph |
| 1 | Flye assembly on input dataset(s) (Graphical Fragment Assembly) | assembly_gfa |
| 1 | Flye assembly on input dataset(s) (assembly_info) | assembly_info |
| 3 | Quast on input dataset(s):  HTML report | report_html |
| 4 | Bandage Image on input dataset(s): Assembly Graph Image | outfile |
| 5 | Bar chart showing contig sizes | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-assembly-with-flye.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-assembly-with-flye.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-assembly-with-flye.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-assembly-with-flye.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-assembly-with-flye.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-assembly-with-flye.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)