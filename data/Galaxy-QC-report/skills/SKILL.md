---
name: qc-report
description: "This transcriptomics workflow processes BAM files and reference genes using RSeQC, Picard, and Samtools to generate a comprehensive MultiQC quality control report. Use this skill when you need to evaluate the quality of aligned RNA-seq reads, identify PCR duplicates, and determine the strandedness of your sequencing library."
homepage: https://workflowhub.eu/workflows/1695
---

# QC report

## Overview

This workflow provides a comprehensive quality control (QC) suite for transcriptomics data, specifically designed to follow the [rna-seq-reads-to-counts](https://training.galaxyproject.org/training-material/topics/transcriptomics/tutorials/rna-seq-reads-to-counts/tutorial.html) pipeline. It processes a collection of BAM files and a reference gene file to evaluate the technical quality of RNA-seq alignments.

The process begins by utilizing [Infer Experiment](https://rseqc.sourceforge.net/#infer-experiment-py) to determine the strandedness of the library and [MarkDuplicates](https://broadinstitute.github.io/picard/) to identify PCR or optical duplicates within the reads. Simultaneously, [Samtools idxstats](http://www.htslib.org/doc/samtools-idxstats.html) is employed to generate mapping statistics, providing a breakdown of aligned and unaligned reads across the reference genome.

In the final stage, the workflow uses [MultiQC](https://multiqc.info/) to aggregate the outputs from all previous steps into a single, interactive HTML report. This centralized summary allows researchers to quickly assess library complexity, duplication levels, and mapping distribution, ensuring the data is suitable for downstream differential expression analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Reference genes | data_input |  |
| 1 | BAM files | data_collection_input |  |


Ensure the reference genes are provided in GTF or BED format, while the BAM files must be organized into a data collection to ensure MultiQC correctly aggregates metrics across all samples. Using a collection rather than individual datasets simplifies the workflow execution and maintains sample associations throughout the RSeQC and Picard steps. For comprehensive details on parameter configurations and data requirements, please consult the `README.md` file. You may also use `planemo workflow_job_init` to generate a `job.yml` for streamlined job configuration and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Infer Experiment | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_infer_experiment/2.6.4.1 |  |
| 3 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.1 |  |
| 4 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.2 |  |
| 5 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | stats | stats |
| 5 | html_report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run qc-report.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run qc-report.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run qc-report.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init qc-report.ga -o job.yml`
- Lint: `planemo workflow_lint qc-report.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `qc-report.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
