---
name: partial-de-novo-workflow-ustacks-only
description: "This Galaxy workflow processes RAD-seq dataset collections using the Stacks2 ustacks tool to identify unique loci and SNPs within individual samples for de novo analysis. Use this skill when you need to process specific batches of samples independently while maintaining unique sample identifiers for later integration into a complete de novo assembly pipeline."
homepage: https://workflowhub.eu/workflows/349
---

# Partial de novo workflow: ustacks only

## Overview

This workflow is a specialized component of the [Stacks](http://catchenlab.life.illinois.edu/stacks/) pipeline designed for RAD-seq data analysis on the Galaxy platform. It focuses exclusively on the `ustacks` step, which aligns short-read sequences into sets of exactly matching samples to form stacks and identify genetic loci.

The workflow is particularly useful for processing large datasets in batches. By utilizing the "Start identifier at" option within the `ustacks` processing settings, users can ensure that samples across different runs maintain unique identifying numbers. This allows for the manual merging of multiple `ustacks` outputs into a single dataset collection for subsequent analysis in `cstacks`.

For detailed instructions on managing sample identifiers, unhiding files in the Galaxy history, and preparing inputs for the full de novo pipeline, please refer to the [README.md](README.md) in the Files section. For the complete end-to-end process, see the [full de novo workflow](https://workflowhub.eu/workflows/348).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset collection | data_collection_input |  |


Prepare your input as a dataset collection containing FASTQ files, ensuring all samples are uniquely identified if you plan to merge them with previous runs. When processing multiple batches, adjust the "Start identifier at" setting in the ustacks tool options to avoid overlapping sample IDs. For large-scale automation, you can initialize your configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for detailed instructions on unhiding and rebuilding collections to combine outputs for downstream analysis.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Stacks2: ustacks | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_ustacks/stacks2_ustacks/2.55+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | tabs | tabs |
| 1 | output_log | output_log |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Partial_de_novo_workflow_ustacks_only.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Partial_de_novo_workflow_ustacks_only.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Partial_de_novo_workflow_ustacks_only.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Partial_de_novo_workflow_ustacks_only.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Partial_de_novo_workflow_ustacks_only.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Partial_de_novo_workflow_ustacks_only.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
