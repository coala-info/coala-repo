---
name: de-novo-rad-seq
description: "This ecology workflow processes raw RAD-Seq FASTQ data, barcodes, and population maps using Stacks and FastQC to perform de novo assembly and population genetic analysis. Use this skill when you need to identify genetic markers and analyze population structure in non-model organisms lacking a reference genome."
homepage: https://workflowhub.eu/workflows/1666
---

# de novo Rad Seq

## Overview

This workflow provides a comprehensive pipeline for *de novo* Restriction site Associated DNA sequencing (RAD-Seq) data analysis, specifically designed for ecological and evolutionary studies where a reference genome is unavailable. It follows established [GTN (Galaxy Training Network)](https://training.galaxyproject.org/) methodologies to transform raw sequencing reads into filtered, population-level genetic markers.

The process begins with data demultiplexing and quality control. Using [Stacks: process radtags](https://toolshed.g2.bx.psu.edu/repos/iuc/stacks_procrad/stacks_procrad/1.46.0), the workflow cleans raw FASTQ reads by checking for intact restriction sites and assigning sequences to individuals based on provided barcodes. [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.69) is utilized in parallel to ensure the integrity and quality of the processed data.

The core of the analysis is handled by [Stacks: de novo map](https://toolshed.g2.bx.psu.edu/repos/iuc/stacks_denovomap/stacks_denovomap/1.46.0), which assembles loci from scratch and identifies SNPs across the sample set. Finally, the [Stacks: populations](https://toolshed.g2.bx.psu.edu/repos/iuc/stacks_populations/stacks_populations/1.46.0) tool uses a population map to calculate genetic statistics and export data for downstream analysis, making it a vital tool for researchers studying non-model organisms.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Population_map.txt | data_input |  |
| 1 | Barcodes_SRR034310.tabular | data_input |  |
| 2 | SRR034310.fastq | data_input |  |
| 3 | ref_genome_chromFa.tar | data_input |  |


Ensure your sequencing data is in FASTQ format and that the population map and barcode files are correctly formatted as tabular text files. For large-scale studies, organizing your FASTQ files into a dataset collection will streamline the Stacks processing steps. Verify that the reference genome archive is properly compressed as a .tar file to be compatible with the downstream tools. Consult the README.md for specific column requirements for the population map and barcode files. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Stacks: process radtags | toolshed.g2.bx.psu.edu/repos/iuc/stacks_procrad/stacks_procrad/1.46.0 |  |
| 5 | Stacks: process radtags | toolshed.g2.bx.psu.edu/repos/iuc/stacks_procrad/stacks_procrad/1.46.0 |  |
| 6 | Stacks: process radtags | toolshed.g2.bx.psu.edu/repos/iuc/stacks_procrad/stacks_procrad/1.46.0 |  |
| 7 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.69 |  |
| 8 | Stacks: de novo map | toolshed.g2.bx.psu.edu/repos/iuc/stacks_denovomap/stacks_denovomap/1.46.0 |  |
| 9 | Stacks: populations | toolshed.g2.bx.psu.edu/repos/iuc/stacks_populations/stacks_populations/1.46.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-de-novo-rad-seq.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-de-novo-rad-seq.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-de-novo-rad-seq.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-de-novo-rad-seq.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-de-novo-rad-seq.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-de-novo-rad-seq.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
