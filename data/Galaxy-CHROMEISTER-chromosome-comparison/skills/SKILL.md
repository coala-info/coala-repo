---
name: chromeister-chromosome-comparison
description: "This Galaxy workflow performs large-scale comparative genomics by aligning query and reference chromosomes using the CHROMEISTER tool to generate dotplots and detected event reports. Use this skill when you need to visualize synteny, identify large-scale genomic rearrangements, or compare chromosome-level assemblies between different species or strains."
homepage: https://workflowhub.eu/workflows/1545
---

# CHROMEISTER chromosome comparison

## Overview

This Galaxy workflow facilitates the comparative analysis of chromosomes to identify and study large-scale genomic rearrangements. By utilizing [CHROMEISTER](https://toolshed.g2.bx.psu.edu/repos/iuc/chromeister/chromeister/1.5.a), the pipeline performs ultra-fast sensitive comparisons between a query and a reference chromosome, making it a valuable tool for genome annotation and evolutionary genomics.

The process requires two primary inputs: a query chromosome and a reference chromosome. The core tool generates a comprehensive comparison matrix and calculates a similarity score, allowing researchers to visualize synteny and detect structural variations across different scales.

The workflow produces several visualization and data outputs, including a comparison dotplot and a detected events plot for immediate visual inspection of rearrangements. It also provides detailed metainformation, a comparison matrix, and a list of detected events to support further quantitative analysis. This workflow is tagged under Genome-annotation and [GTN](https://training.galaxyproject.org/), reflecting its utility in standardized bioinformatics training and research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Query chromosome | data_input |  |
| 1 | Reference chromosome | data_input |  |


Ensure your query and reference chromosomes are in FASTA format, as CHROMEISTER requires sequence data to generate the comparison matrix and dotplot. While individual datasets are standard for pairwise comparisons, you can utilize dataset collections to batch process multiple chromosome pairs efficiently. Consult the accompanying README.md for comprehensive details on parameter tuning and interpreting the detected events plot. You can also automate test execution and job configuration by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Chromeister | toolshed.g2.bx.psu.edu/repos/iuc/chromeister/chromeister/1.5.a |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Chromeister on input dataset(s): Detected events | output_events |
| 2 | Chromeister on input dataset(s): Comparison metainformation | output_csv |
| 2 | Chromeister on input dataset(s): Comparison dotplot | output_imagen |
| 2 | Chromeister on input dataset(s): Comparison matrix | output |
| 2 | Chromeister on input dataset(s): Comparison score | output_score |
| 2 | Chromeister on input dataset(s): Detected events plot | output_events_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run chromeister-chromosome-comparison.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run chromeister-chromosome-comparison.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run chromeister-chromosome-comparison.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init chromeister-chromosome-comparison.ga -o job.yml`
- Lint: `planemo workflow_lint chromeister-chromosome-comparison.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `chromeister-chromosome-comparison.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
