---
name: identification-of-the-binding-sites-of-the-estrogen-receptor
description: This Galaxy workflow processes FASTQ sequencing data to identify Estrogen Receptor binding sites using FastQC for quality control, Trim Galore! for adapter trimming, and Bowtie2 for genomic mapping. Use this skill when you need to perform quality assessment and alignment of ChIP-seq data to characterize the epigenetic landscape of Estrogen Receptor interactions in clinical samples.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# identification-of-the-binding-sites-of-the-estrogen-receptor

## Overview

This workflow provides a standardized pipeline for the initial processing of ChIP-seq data, specifically focused on identifying Estrogen Receptor binding sites. Developed in alignment with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) materials for epigenetics, it automates the essential steps of quality assessment and sequence alignment for raw genomic data.

The process begins with quality control using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/), which generates a comprehensive report on the raw sequencing reads. To ensure high-quality downstream analysis, the workflow then employs [Trim Galore!](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/) to remove adapter sequences and trim low-quality bases from the input FASTQ files.

Following preprocessing, the cleaned reads are mapped to a reference genome using [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml), a highly efficient tool for aligning short DNA sequences. The final step involves converting the resulting binary alignment data into a human-readable format via the BAM-to-SAM tool, preparing the data for further epigenetic analysis and peak calling.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | patient1_input_good_outcome.fastq.txt | data_input |  |


Ensure your input files are in FASTQ format, noting that they may carry a `.txt` extension depending on your data source. While the workflow is configured for individual datasets, using data collections is highly recommended if you are processing multiple patient samples simultaneously to maintain organization. Please consult the `README.md` for exhaustive documentation on required reference genomes and specific tool parameters. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.69 |  |
| 2 | Trim Galore! | toolshed.g2.bx.psu.edu/repos/bgruening/trim_galore/trim_galore/0.4.3.0 |  |
| 3 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.2.2 |  |
| 4 | BAM-to-SAM | toolshed.g2.bx.psu.edu/repos/devteam/bam_to_sam/bam_to_sam/2.0.1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run qc-mapping.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run qc-mapping.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run qc-mapping.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init qc-mapping.ga -o job.yml`
- Lint: `planemo workflow_lint qc-mapping.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `qc-mapping.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)