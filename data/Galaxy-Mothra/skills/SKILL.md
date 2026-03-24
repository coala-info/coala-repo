---
name: mothra-test
description: "This Galaxy workflow processes an input dataset collection using the Mothra sdr_mothra tool to generate images and reports, then packages the results into an RO-Crate. Use this skill when you need to perform automated image analysis or data reduction on a collection of datasets and require standardized metadata packaging for research transparency."
homepage: https://workflowhub.eu/workflows/413
---

# Mothra Test

## Overview

The Mothra Test workflow is a specialized Galaxy pipeline designed to process dataset collections through the [mothra](https://github.com/mothra) analysis suite. It streamlines the transition from raw data collections to structured research outputs by automating the execution of the `sdr_mothra` tool.

The core of the workflow involves generating two primary scientific outputs: a Mothra image and a comprehensive Mothra report. These files provide the visual and analytical data necessary for interpreting the results of the SDR (Software Defined Radio) processing tasks handled by the tool.

In the final stage, the workflow utilizes the `save_output_rocrate` tool to package the generated images and reports. This ensures that all results are bundled into a standardized [RO-Crate](https://www.researchobject.org/ro-crate/) format, enhancing the reproducibility and portability of the research data for further sharing or archival.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset collection | data_collection_input |  |


Ensure your input is a dataset collection containing the raw image files required for the mothra tool, typically in standard image formats. Using a collection allows for batch processing of multiple samples through the sdr_mothra step simultaneously. Refer to the included README.md for comprehensive details on specific parameter configurations and data structure requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | mothra | sdr_mothra |  |
| 2 | Save as RO Crate | save_output_rocrate |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Mothra image | Mothra image |
| 1 | Mothra report | Mothra report |
| 2 | ROCrate output | ROCrate |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Mothra_Test.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Mothra_Test.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Mothra_Test.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Mothra_Test.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Mothra_Test.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Mothra_Test.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
