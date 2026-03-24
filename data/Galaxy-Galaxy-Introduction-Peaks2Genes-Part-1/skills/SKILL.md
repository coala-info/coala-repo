---
name: galaxy-introduction-peaks2genes-part-1
description: "This genomics workflow processes peak and gene datasets using text manipulation, flanking region extraction, and interval intersection to identify overlaps between regulatory regions and genetic features. Use this skill when you need to map genomic peaks to their nearest genes or calculate the distribution of identified binding sites across different chromosomes."
homepage: https://workflowhub.eu/workflows/1478
---

# Galaxy Introduction Peaks2Genes - Part 1

## Overview

This workflow provides an introductory pipeline for mapping genomic peaks to their corresponding genes, based on the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorial "Introduction to Peaks2Genes." It is designed to teach foundational bioinformatics skills, such as manipulating genomic intervals and performing spatial joins between different datasets.

The process begins by taking two primary inputs: a set of genomic peaks and a reference list of genes. The workflow employs several text processing tools to clean and reformat the data, ensuring consistent chromosome naming and column structures. A key step involves generating flanking regions around the gene coordinates to define potential regulatory areas, which are then converted into the BED format for standardized analysis.

In the final stages, the workflow uses the Intersect tool to identify overlaps between the processed peaks and the gene flanking regions. These results are then aggregated using the Group tool to produce a summary count of peaks per chromosome (`chr_count`). This allows users to visualize the distribution of genomic features and understand the spatial relationship between peaks and genes.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Peaks | data_input |  |
| 1 | Genes | data_input |  |


Ensure your input files for Peaks and Genes should be formatted as BED or interval data to ensure compatibility with the intersection and flanking tools. While these inputs are typically uploaded as individual datasets, you may organize them into collections if you are scaling the analysis for multiple samples. Consult the README.md for exhaustive documentation on the required genomic coordinates and metadata structure. For automated execution, you can use `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Select last | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_tail_tool/1.1.0 |  |
| 3 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 4 | Get flanks | toolshed.g2.bx.psu.edu/repos/devteam/get_flanks/get_flanks1/1.0.0 |  |
| 5 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 6 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 7 | Convert Genomic Intervals To BED | CONVERTER_interval_to_bed_0 |  |
| 8 | Intersect | toolshed.g2.bx.psu.edu/repos/devteam/intersect/gops_intersect_1/1.0.0 |  |
| 9 | Group | Grouping1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | chr_count | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-introduction-peaks2genes-part-1-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-introduction-peaks2genes-part-1-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-introduction-peaks2genes-part-1-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-introduction-peaks2genes-part-1-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-introduction-peaks2genes-part-1-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-introduction-peaks2genes-part-1-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
