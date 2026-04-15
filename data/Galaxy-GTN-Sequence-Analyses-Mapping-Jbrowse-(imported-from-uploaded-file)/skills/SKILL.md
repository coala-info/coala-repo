---
name: gtn-sequence-analyses-mapping-jbrowse-imported-from-uploaded
description: This sequence analysis workflow processes paired-end reads through quality control with FastQC and Trim Galore!, performs genomic mapping using Bowtie2, and generates an interactive visualization with JBrowse. Use this skill when you need to assess the quality of raw sequencing data, align reads to a reference genome, and visually inspect the resulting alignments for genomic features or variants.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gtn-sequence-analyses-mapping-jbrowse-imported-from-uploaded

## Overview

This Galaxy workflow provides a standardized pipeline for sequence mapping and visualization, following the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) methodology. It begins with comprehensive quality control of paired-end reads using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and [Trim Galore!](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/), ensuring that adapters and low-quality bases are removed before downstream analysis.

Following preprocessing, the reads are aligned to a reference genome using [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml). The workflow then generates detailed mapping statistics via [Samtools stats](http://www.htslib.org/doc/samtools-stats.html) and aggregates all quality metrics into a single, interactive report using [MultiQC](https://multiqc.info/). This allows for a quick assessment of the alignment success and data consistency.

The final stage of the pipeline integrates the results into [JBrowse](https://jbrowse.org/jbrowse1/), a web-based genome browser. This enables researchers to visually inspect the mapped reads against the reference genome, facilitating the identification of genomic features, coverage patterns, and potential variants within the Galaxy environment.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | reads_1 | data_input |  |
| 1 | reads_2 | data_input |  |


Ensure your input reads are in FASTQ format, and verify that a suitable reference genome is available in your history or as a built-in index for Bowtie2. While individual datasets can be used for the paired reads, organizing them into a paired dataset collection simplifies the workflow execution across Trim Galore and mapping steps. Refer to the `README.md` for comprehensive details on specific parameter configurations and data preparation requirements. You may also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and metadata management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 3 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 4 | Trim Galore! | toolshed.g2.bx.psu.edu/repos/bgruening/trim_galore/trim_galore/0.4.3.1 |  |
| 5 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.9+galaxy1 |  |
| 6 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.4.2+galaxy0 |  |
| 7 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.2+galaxy2 |  |
| 8 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | html_report | html_report |
| 6 | bowtie2_mapping_stats | mapping_stats |
| 7 | bam_stats_1 | output |
| 8 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run mapping-jbrowse.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run mapping-jbrowse.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run mapping-jbrowse.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init mapping-jbrowse.ga -o job.yml`
- Lint: `planemo workflow_lint mapping-jbrowse.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `mapping-jbrowse.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)