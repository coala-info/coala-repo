---
name: go-enrichment-workflow
description: "This transcriptomics workflow utilizes GOEnrichment and GOSlimmer tools to analyze gene lists against population backgrounds and Gene Ontology annotations for species such as Drosophila and Mouse. Use this skill when you need to identify significantly enriched biological processes, molecular functions, or cellular components within sets of differentially expressed genes to understand the functional impact of experimental conditions."
homepage: https://workflowhub.eu/workflows/1667
---

# GO Enrichment Workflow

## Overview

This workflow performs Gene Ontology (Enrichment) analysis to identify over-represented biological processes, molecular functions, or cellular components within transcriptomics datasets. It is designed to support comparative studies across different species, specifically *Drosophila melanogaster* and *Mus musculus*, by processing differential expression results against established population backgrounds.

The pipeline utilizes the [GOEnrichment](https://toolshed.g2.bx.psu.edu/repos/iuc/goenrichment/goenrichment/2.0.1) tool to calculate statistical significance for gene sets, including overexpressed and underexpressed mouse gene lists. It also incorporates [GOSlimmer](https://toolshed.g2.bx.psu.edu/repos/iuc/goslimmer/goslimmer/1.0.1) to map specific GO terms to broader, high-level categories, providing a more concise summary of the functional landscape.

This workflow is based on the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorial for GO Enrichment Analysis. It provides a standardized approach for filtering genomic data and generating biological insights from complex transcriptomic experiments.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | GO annotations Drosophila melanogaster | data_input |  |
| 1 | GO | data_input |  |
| 2 | trapnellPopulation.tab | data_input |  |
| 3 | GO annotations Mus musculus | data_input |  |
| 4 | Mouse population | data_input |  |
| 5 | Mouse diff | data_input |  |
| 6 | GO Slim | data_input |  |
| 7 | mouseUnderexpressed.txt | data_input |  |
| 8 | mouseOverexpressed.txt | data_input |  |


Ensure your Gene Ontology files are in OBO format and your annotation and gene list files are formatted as tabular or text files. Since this workflow processes specific species-dependent inputs, organize your datasets clearly to match the corresponding Drosophila or Mouse parameters. Refer to the README.md for comprehensive details on column requirements and specific tool configurations. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 9 | Filter | Filter1 |  |
| 10 | Filter | Filter1 |  |
| 11 | GOEnrichment | toolshed.g2.bx.psu.edu/repos/iuc/goenrichment/goenrichment/2.0.1 |  |
| 12 | GOEnrichment | toolshed.g2.bx.psu.edu/repos/iuc/goenrichment/goenrichment/2.0.1 |  |
| 13 | GOSlimmer | toolshed.g2.bx.psu.edu/repos/iuc/goslimmer/goslimmer/1.0.1 |  |
| 14 | GOEnrichment | toolshed.g2.bx.psu.edu/repos/iuc/goenrichment/goenrichment/2.0.1 |  |
| 15 | GOEnrichment | toolshed.g2.bx.psu.edu/repos/iuc/goenrichment/goenrichment/2.0.1 |  |
| 16 | GOEnrichment | toolshed.g2.bx.psu.edu/repos/iuc/goenrichment/goenrichment/2.0.1 |  |
| 17 | GOEnrichment | toolshed.g2.bx.psu.edu/repos/iuc/goenrichment/goenrichment/2.0.1 |  |
| 18 | GOEnrichment | toolshed.g2.bx.psu.edu/repos/iuc/goenrichment/goenrichment/2.0.1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run goenrichment-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run goenrichment-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run goenrichment-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init goenrichment-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint goenrichment-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `goenrichment-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
