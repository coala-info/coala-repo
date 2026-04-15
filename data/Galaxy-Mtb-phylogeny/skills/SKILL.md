---
name: mtb-phylogeny
description: This workflow estimates a phylogenetic tree for Mycobacterium tuberculosis from an input sequence alignment using RAxML and RStudio. Use this skill when you need to reconstruct the evolutionary history or analyze the genetic diversity of Mycobacterium tuberculosis strains based on whole genome sequencing data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# mtb-phylogeny

## Overview

This Galaxy workflow is designed to estimate phylogenetic trees for *Mycobacterium tuberculosis* (Mtb) using whole genome sequencing (WGS) data. Following methodologies supported by the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), it provides a standardized pipeline for researchers to analyze evolutionary relationships and genomic epidemiology within Mtb populations.

The process begins with a genomic input alignment, which is processed using [RAxML](https://github.com/stamatak/standard-RAxML) (Randomized Axelerated Maximum Likelihood) for high-performance phylogenetic reconstruction. The workflow also incorporates an interactive [RStudio](https://posit.co/products/open-source/rstudio/) environment, enabling users to perform custom data exploration or pre-processing within the Galaxy interface.

The primary outputs of the workflow are the best-scoring Maximum Likelihood (ML) tree and a comprehensive log file detailing the reconstruction parameters. These results are critical for identifying lineages and understanding the diversification of Mtb strains in a clinical or evolutionary context.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input alignment | data_input | Alignment in fasta format, containing variable positions from  variant calling |


Ensure your input alignment is provided in FASTA or PHYLIP format to ensure compatibility with the RAxML tool for phylogenetic reconstruction. While individual datasets are suitable for single runs, organizing your data into collections is more efficient when processing multiple M. tuberculosis alignments. Refer to the README.md for exhaustive documentation on data preparation and specific tool configurations. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined workflow execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | RStudio | interactive_tool_rstudio | Use R to visualize a phylogenetic tree |
| 2 | Phyogenetic reconstruction with RAxML | toolshed.g2.bx.psu.edu/repos/iuc/raxml/raxml/8.2.4+galaxy2 | Maximum likelihood-based inference of a phylogenetic tree |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Best-scoring ML Tree | bestTree |
| 2 | Info | info |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)