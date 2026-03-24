---
name: blockclust-110-clustering
description: "This transcriptomics workflow processes small non-coding RNA sequencing data using Samtools, blockbuster, and BlockClust to perform model-based clustering and classification. Use this skill when you need to identify and categorize small non-coding RNA species from deep sequencing data by analyzing read mapping patterns into discrete blocks and clusters."
homepage: https://workflowhub.eu/workflows/1671
---

# Blockclust 1.1.0 Clustering

## Overview

This workflow provides a streamlined pipeline for the classification and clustering of small non-coding RNAs (sncRNAs) using [BlockClust](https://toolshed.g2.bx.psu.edu/repos/rnateam/blockclust/blockclust/1.1.0). It is designed to process transcriptomics data by analyzing the spatial expression patterns (block signals) of mapped reads to identify and categorize various RNA species.

The process begins by organizing input data with [Samtools sort](https://toolshed.g2.bx.psu.edu/repos/devteam/samtools_sort/samtools_sort/2.0.2) and initial BlockClust processing. It then utilizes [blockbuster](https://toolshed.g2.bx.psu.edu/repos/rnateam/blockbuster/blockbuster/0.1.2) to detect read clusters, which are subsequently refined through model-based predictions. This approach allows for the robust detection of ncRNA transcripts even in the absence of sequence homology.

The workflow generates several key outputs, including BED files for tags, clusters, and model-based predictions. These results are highly relevant for researchers following [GTN](https://training.galaxyproject.org/) tutorials or conducting advanced transcriptomics studies to discover novel non-coding RNA elements.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | blockclust_input | data_input |  |


Ensure your primary input is a BAM file containing mapped small RNA reads, as the workflow begins with a Samtools sorting step. While individual datasets are compatible, utilizing dataset collections is highly recommended for efficiently managing multiple samples and their corresponding outputs. Please consult the `README.md` for exhaustive details on specific parameter settings and reference requirements. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Samtools sort | toolshed.g2.bx.psu.edu/repos/devteam/samtools_sort/samtools_sort/2.0.2 |  |
| 2 | BlockClust | toolshed.g2.bx.psu.edu/repos/rnateam/blockclust/blockclust/1.1.0 |  |
| 3 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 4 | blockbuster | toolshed.g2.bx.psu.edu/repos/rnateam/blockbuster/blockbuster/0.1.2 |  |
| 5 | BlockClust | toolshed.g2.bx.psu.edu/repos/rnateam/blockclust/blockclust/1.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | tags_bed | tags_bed |
| 4 | blockbuster_out | output |
| 5 | model_based_pred_bed | model_based_pred_bed |
| 5 | clusters_bed | clusters |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run blockclust-clustering.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run blockclust-clustering.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run blockclust-clustering.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init blockclust-clustering.ga -o job.yml`
- Lint: `planemo workflow_lint blockclust-clustering.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `blockclust-clustering.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
