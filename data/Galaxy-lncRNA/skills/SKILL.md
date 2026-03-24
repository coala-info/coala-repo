---
name: lncrna
description: "This Galaxy workflow processes BAM file collections and sample matrices to analyze RNA-seq data using lnctools and interaction analysis subworkflows for mRNA, lncRNA, and miRNA profiling. Use this skill when you need to identify novel long non-coding RNAs and characterize their expression patterns and interactions with mRNA and miRNA from transcriptomic data."
homepage: https://workflowhub.eu/workflows/199
---

# lncRNA

## Overview

This Galaxy workflow provides a comprehensive pipeline for the analysis of RNA-seq data, specifically targeting mRNA, lncRNA, and miRNA. Starting from BAM file collections and a sample matrix, it automates the transition from raw sequence alignments to integrated transcriptomic insights.

The core processing involves specialized subworkflows that utilize `lnctools` to identify novel lncRNAs and prepare data for differential expression analysis. The pipeline processes multiple BAM lists in parallel, performing transcript splitting and categorization before aggregating the results through a series of column-binding operations to consolidate count data.

In the final stages, the workflow merges these matrices to facilitate a holistic view of the transcriptome. It concludes with a dedicated subworkflow designed to identify interactions between different RNA species based on the generated count matrices, allowing researchers to explore the regulatory landscape of their samples.

This workflow is licensed under [GPL-3.0-or-later](https://spdx.org/licenses/GPL-3.0-or-later.html) and is optimized for high-throughput quantification and interaction modeling across diverse RNA biotypes.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | BAM 1 list | data_collection_input |  |
| 1 | BAM 2 list | data_collection_input |  |
| 2 | SAMPLES MATRIX | data_input |  |


Ensure your input BAM files are organized into two distinct data collections representing your experimental groups, while the sample matrix must be provided as a single tabular dataset. Verify that the identifiers in your sample matrix match the element names within the BAM collections to ensure successful merging during the binding and interaction analysis steps. For comprehensive details on metadata requirements and reference genome compatibility, refer to the `README.md` file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined configuration of these inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | List lnctools split_before_diffExp_and_novel_lncRNA (START FROM BAM) | (subworkflow) |  |
| 4 | List lnctools split_before_diffExp_and_novel_lncRNA (START FROM BAM) | (subworkflow) |  |
| 5 | Cbind_fileList | cbind_fileList |  |
| 6 | Cbind_fileList | cbind_fileList |  |
| 7 | Cbind_fileList | cbind_fileList |  |
| 8 | Cbind_fileList | cbind_fileList |  |
| 9 | Cbind_fileList | cbind_fileList |  |
| 10 | Cbind_fileList | cbind_fileList |  |
| 11 | Cbind | cbind |  |
| 12 | Cbind | cbind |  |
| 13 | Cbind | cbind |  |
| 14 | interactions from count matrices!  | (subworkflow) |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run lncRNA.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run lncRNA.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run lncRNA.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init lncRNA.ga -o job.yml`
- Lint: `planemo workflow_lint lncRNA.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `lncRNA.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
