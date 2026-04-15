---
name: gtn-sequence-analyses-mapping
description: This Galaxy workflow processes a collection of sequencing reads through quality control and trimming before aligning them to a reference genome using Bowtie2. Use this skill when you need to assess the quality of raw sequencing data and generate filtered alignment files for downstream genomic analysis or visualization.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gtn-sequence-analyses-mapping

## Overview

This workflow, part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), provides a standardized pipeline for mapping sequencing reads to a reference genome. It begins by processing an input dataset collection, utilizing [Trim Galore!](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/) for adapter and quality trimming, while simultaneously running [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to assess the initial quality of the raw data.

The core alignment is performed using [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml), a fast and memory-efficient tool for aligning sequencing reads. Following the mapping process, the workflow employs [Bamtools Filter](https://github.com/pezmaster31/bamtools) to refine the alignment results. To monitor the impact of these filters, [Samtools Stats](http://www.htslib.org/doc/samtools-stats.html) are generated both before and after the filtering step, providing clear metrics on data retention and mapping quality.

For final data interpretation, the workflow integrates [MultiQC](https://multiqc.info/) to aggregate various tool reports into a single, interactive summary. It also prepares the mapped data for genomic visualization via [JBrowse](https://jbrowse.org/), allowing users to explore the alignments within their genomic context. This CC-BY-4.0 licensed resource is a foundational tool for sequence analysis and quality control in Galaxy.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset collection | data_collection_input |  |


Ensure your input is a paired-end dataset collection containing FASTQ files to match the expected workflow structure for automated trimming and mapping. While the workflow processes collections, verify that your reference genome is correctly selected or indexed within the Bowtie2 step to ensure successful alignment. Refer to the README.md for comprehensive instructions on data formatting and specific parameter configurations. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Flatten collection | __FLATTEN__ |  |
| 2 | Trim Galore! | toolshed.g2.bx.psu.edu/repos/bgruening/trim_galore/trim_galore/0.4.3.1 |  |
| 3 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 4 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0 |  |
| 5 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.9 |  |
| 6 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 |  |
| 7 | Stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.1 |  |
| 8 | Filter | toolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/2.4.1 |  |
| 9 | Stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | bowtie2_mapping_stats | mapping_stats |
| 7 | bam_stats_1 | output |
| 9 | bam_stats_2 | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run mapping.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run mapping.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run mapping.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init mapping.ga -o job.yml`
- Lint: `planemo workflow_lint mapping.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `mapping.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)