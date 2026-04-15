---
name: galaxy-intro-strands
description: This genomic workflow processes gene datasets using filtering, intersection, and concatenation tools to perform basic interval manipulations. Use this skill when you need to identify specific subsets of genes based on genomic coordinates or strand orientation during a foundational bioinformatics analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# galaxy-intro-strands

## Overview

This workflow provides a foundational introduction to genomic data analysis within the Galaxy ecosystem. It is designed to accompany [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials, specifically focusing on the "Introduction to Genomics and Galaxy" curriculum. The pipeline demonstrates how to manipulate gene datasets to identify specific genomic features based on their orientation and spatial relationships.

The process begins by taking a gene data input and applying multiple filtering steps to isolate features of interest, such as specific strands or attributes. These filtered datasets are then processed through intersection tools to identify overlapping genomic regions, a fundamental operation in spatial genomics.

In the final stage, the workflow utilizes text processing tools to concatenate the resulting datasets into a single, unified output. This sequence serves as a practical example of how to chain basic Galaxy tools—filtering, intersecting, and merging—to perform complex genomic queries.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Genes | data_input |  |


Ensure the input "Genes" file is provided in a genomic interval format such as BED or GTF to ensure compatibility with the filtering and intersection tools. Although the workflow is designed for single datasets, it can be adapted for high-throughput analysis by wrapping the inputs into a dataset collection. Consult the `README.md` for exhaustive documentation on specific tool parameters and data preparation steps. For automated execution and testing, use `planemo workflow_job_init` to create a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Filter | Filter1 |  |
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
planemo run galaxy-workflowlaxy-intro-strands.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflowlaxy-intro-strands.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflowlaxy-intro-strands.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflowlaxy-intro-strands.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflowlaxy-intro-strands.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflowlaxy-intro-strands.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)