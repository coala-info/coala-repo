---
name: find-exons-with-the-highest-number-of-features
description: "This genomic workflow identifies exons with the highest number of overlapping features by processing exon and feature datasets using bedtools Intersect, Datamash, and sorting utilities. Use this skill when you need to prioritize specific genomic regions based on the density of overlapping biological annotations or experimental signals."
homepage: https://workflowhub.eu/workflows/1493
---

# Find exons with the highest number of features

## Overview

This workflow provides an introductory demonstration of genomic data analysis, specifically designed to identify which exons in a dataset contain the highest number of overlapping features. It serves as the foundational "Galaxy 101" tutorial within the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), teaching users how to join and manipulate datasets based on genomic coordinates.

The process begins by taking two inputs—Exons and Features—and performing a [bedtools Intersect](https://bedtools.readthedocs.io/en/latest/content/tools/intersect.html) to find all overlapping regions. It then utilizes [Datamash](https://www.gnu.org/software/datamash/) to aggregate the results, counting the number of feature overlaps for each individual exon.

In the final stages, the workflow sorts the aggregated data to rank exons by their feature count and uses the "Select first" tool to isolate the top results. The final output, `top_5_exons`, is generated after a comparison step to ensure data integrity. This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is a standard starting point for learning Galaxy-based bioinformatics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Exons | data_input | Input exons file |
| 1 | Features | data_input | Input features file |


Ensure your input files for exons and features are in BED or GTF format to maintain compatibility with the bedtools Intersect step. While this workflow typically uses individual datasets, you may utilize dataset collections if you intend to scale the analysis across multiple samples. Please consult the README.md for exhaustive documentation on data preparation and specific tool configurations. For automated execution, you can generate a template `job.yml` using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | bedtools Intersect intervals | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_intersectbed/2.31.1+galaxy0 |  |
| 3 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.8+galaxy0 |  |
| 4 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy0 |  |
| 5 | Select first | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_head_tool/9.5+galaxy0 |  |
| 6 | Compare two Datasets | comp1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | top_5_exons | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-intro-101-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-intro-101-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-intro-101-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-intro-101-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-intro-101-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-intro-101-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
