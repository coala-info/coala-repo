---
name: circos-tutorial
description: "This workflow processes genomic karyotype data using text manipulation tools and the Circos engine to generate complex circular visualizations of biological data. Use this skill when you need to create high-quality circular plots to represent genomic features, relationships, or structural variations across a reference genome."
homepage: https://workflowhub.eu/workflows/1413
---

# Circos tutorial

## Overview

This workflow provides a comprehensive guide to creating complex circular genomic visualizations using [Circos](http://circos.ca/). It utilizes a human genome karyotype (`hg18_karyotype.txt`) as the primary input, which defines the axes and structural framework for the resulting circular plots.

The process begins with several data manipulation steps to prepare genomic features for display. Using tools such as `Grep`, `Cut`, and `Remove beginning`, the workflow filters and formats raw data into compatible inputs. It also incorporates `Select random lines` to sample data points, ensuring the final visualizations remain clear and interpretable.

The core of the workflow consists of multiple [Circos](https://usegalaxy.eu/root?tool_id=toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12) tool executions that iteratively build layers of information. These steps demonstrate how to overlay different data types—such as links, tiles, or histograms—onto the genomic coordinates to create publication-quality figures.

Developed as part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), this tutorial is licensed under AGPL-3.0-or-later. It serves as a practical template for researchers to learn advanced visualization techniques within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | hg18_karyotype.txt | data_input |  |


To prepare for this workflow, ensure your primary input is a valid karyotype file in tabular text format, as Circos requires specific coordinate definitions to initialize the visualization. While this tutorial focuses on individual datasets, you can adapt the process for multiple tracks by organizing genomic intervals into data collections. Refer to the README.md for comprehensive details on data formatting and parameter settings for each Circos iteration. You may also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Remove beginning | Remove beginning1 |  |
| 2 | Remove beginning | Remove beginning1 |  |
| 3 | Select | Grep1 |  |
| 4 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12 |  |
| 5 | Cut | Cut1 |  |
| 6 | Select random lines | random_lines1 |  |
| 7 | Cut | Cut1 |  |
| 8 | Select random lines | random_lines1 |  |
| 9 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12 |  |
| 10 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12 |  |
| 11 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12 |  |
| 12 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12 |  |
| 13 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12 |  |
| 14 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12 |  |
| 15 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12 |  |
| 16 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12 |  |


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
