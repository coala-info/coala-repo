---
name: tutorial-workflow
description: This Galaxy workflow processes an input dataset collection by reversing the line order with the tac tool and extracting the top lines using the Select first tool. Use this skill when you need to isolate the final entries of a dataset or perform basic text manipulation on large collections of genomic or tabular data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# tutorial-workflow

## Overview

This [Galaxy](https://usegalaxy.org/) workflow serves as a foundational tutorial example, likely associated with the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/). It is designed to demonstrate basic text manipulation and tool sequencing within the Galaxy interface, specifically focusing on processing dataset collections.

The pipeline begins by taking an **Input dataset collection** and passing it through the [tac](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_tac/1.1.0) tool. This step reverses the order of lines in the input files, a common utility for reorienting text-based data.

In the final stage, the workflow utilizes the **Select first** tool to extract the top lines from the reversed output. The resulting "First lines" dataset is marked as the primary workflow output, providing a quick summary or subset of the processed collection for further inspection.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset collection | data_collection_input |  |


Ensure your input data is organized into a dataset collection containing text or tabular files to ensure compatibility with the text processing tools. Using a collection rather than individual datasets allows the workflow to process multiple files simultaneously through the tac and selection steps. For comprehensive details on data structure and specific parameter settings, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a job.yml file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | tac | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_tac/1.1.0 |  |
| 2 | Select first | Show beginning1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | First lines | out_file1 |


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