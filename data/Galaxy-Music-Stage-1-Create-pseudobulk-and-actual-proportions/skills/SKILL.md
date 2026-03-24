---
name: music-stage-1-create-pseudobulk-and-actual-proportions
description: "This Galaxy workflow processes expression data and metadata using Awk and MuSiC-based subworkflows to generate pseudobulk profiles and their corresponding ground-truth cell type proportions. Use this skill when you need to benchmark deconvolution algorithms by creating synthetic bulk datasets from single-cell RNA sequencing data with known cell type compositions."
homepage: https://workflowhub.eu/workflows/1563
---

# Music Stage 1 - Create pseudobulk and actual proportions

## Overview

This Galaxy workflow facilitates the initial stage of a deconvolution evaluation pipeline by generating synthetic datasets from single-cell RNA-seq data. It processes expression matrices and metadata to create "pseudobulk" samples—simulated bulk transcriptomes—alongside the ground-truth cell type proportions required for benchmarking.

The workflow accepts expression data and metadata as collection inputs, utilizing specific Awk parameters to standardize and manipulate headers for both "actual" and "infer" data structures. This ensures that the resulting datasets are correctly formatted for downstream estimation tools and comparative analysis.

Structurally, the workflow leverages subworkflows to handle data collections in parallel, streamlining the creation of multiple evaluation scenarios. It is a core component of the [deconv-eval](https://github.com/galaxyproject/training-material) framework, providing the foundational data needed to validate the accuracy of cell-type deconvolution algorithms like MuSiC.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Awk- actual header (A) | parameter_input | BEGIN { print "A_actual\tcell_type" } { print $0 } |
| 1 | Awk - infer header (A) | parameter_input | BEGIN { print "0\tA_infer\t0" } NR &gt; 1 {print $0 } |
| 2 | Metadata | data_collection_input |  |
| 3 | Expression Data | data_collection_input |  |
| 4 | Awk - actual header (B) | parameter_input | BEGIN { print "B_actual\tcell_type" } { print $0 } |
| 5 | Awk - infer header (B) | parameter_input | BEGIN { print "0\tB_infer\t0" } NR &gt; 1 {print $0 } |


Ensure your expression and metadata files are formatted as TSV and organized into data collections to facilitate the automated generation of pseudobulk profiles across multiple samples. Using collections instead of individual datasets is required for the subworkflows to correctly map cell type proportions to their respective expression matrices. Please consult the README.md for precise instructions on the metadata column headers and the specific Awk parameters needed for data cleaning. You can streamline the configuration of these inputs by using `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | (Collections Test) Create pseudobulk and actual proportions (child) | (subworkflow) |  |
| 7 | (Collections Test) Create pseudobulk and actual proportions (child) | (subworkflow) |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run deconv-eval-stage-1-create-data.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run deconv-eval-stage-1-create-data.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run deconv-eval-stage-1-create-data.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init deconv-eval-stage-1-create-data.ga -o job.yml`
- Lint: `planemo workflow_lint deconv-eval-stage-1-create-data.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `deconv-eval-stage-1-create-data.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
