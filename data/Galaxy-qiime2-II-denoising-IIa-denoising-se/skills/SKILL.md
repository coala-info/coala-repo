---
name: qiime2-iia-denoising-sequence-quality-control-and-feature-ta
description: "This Galaxy workflow utilizes DADA2 to process demultiplexed single-end amplicon sequences and metadata into denoised feature tables and representative sequences. Use this skill when you need to perform sequence quality control by correcting Illumina errors, filtering chimeras, and identifying amplicon sequence variants for downstream microbial community profiling."
homepage: https://workflowhub.eu/workflows/892
---

# QIIME2 IIa: Denoising (sequence quality control) and feature table creation (single-end)

## Overview

This workflow performs sequence quality control and feature table creation for single-end Illumina amplicon data. It utilizes the [DADA2](https://github.com/benjjneb/dada2) pipeline via the `q2-dada2` plugin to detect and correct sequencing errors, filter phiX reads, and remove chimeric sequences.

Users provide demultiplexed sequences and a metadata table, along with specific parameters for truncation and trimming lengths. These parameters are essential for the DADA2 algorithm to accurately model sequencing errors and produce high-quality representative sequences.

The process executes `qiime2 dada2 denoise-single` followed by several steps to generate both data artifacts and visualizations. Key outputs include a denoising table, a list of representative sequences, and detailed denoising statistics. Each output is paired with a corresponding visualization (qzv) to facilitate data exploration and quality assessment. This workflow is released under an MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Metadata | data_input | Tab separated metadata file |
| 1 | Demultiplexed sequences | data_input | Demultiplexed sequences in qza format |
| 2 | Truncation length | parameter_input | Length to which the sequence sould be truncated. Will remove bases from the 3' end. |
| 3 | Trimming length | parameter_input | Number of bases at the 5' end that should be removed. Default: 0. |


Ensure your demultiplexed sequences are provided as a QIIME2 artifact (`.qza`) and your metadata as a standard tabular file (`.tsv` or `.tabular`). For single-end data, verify that truncation and trimming parameters are set based on your specific sequence quality profiles to ensure optimal DADA2 performance. While individual datasets can be used, organizing inputs into collections simplifies the management of multiple samples across the denoising steps. Refer to the `README.md` for comprehensive details on parameter selection and file preparation. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | qiime2 dada2 denoise-single | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__dada2__denoise_single/qiime2__dada2__denoise_single/2024.10.0+q2galaxy.2024.10.0 | qiime2 dada2 denoise-paired Denoise and dereplicate paired-end sequences Small insight: if the denoising percentage is lower or poorer, reduce 'trunc_q: Int' from 2 to 1. |
| 5 | qiime2 feature-table tabulate-seqs | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__feature_table__tabulate_seqs/qiime2__feature_table__tabulate_seqs/2024.10.0+q2galaxy.2024.10.0 | qiime2 feature-table tabulate-seqs View sequence associated with each feature |
| 6 | qiime2 metadata tabulate | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__metadata__tabulate/qiime2__metadata__tabulate/2024.10.0+q2galaxy.2024.10.0 | qiime2 metadata tabulate Interactively explore Metadata in a table |
| 7 | qiime2 feature-table summarize | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__feature_table__summarize/qiime2__feature_table__summarize/2024.10.0+q2galaxy.2024.10.0 | qiime2 feature-table summarize Summarize table |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Denoising output table | table |
| 4 | Representative denoised sequences | representative_sequences |
| 4 | Denoising statistics | denoising_stats |
| 5 | DADA2 representative sequences list visualisation | visualization |
| 6 | DADA2 statistics visualisation | visualization |
| 7 | DADA2 output table | visualization |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run QIIME2-IIa-denoising-and-feature-table-creation-single-end.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run QIIME2-IIa-denoising-and-feature-table-creation-single-end.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run QIIME2-IIa-denoising-and-feature-table-creation-single-end.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init QIIME2-IIa-denoising-and-feature-table-creation-single-end.ga -o job.yml`
- Lint: `planemo workflow_lint QIIME2-IIa-denoising-and-feature-table-creation-single-end.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `QIIME2-IIa-denoising-and-feature-table-creation-single-end.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
