---
name: erga-dataqc-ont-v2505-wf0
description: "This ERGA workflow performs quality control on Oxford Nanopore (ONT) raw sequencing reads using NanoPlot and SeqKit statistics to assess read length and quality distributions. Use this skill when you need to evaluate the technical success of a long-read sequencing run and ensure the data meets the quality standards required for high-quality reference genome assembly."
homepage: https://workflowhub.eu/workflows/697
---

# ERGA DataQC ONT v2505 (WF0)

## Overview

This workflow is designed for the initial quality control (QC) of Oxford Nanopore Technologies (ONT) raw reads, serving as the "WF0" stage within the [ERGA](https://www.erga-biodiversity.eu/) (European Reference Genome Atlas) sequencing pipeline. It accepts a collection of raw ONT reads as input to provide a standardized assessment of sequencing quality and data characteristics.

The pipeline utilizes [NanoPlot](https://github.com/wdecoster/NanoPlot) to generate high-quality visualizations and descriptive statistics, such as read length distributions and mean quality scores. In parallel, [SeqKit statistics](https://bioinf.shenwei.me/seqkit/) is employed to produce a comprehensive numerical summary of the dataset, including total bases, N50 values, and GC content.

To streamline the output, the workflow uses the Collapse Collection tool to aggregate results into a manageable format. This ensures that researchers can quickly validate the integrity of their long-read data before proceeding to assembly or more complex downstream analyses.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ONT raw reads collection | data_collection_input |  |


This workflow requires ONT raw reads provided as a list of datasets, typically in fastq.gz or fastq format. Ensure your input collection is properly organized to allow NanoPlot and SeqKit to process multiple flowcells or libraries simultaneously. Refer to the accompanying README.md for specific metadata requirements and detailed parameter configurations. You can automate the setup of these inputs using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.44.1+galaxy0 |  |
| 2 | SeqKit statistics | toolshed.g2.bx.psu.edu/repos/iuc/seqkit_stats/seqkit_stats/2.10.0+galaxy0 |  |
| 3 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_DataQC_ONT_v2505_(WF0).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_DataQC_ONT_v2505_(WF0).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_DataQC_ONT_v2505_(WF0).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_DataQC_ONT_v2505_(WF0).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_DataQC_ONT_v2505_(WF0).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_DataQC_ONT_v2505_(WF0).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
