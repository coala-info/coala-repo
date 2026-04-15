---
name: select-first-n-lines
description: This Galaxy workflow extracts a specified number of initial rows from an input dataset using the text processing head tool. Use this skill when you need to preview the structure of large data files or subset a ranked list to focus on the top-scoring biological features.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# select-first-n-lines

## Overview

This Galaxy workflow provides a streamlined method for extracting a specific number of lines from the beginning of a dataset. It utilizes the [Select first](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_head_tool/1.1.0) tool (tp_head_tool) to perform a standard "head" operation, which is a fundamental task for previewing large files or subsetting data for preliminary analysis.

The workflow is designed to demonstrate the use of workflow parameters within the Galaxy interface. It takes a single input dataset and allows the user to define the number of lines to be kept at runtime. This flexibility makes it a practical example for those following [GTN](https://training.galaxyproject.org/) tutorials on managing dynamic tool settings.

The final output is a filtered dataset containing only the specified initial records. This process is essential for bioinformaticians who need to isolate headers or sample data from large genomic files without processing the entire document.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset | data_input |  |


Ensure the input file is in a line-based format such as tabular, CSV, or plain text to ensure the tool processes the rows correctly. While this workflow is configured for a single dataset, you can easily run it across a collection using the Galaxy map-over feature. For comprehensive configuration details and parameter explanations, refer to the accompanying README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Select first | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_head_tool/1.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | outfile | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run cut-n-lines.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run cut-n-lines.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run cut-n-lines.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init cut-n-lines.ga -o job.yml`
- Lint: `planemo workflow_lint cut-n-lines.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `cut-n-lines.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)