---
name: go-enrichment-workflow
description: This Galaxy workflow performs Gene Ontology enrichment analysis on marker genes using GOEnrichment and gProfiler GOSt tools based on provided annotation and background datasets. Use this skill when you need to identify statistically significant biological pathways or functional categories associated with a specific set of differentially expressed genes.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# go-enrichment-workflow

## Overview

This workflow performs Gene Ontology (GO) enrichment analysis to identify overrepresented biological processes, molecular functions, or cellular components within a specific set of genes. It requires four primary inputs: a list of marker genes, GO terms, gene annotations, and a background gene set used for statistical comparison.

The pipeline begins by preprocessing the input data using the **Split file** and **Cut** tools. These steps ensure that the gene lists and annotations are correctly formatted, partitioned, and filtered before being passed to the enrichment engines.

The core analysis is conducted using two complementary tools: **GOEnrichment** and **gProfiler GOSt**. These tools calculate the statistical significance of GO term enrichment, providing functional insights into the provided gene sets. This workflow is based on [GTN](https://training.galaxyproject.org/) materials and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Marker Genes | data_input |  |
| 1 | GO | data_input |  |
| 2 | Annotation | data_input |  |
| 3 | Background | data_input |  |


Ensure input files are provided in tabular or OBO formats, verifying that gene identifiers are consistent across the marker list, annotation, and background datasets. Use dataset collections if you are analyzing multiple marker gene sets to efficiently manage the split-file and enrichment tool outputs. Refer to the README.md for comprehensive details on required column indices and specific tool parameter configurations. You can also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and automated input mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_on_column/tp_split_on_column/0.4 |  |
| 5 | Cut | Cut1 |  |
| 6 | GOEnrichment | toolshed.g2.bx.psu.edu/repos/iuc/goenrichment/goenrichment/2.0.1 |  |
| 7 | gProfiler GOSt | toolshed.g2.bx.psu.edu/repos/iuc/gprofiler_gost/gprofiler_gost/0.1.7+galaxy11 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

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