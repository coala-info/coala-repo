---
name: average-bigwig-between-replicates
description: This Galaxy workflow processes a collection of normalized BigWig files by grouping them based on sample name suffixes and calculating an average coverage track using deepTools bigwigAverage. Use this skill when you need to merge biological replicates into a single representative coverage profile per experimental condition for downstream visualization or comparative genomics.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# average-bigwig-between-replicates

## Overview

This Galaxy workflow automates the generation of average coverage tracks from multiple biological replicates. It is designed to process a single collection of normalized BigWig files, provided that the file identifiers follow a specific naming convention (e.g., `sample_name_replicateID`).

The process begins by applying rules to restructure the input collection into a nested list, grouping replicates under their respective sample names based on the last underscore in the identifier. It then utilizes the [deeptools_bigwig_average](https://toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bigwig_average/deeptools_bigwig_average/3.5.4+galaxy0) tool to calculate the mean coverage for each group.

Users can configure the `bin_size` parameter to balance output resolution against file size and computation time; smaller values (e.g., 5bp) are recommended for high-resolution data like RNA-seq, while larger values (e.g., 50bp) are suitable for broader applications. The final output is a collection of averaged BigWig files named by their parent sample.

Detailed instructions on file naming and preparation can be found in the [README.md](README.md) in the Files section. This workflow is released under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Bigwig to average | data_collection_input | We assume the identifiers are like: sample_name_replicateID |
| 1 | bin_size | parameter_input | Bin size for normalized bigwig (usually 5bp is sufficient for RNA-seq and 50bp for ChIP/CUTandRUN/ATAC) |


Ensure your input is a single collection of BigWig files with identifiers formatted as `sample_name_replicateID`, as the workflow uses the final underscore to group replicates for averaging. Use a smaller bin size (e.g., 5bp) for high-resolution RNA-seq data or a larger value (e.g., 50bp) to reduce file size and computation time for other applications. For automated testing or local execution, you can initialize a job configuration using `planemo workflow_job_init` to create a `job.yml` file. Refer to the README.md for comprehensive details on identifier naming conventions and collection restructuring.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Apply rules | __APPLY_RULES__ |  |
| 3 | bigwigAverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bigwig_average/deeptools_bigwig_average/3.5.4+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | average_bigwigs | outFileName |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run average-bigwig-between-replicates.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run average-bigwig-between-replicates.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run average-bigwig-between-replicates.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init average-bigwig-between-replicates.ga -o job.yml`
- Lint: `planemo workflow_lint average-bigwig-between-replicates.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `average-bigwig-between-replicates.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)