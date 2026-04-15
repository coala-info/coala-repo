---
name: circos-nature-workflow
description: This Galaxy workflow generates high-quality circular visualizations of genomic data using the Circos tool based on chromosome and highlight input files. Use this skill when you need to create publication-quality circular plots to visualize genomic features, structural variations, or comparative genomics data across different chromosomes.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# circos-nature-workflow

## Overview

This workflow provides a streamlined approach for creating high-quality circular genomic visualizations using [Circos](http://circos.ca/). Based on [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials, it is designed to help researchers generate publication-ready figures that represent complex relationships between genomic intervals.

The process requires two primary tabular inputs: a chromosome definition file (`chrom.tab`) and a highlights file (`highlights.tab`). These inputs are processed through two [Circos](https://toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12) tool steps, which configure the ideogram layout and layer specific data highlights to emphasize regions of interest.

Licensed under [AGPL-3.0-or-later](https://spdx.org/licenses/AGPL-3.0-or-later.html), this workflow is a valuable resource for users looking to automate the generation of sophisticated circular plots within the Galaxy ecosystem. For detailed setup instructions and configuration parameters, please refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | chrom.tab | data_input |  |
| 1 | highlights.tab | data_input |  |


Ensure your chromosome definitions and highlight data are formatted as tabular (.tab) files, adhering strictly to the Circos-specific column requirements for coordinates and labels. While this workflow uses individual datasets for the primary inputs, you can organize multiple tracks into collections if scaling to more complex visualizations. Refer to the accompanying README.md for comprehensive details on the specific column headers and data structures required for these inputs. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12 |  |
| 3 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy12 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run nature-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run nature-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run nature-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init nature-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint nature-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `nature-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)