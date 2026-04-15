---
name: celseq2-multi-batch-mm10
description: This transcriptomics workflow processes multiple batches of single-cell RNA sequencing data from FACS-sorted mouse cells using the CelSeq2 pipeline and UCSC GTF annotations to generate a consolidated expression matrix. Use this skill when you need to perform demultiplexing, mapping, and quantification across several sequencing runs to analyze gene expression profiles in mouse tissues.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# celseq2-multi-batch-mm10

## Overview

This workflow is designed for the automated pre-processing of single-cell RNA-seq (scRNA-seq) data generated using the CelSeq2 protocol. Specifically tailored for the *Mus musculus* (mm10) genome, it streamlines the transition from raw sequencing reads to a structured expression matrix, following standard [Transcriptomics](https://training.galaxyproject.org/training-material/topics/transcriptomics/) best practices established by the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/).

The pipeline processes multiple batches by accepting a collection of FACS pairs, a barcode whitelist, and a UCSC GTF annotation file. The workflow begins by flattening the input collection to ensure compatibility with the core processing engine: a specialized subworkflow titled "CelSeq2: Single Batch mm10." This subworkflow handles the heavy lifting of read alignment and feature quantification for each individual sample or batch.

In the final stage, the workflow aggregates the results from all processed batches using a column join tool. This produces a single, consolidated tabular output representing the gene expression matrix across the entire experiment. This output is formatted for immediate use in downstream analysis, such as clustering, visualization, or differential expression studies.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | List of FACS pairs | data_collection_input |  |
| 1 | Barcodes | data_input |  |
| 2 | GTF file (UCSC) | data_input |  |


Ensure your sequencing data is organized as a list of paired-end FASTQ collections, while the barcode and UCSC GTF files should be provided as individual tabular and GTF datasets respectively. Verify that the barcode file matches the expected CelSeq2 format to prevent downstream mapping errors during the subworkflow execution. Consult the included README.md for specific instructions on preparing the FACS pair collection and metadata requirements. You can automate the configuration of these inputs by using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Flatten Collection | __FLATTEN__ |  |
| 4 | CelSeq2: Single Batch mm10 | (subworkflow) |  |
| 5 | Column Join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | tabular_output | tabular_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run scrna-mp-celseq.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run scrna-mp-celseq.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run scrna-mp-celseq.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init scrna-mp-celseq.ga -o job.yml`
- Lint: `planemo workflow_lint scrna-mp-celseq.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `scrna-mp-celseq.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)