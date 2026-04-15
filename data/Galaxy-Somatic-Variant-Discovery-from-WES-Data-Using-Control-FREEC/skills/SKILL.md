---
name: somatic-variant-discovery-from-wes-data-using-control-freec
description: This Galaxy workflow identifies somatic copy number variations from paired tumor and normal whole exome sequencing FASTQ files using BWA-MEM for mapping and Control-FREEC for CNV detection and visualization. Use this skill when you need to detect large-scale genomic alterations, such as amplifications or deletions, in cancer exomes to understand the genetic drivers of tumor progression.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# somatic-variant-discovery-from-wes-data-using-control-freec

## Overview

This workflow is designed for somatic copy number variation (CNV) detection using Whole Exome Sequencing (WES) data from paired tumor and normal samples. Developed as part of a [GTN tutorial](https://training.galaxyproject.org/), it provides a standardized pipeline for identifying genomic alterations in human samples, specifically utilizing the Control-FREEC tool for ratio calculation and normalization.

The pipeline begins with rigorous quality control and data cleaning. Raw FASTQ reads undergo quality assessment via [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and [MultiQC](https://multiqc.info/), followed by adapter trimming and filtering with [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic). Cleaned reads are then aligned to the reference genome using [BWA-MEM](http://bio-bwa.sourceforge.net/), with subsequent post-processing steps including duplicate removal and local realignment via [Samtools](http://www.htslib.org/) and BamLeftAlign to ensure high-quality BAM files for downstream analysis.

The core analysis is performed by [Control-FREEC](http://boevalab.inf.ethz.ch/FREEC/), which automatically computes copy number profiles, detects LOH (Loss of Heterozygosity), and normalizes for GC content and mappability using the provided capture target BED file. The workflow concludes by generating comprehensive outputs, including ratio files, subclone information, and a circular genomic visualization created with [Circos](http://circos.ca/) to facilitate the interpretation of somatic variants.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Normal_r1.fastq.gz | data_input |  |
| 1 | Normal_r2.fastq.gz | data_input |  |
| 2 | Tumor_r1.fastq.gz | data_input |  |
| 4 | Tumor_r2.fastq.gz | data_input |  |
| 5 | capture_targets_chr5_12_17.bed | data_input |  |


Ensure all sequencing data is provided in compressed FASTQ.GZ format and the capture targets are supplied as a standard BED file to ensure compatibility with BWA-MEM and Control-FREEC. While the workflow accepts individual datasets for the normal and tumor pairs, organizing these into paired-end collections can significantly streamline the mapping and quality control stages. Please consult the README.md for exhaustive details on reference genome selection and specific tool parameters. You can quickly generate a template for these inputs by using the planemo workflow_job_init command to create a job.yml file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/1.1.0 |  |
| 6 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 7 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.39+galaxy0 |  |
| 8 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 9 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 10 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.39+galaxy0 |  |
| 11 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 12 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 13 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.2 |  |
| 14 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 15 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 16 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.2 |  |
| 17 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 18 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 19 | Build list | __BUILD_LIST__ |  |
| 20 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 21 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 22 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.15.1+galaxy0 |  |
| 23 | RmDup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1 |  |
| 24 | BamLeftAlign | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/bamleftalign/1.3.6 |  |
| 25 | Samtools calmd | toolshed.g2.bx.psu.edu/repos/devteam/samtools_calmd/samtools_calmd/2.0.3 |  |
| 26 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.15.1+galaxy0 |  |
| 27 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.15.1+galaxy0 |  |
| 28 | Select | Grep1 |  |
| 29 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.2 |  |
| 30 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.15.1+galaxy0 |  |
| 31 | Extract dataset | __EXTRACT_DATASET__ |  |
| 32 | Extract dataset | __EXTRACT_DATASET__ |  |
| 33 | Control-FREEC | toolshed.g2.bx.psu.edu/repos/iuc/control_freec/control_freec/11.6+galaxy2 |  |
| 34 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy9 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 33 | out_sample_info | out_sample_info |
| 33 | out_sample_coord | out_sample_coord |
| 33 | out_control_raw | out_control_raw |
| 33 | out_sample_raw | out_sample_raw |
| 33 | out_ratio_log2_circos | out_ratio_log2_circos |
| 33 | out_chr_sorted_circos | out_chr_sorted_circos |
| 33 | out_gc_profile | out_gc_profile |
| 33 | out_mg_log2_png | out_mg_log2_png |
| 33 | out_mg_png | out_mg_png |
| 33 | out_sample_subclones | out_sample_subclones |
| 33 | out_sample_ratio | out_sample_ratio |
| 34 | output_png | output_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run somatic-variant-discovery-from-wes-data-using-control-freec.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run somatic-variant-discovery-from-wes-data-using-control-freec.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run somatic-variant-discovery-from-wes-data-using-control-freec.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init somatic-variant-discovery-from-wes-data-using-control-freec.ga -o job.yml`
- Lint: `planemo workflow_lint somatic-variant-discovery-from-wes-data-using-control-freec.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `somatic-variant-discovery-from-wes-data-using-control-freec.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)