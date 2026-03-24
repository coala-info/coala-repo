---
name: galaxy-intro-strands-2
description: "This genomics workflow processes gene input files to extract specific genomic features like exons and introns using filtering, intersection, and concatenation tools. Use this skill when you need to isolate specific functional elements of genes or identify overlapping genomic regions for comparative analysis."
homepage: https://workflowhub.eu/workflows/1544
---

# Galaxy Intro Strands 2

## Overview

This workflow provides an introductory exercise in genomics and data manipulation within the Galaxy ecosystem. It is designed to teach users how to process gene annotations and handle genomic coordinates, specifically focusing on extracting and filtering sub-features from a primary gene dataset.

The process begins by taking a "Genes" input in BED format and utilizing the `gene2exon` tool to convert these records into specific components such as exons, introns, or codons. Following this conversion, the workflow applies multiple filtering steps to refine the data, ensuring that only relevant genomic regions are carried forward for comparative analysis.

In the final stages, the workflow performs spatial operations using the [Intersect](https://toolshed.g2.bx.psu.edu/view/devteam/intersect/) tool to identify overlapping genomic intervals. These refined datasets are then merged via a concatenation tool to produce a consolidated output. This sequence is a foundational component of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) curriculum, aimed at building proficiency in genomic interval operations.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Genes | data_input |  |


Ensure the input "Genes" file is provided in BED format to maintain compatibility with the genomic interval tools and filtering steps in this workflow. While the pipeline is configured for individual datasets, you can leverage dataset collections to process multiple genomic samples in parallel. Please refer to the `README.md` for comprehensive details regarding specific column requirements and the logic behind the intersection parameters. For streamlined testing and execution, you can use `planemo workflow_job_init` to generate a template `job.yml` file for your inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Gene BED To Exon/Intron/Codon BED | gene2exon1 |  |
| 2 | Filter | Filter1 |  |
| 3 | Filter | Filter1 |  |
| 4 | Intersect | toolshed.g2.bx.psu.edu/repos/devteam/intersect/gops_intersect_1/1.0.0 |  |
| 5 | Intersect | toolshed.g2.bx.psu.edu/repos/devteam/intersect/gops_intersect_1/1.0.0 |  |
| 6 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflowlaxy-intro-strands-2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflowlaxy-intro-strands-2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflowlaxy-intro-strands-2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflowlaxy-intro-strands-2.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflowlaxy-intro-strands-2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflowlaxy-intro-strands-2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
