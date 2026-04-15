---
name: workflow-generate-dataset-for-assembly-tutorial
description: This Galaxy workflow processes paired-end FASTQ reads through adapter trimming with Cutadapt, de novo assembly with MEGAHIT, and read mapping with Bowtie2 to produce a refined, subsampled genomic dataset. Use this skill when you need to extract a representative and manageable subset of sequencing data from a large metagenomic sample for use in assembly benchmarking or bioinformatics training tutorials.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-generate-dataset-for-assembly-tutorial

## Overview

This workflow is designed to generate curated, manageable datasets for assembly tutorials, specifically supporting [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) materials. It begins by taking paired-end raw sequencing reads and performing adapter trimming and quality filtering using [Cutadapt](https://cutadapt.readthedocs.io/).

Following initial preprocessing, the workflow performs a *de novo* assembly using [MEGAHIT](https://github.com/voutcn/megahit) to create a reference framework. The original reads are then mapped back to these assembled contigs using [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml) to identify and isolate relevant genomic regions.

The final stages involve a sophisticated subsampling routine to reduce the dataset size while maintaining biological relevance. By utilizing [BAM filter](https://github.com/ngsutils/ngsutils), [bamtools](https://github.com/pezmaster31/bamtools), and [seqtk](https://github.com/lh3/seqtk), the workflow extracts a specific subset of reads. The process concludes with [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) reports to validate the quality of the resulting tutorial data.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ERR2231567_1.fastq.gz | data_input |  |
| 1 | ERR2231567_2.fastq.gz | data_input |  |


Ensure your input files are in fastq.gz format and correctly assigned as forward and reverse paired-end reads. While this workflow uses individual datasets, you can also process multiple samples efficiently by using a paired dataset collection. For automated testing and execution, you can initialize a job template using `planemo workflow_job_init` to create a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and data preparation. Always verify that your input metadata is correctly set to ensure compatibility with the downstream mapping and filtering tools.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/4.0+galaxy0 |  |
| 3 | MEGAHIT | toolshed.g2.bx.psu.edu/repos/iuc/megahit/megahit/1.2.9+galaxy0 |  |
| 4 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.4.5+galaxy1 |  |
| 5 | BAM filter | toolshed.g2.bx.psu.edu/repos/iuc/ngsutils_bam_filter/ngsutils_bam_filter/0.5.9 |  |
| 6 | BAM filter | toolshed.g2.bx.psu.edu/repos/iuc/ngsutils_bam_filter/ngsutils_bam_filter/0.5.9 |  |
| 7 | Convert, Merge, Randomize | toolshed.g2.bx.psu.edu/repos/devteam/bamtools/bamtools/2.5.1+galaxy0 |  |
| 8 | Convert, Merge, Randomize | toolshed.g2.bx.psu.edu/repos/devteam/bamtools/bamtools/2.5.1+galaxy0 |  |
| 9 | Select random lines | random_lines1 |  |
| 10 | Select random lines | random_lines1 |  |
| 11 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/2.0.0 |  |
| 12 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/2.0.0 |  |
| 13 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/unique/bg_uniq/0.3 |  |
| 14 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/unique/bg_uniq/0.3 |  |
| 15 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |
| 16 | seqtk_subseq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_subseq/1.3.1 |  |
| 17 | seqtk_subseq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_subseq/1.3.1 |  |
| 18 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 19 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | out1 | out1 |
| 2 | out2 | out2 |
| 2 | report | report |
| 3 | output | output |
| 4 | mapping_stats | mapping_stats |
| 4 | output | output |
| 5 | outfile | outfile |
| 6 | outfile | outfile |
| 7 | out_file1 | out_file1 |
| 8 | out_file1 | out_file1 |
| 9 | out_file1 | out_file1 |
| 10 | out_file1 | out_file1 |
| 11 | output | output |
| 12 | output | output |
| 13 | outfile | outfile |
| 14 | outfile | outfile |
| 15 | out_file1 | out_file1 |
| 16 | default | default |
| 17 | default | default |
| 18 | text_file | text_file |
| 18 | html_file | html_file |
| 19 | html_file | html_file |
| 19 | text_file | text_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow-generate-dataset-for-assembly-tutorial.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow-generate-dataset-for-assembly-tutorial.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow-generate-dataset-for-assembly-tutorial.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow-generate-dataset-for-assembly-tutorial.ga -o job.yml`
- Lint: `planemo workflow_lint workflow-generate-dataset-for-assembly-tutorial.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow-generate-dataset-for-assembly-tutorial.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)