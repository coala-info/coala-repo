---
name: covid-19-read-pre-processing
description: "This Galaxy workflow processes forward and reverse COVID-19 sequencing reads using Trim Galore! for quality trimming, BWA-MEM for mapping, and Samtools for filtering and extraction. Use this skill when you need to clean raw SARS-CoV-2 sequencing data and remove human genomic contamination to prepare high-quality reads for downstream variant calling or genome assembly."
homepage: https://workflowhub.eu/workflows/99
---

# COVID-19: read pre-processing

## Overview

This Galaxy workflow provides a standardized pipeline for the initial processing of COVID-19 sequencing data. It is designed to take raw paired-end reads and transform them into high-quality, filtered datasets suitable for downstream applications such as variant calling or de novo assembly.

The process begins with quality and adapter trimming using [Trim Galore!](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/), ensuring that technical artifacts do not interfere with alignment. The trimmed reads are then mapped to a reference genome using [BWA-MEM](https://github.com/lh3/bwa), a robust tool for aligning sequencing reads against a large reference.

Following alignment, the workflow employs [samtool_filter2](https://github.com/samtools/samtools) to refine the results, allowing for the removal of low-quality mappings or unmapped reads. Finally, the processed data is converted back into paired-end FASTQ format using [Samtools fastx](http://www.htslib.org/doc/samtools-fastq.html), providing clean forward and reverse read files as the primary outputs.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Forwards reads | data_input |  |
| 1 | Reverse reads | data_input |  |


Ensure your input files are in fastq or fastq.gz format, representing paired-end sequencing reads. While individual datasets can be used, organizing your reads into a paired dataset collection simplifies the workflow execution and downstream data management. Refer to the README.md file for specific parameter configurations and detailed metadata requirements. You can automate the setup of your execution environment using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Trim Galore! | toolshed.g2.bx.psu.edu/repos/bgruening/trim_galore/trim_galore/0.4.3.1 |  |
| 3 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 4 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 5 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | reverse | reverse |
| 5 | forward | forward |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run COVID-19_read_pre-processing.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run COVID-19_read_pre-processing.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run COVID-19_read_pre-processing.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init COVID-19_read_pre-processing.ga -o job.yml`
- Lint: `planemo workflow_lint COVID-19_read_pre-processing.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `COVID-19_read_pre-processing.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
