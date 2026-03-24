---
name: rna-seq-counts-to-genes
description: "This transcriptomics workflow processes RNA-seq count data and sample information using annotateMyIDs for gene annotation and limma for differential expression analysis. Use this skill when you need to convert raw transcriptomic count matrices into annotated gene lists and identify differentially expressed genes across different experimental conditions."
homepage: https://workflowhub.eu/workflows/1703
---

# RNA Seq Counts To Genes

## Overview

This workflow is designed for transcriptomics analysis, specifically transforming raw RNA-seq count data into gene-level differential expression results. It requires two primary inputs: a count matrix (`seqdata`) and a metadata file describing the experimental design (`sampleinfo`).

The pipeline begins with several text processing steps—including [Cut](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0), [Merge Columns](https://toolshed.g2.bx.psu.edu/repos/devteam/merge_cols/mergeCols1/1.0.1), and [Replace Text](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.1)—to clean and format the input data. It then utilizes [annotateMyIDs](https://toolshed.g2.bx.psu.edu/repos/iuc/annotatemyids/annotatemyids/3.5.0.1) to map biological identifiers, ensuring the data is correctly annotated with gene symbols or relevant IDs.

The core statistical analysis is performed using the [limma-voom](https://toolshed.g2.bx.psu.edu/repos/iuc/limma_voom/limma_voom/3.34.9.9) tool. This step handles normalization and linear modeling to identify differentially expressed genes across the provided samples. This workflow is a standard component of [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) materials for transcriptomics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | seqdata | data_input |  |
| 1 | sampleinfo | data_input |  |


Ensure your `seqdata` is a tabular count matrix and `sampleinfo` is a tab-separated file containing experimental metadata. Verify that the sample identifiers in both files match exactly to avoid errors during the limma and annotation steps. For complex runs, you may use `planemo workflow_job_init` to create a `job.yml` file for streamlined execution. Consult the `README.md` for comprehensive details on column formatting and required ID types.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 3 | Merge Columns | toolshed.g2.bx.psu.edu/repos/devteam/merge_cols/mergeCols1/1.0.1 |  |
| 4 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.1 |  |
| 5 | Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 6 | annotateMyIDs | toolshed.g2.bx.psu.edu/repos/iuc/annotatemyids/annotatemyids/3.5.0.1 |  |
| 7 | limma | toolshed.g2.bx.psu.edu/repos/iuc/limma_voom/limma_voom/3.34.9.9 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run rna-seq-counts-to-genes.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run rna-seq-counts-to-genes.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run rna-seq-counts-to-genes.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init rna-seq-counts-to-genes.ga -o job.yml`
- Lint: `planemo workflow_lint rna-seq-counts-to-genes.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `rna-seq-counts-to-genes.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
