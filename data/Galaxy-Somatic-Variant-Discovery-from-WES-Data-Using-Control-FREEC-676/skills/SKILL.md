---
name: somatic-variant-discovery-from-wes-data-using-control-freec
description: "This Galaxy workflow processes paired-end tumor and normal whole exome sequencing (WES) FASTQ files to detect somatic copy number variations using BWA-MEM for alignment and Control-FREEC for variant calling. Use this skill when you need to identify human copy number alterations and visualize genomic structural variations between matched tumor and control samples."
homepage: https://workflowhub.eu/workflows/676
---

# Somatic-Variant-Discovery-from-WES-Data-Using-Control-FREEC

## Overview

This workflow is designed for human somatic copy number variation (hCNV) detection using Whole Exome Sequencing (WES) data. It implements a comparative analysis between tumor and normal samples to identify genomic alterations, following a methodology established in the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials.

The pipeline begins with comprehensive quality control and preprocessing. Raw paired-end reads undergo quality assessment via [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and [MultiQC](https://multiqc.info/), followed by adapter trimming and filtering with [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic). The processed reads are then aligned to the reference genome using [BWA-MEM](http://bio-bwa.sourceforge.net/). To ensure high-quality variant calling, the workflow performs post-alignment refinements, including duplicate removal with Samtools and local realignment using BamLeftAlign.

The core of the analysis is handled by [Control-FREEC](http://boevalab.inf.ethz.ch/FREEC/), which automatically computes copy number profiles and detects somatic variants. It utilizes the provided capture target BED file to normalize coverage and account for GC-content bias. Finally, the workflow generates visual representations of the detected variations using [Circos](http://circos.ca/), producing log2 ratio plots and a high-resolution PNG image of the genomic landscape.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Normal_r1.fastq.gz | data_input |  |
| 1 | Normal_r2.fastq.gz | data_input |  |
| 2 | Tumor_r1.fastq.gz | data_input |  |
| 4 | Tumor_r2.fastq.gz | data_input |  |
| 5 | capture_targets_chr5_12_17.bed | data_input |  |


Ensure all paired-end sequencing data for both normal and tumor samples are uploaded as fastq.gz files, alongside a BED file defining the specific capture targets for the WES assay. While this workflow utilizes individual datasets for the initial mapping steps, organizing your reads into paired dataset collections can streamline pre-processing and quality control via MultiQC. Refer to the README.md for comprehensive instructions on parameter tuning for Control-FREEC and specific reference genome requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and reproducible metadata management.

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
| 33 | out_ratio_log2_circos | out_ratio_log2_circos |
| 33 | out_chr_sorted_circos | out_chr_sorted_circos |
| 34 | output_png | output_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Somatic-Variant-Discovery-from-WES-Data-Using-Control-FREEC.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Somatic-Variant-Discovery-from-WES-Data-Using-Control-FREEC.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Somatic-Variant-Discovery-from-WES-Data-Using-Control-FREEC.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Somatic-Variant-Discovery-from-WES-Data-Using-Control-FREEC.ga -o job.yml`
- Lint: `planemo workflow_lint Somatic-Variant-Discovery-from-WES-Data-Using-Control-FREEC.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Somatic-Variant-Discovery-from-WES-Data-Using-Control-FREEC.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
