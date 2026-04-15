---
name: short-read-quality-control-and-trimming
description: This Galaxy workflow processes paired-end Illumina fastq files using fastp for quality control and trimming, followed by MultiQC for aggregate reporting. Use this skill when you need to assess raw sequencing data quality and remove low-quality bases or adapters to prepare genomic and transcriptomic reads for downstream analysis.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# short-read-quality-control-and-trimming

## Overview

This Galaxy workflow provides an automated solution for the essential preprocessing of paired-end Illumina short-read data. It is designed to assess raw sequence quality and remove low-quality bases or adapter sequences, ensuring that downstream analyses in genomics and transcriptomics are based on reliable data.

The pipeline utilizes [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.1.0+galaxy0) to perform integrated quality profiling, adapter trimming, and read filtering based on user-defined quality scores and length thresholds. Following the trimming process, [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.33+galaxy0) aggregates the individual sample reports into a single, comprehensive HTML summary for easy visualization of the library statistics.

The workflow outputs include the trimmed fastq(.gz) files ready for assembly or mapping, along with detailed JSON reports and the final MultiQC dashboard. For specific details on input parameters and file preparation, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Raw reads | data_collection_input | Raw reads as paired-end collection |
| 1 | Adapter to remove on forward reads | parameter_input | Sequence of the adapter to remove from forward reads using fastp |
| 2 | Adapter to remove on reverse reads | parameter_input | Sequence of the adapter to remove from reverse reads using fastp |
| 3 | Qualified quality score | parameter_input | The quality value that a base is qualified. Default 15 means a quality score &gt;=Q15 is qualified. |
| 4 | Minimal read length | parameter_input | Reads shorter than this value will be discarded |


Ensure your input data is organized as a paired dataset collection containing files in `fastqsanger` or `fastqsanger.gz` format to allow the workflow to process multiple samples efficiently. Verify that the adapter sequences and quality thresholds match your specific sequencing library requirements before execution to ensure optimal trimming results. Consult the `README.md` for comprehensive details on parameter settings and expected output formats. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.1.0+galaxy0 | Quality control and trimming of the raw reads |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.33+galaxy0 | Aggregation of the quality controls for all samples |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | fastp JSON report | report_json |
| 5 | fastp trimmed reads | output_paired_coll |
| 6 | MultiQC HTML report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run short-read-quality-control-and-trimming.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run short-read-quality-control-and-trimming.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run short-read-quality-control-and-trimming.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init short-read-quality-control-and-trimming.ga -o job.yml`
- Lint: `planemo workflow_lint short-read-quality-control-and-trimming.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `short-read-quality-control-and-trimming.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)