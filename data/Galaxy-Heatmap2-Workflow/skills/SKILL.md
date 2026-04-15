---
name: heatmap2-workflow
description: This transcriptomics workflow integrates differential expression results and normalized counts using data processing tools and ggplot2_heatmap2 to generate publication-quality heatmaps. Use this skill when you need to visualize expression patterns for specific genes of interest or identify trends among the most significantly differentially expressed genes in an RNA-seq study.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# heatmap2-workflow

## Overview

This Galaxy workflow is designed for transcriptomics data visualization, specifically for generating high-quality heatmaps from RNA-seq differential expression (DE) results. Following [GTN](https://training.galaxyproject.org/) standards, it automates the transition from raw statistical outputs to interpretable biological plots.

The pipeline processes three primary inputs: DE results, normalized counts, and a specific list of genes of interest. It utilizes a series of data manipulation steps—including filtering, joining datasets, and transposing—to isolate and format expression values. These steps ensure that the data is correctly structured for the `ggplot2_heatmap2` tool, which handles the final rendering.

The workflow produces several key outputs, most notably a heatmap for a custom set of genes and a heatmap highlighting the top 20 differentially expressed genes. These visualizations allow researchers to identify expression patterns and sample clusters effectively.

Licensed under the [MIT license](https://opensource.org/licenses/MIT), this tool is a robust solution for Galaxy users looking to streamline their transcriptomic analysis. It integrates standard text processing tools with advanced plotting capabilities to ensure reproducible and publication-ready results.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | DE results | data_input |  |
| 1 | normalized counts | data_input |  |
| 2 | heatmap genes | data_input |  |


Ensure your DE results, normalized counts, and gene lists are in tabular format with consistent gene identifiers to facilitate the internal join and filter operations. Since the workflow processes individual datasets rather than collections, verify that your input files are correctly formatted and uploaded before execution. Consult the README.md for comprehensive details on column indices and specific tool parameters required for the heatmap generation. For automated execution and testing, you can use `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Filter | Filter1 |  |
| 4 | Join two Datasets | join1 |  |
| 5 | Filter | Filter1 |  |
| 6 | Cut | Cut1 |  |
| 7 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy2 |  |
| 8 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy2 |  |
| 9 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.9+galaxy0 |  |
| 10 | Select first | Show beginning1 |  |
| 11 | Select first | Show beginning1 |  |
| 12 | Select last | Show tail1 |  |
| 13 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.2.0+galaxy1 |  |
| 14 | Join two Datasets | join1 |  |
| 15 | Concatenate datasets | cat1 |  |
| 16 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy2 |  |
| 17 | Cut | Cut1 |  |
| 18 | Join two Datasets | join1 |  |
| 19 | Cut | Cut1 |  |
| 20 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.2.0+galaxy1 |  |
| 21 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.2.0+galaxy1 |  |
| 22 | Cut | Cut1 |  |
| 23 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.2.0+galaxy1 |  |
| 24 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.2.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 13 | heatmap custom genes | output1 |
| 20 | heatmap top 20 genes | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run rna-seq-viz-with-heatmap2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run rna-seq-viz-with-heatmap2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run rna-seq-viz-with-heatmap2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init rna-seq-viz-with-heatmap2.ga -o job.yml`
- Lint: `planemo workflow_lint rna-seq-viz-with-heatmap2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `rna-seq-viz-with-heatmap2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)