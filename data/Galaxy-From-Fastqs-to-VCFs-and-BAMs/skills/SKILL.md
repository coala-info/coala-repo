---
name: from-fastqs-to-vcfs-and-bams
description: "This Galaxy workflow processes single-end and paired-end FASTQ sequencing data using Trimmomatic, Snippy, and TB Variant Filter to produce aligned BAM files and filtered VCF variant calls against a Mycobacterium tuberculosis reference. Use this skill when you need to identify high-quality genomic variants and SNPs in bacterial samples to analyze evolutionary patterns or investigate pathogen outbreaks."
homepage: https://workflowhub.eu/workflows/1573
---

# From Fastqs to VCFs and BAMs

## Overview

This workflow provides a comprehensive pipeline for transforming raw sequencing data into high-quality variant calls and alignments. It is designed to handle both single-end and paired-end FASTQ collections, utilizing a specific reference genome—such as the *Mycobacterium tuberculosis* ancestral reference—to guide the assembly and identification process.

The analysis begins with read preprocessing using [Trimmomatic](https://toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.1) to remove adapter sequences and low-quality bases. Once cleaned, the reads are processed through [Snippy](https://toolshed.g2.bx.psu.edu/repos/iuc/snippy/snippy/4.6.0+galaxy0), which performs rapid haploid variant calling and generates aligned BAM files. This tool is essential for identifying substitutions (SNPs) and insertions/deletions (indels) relative to the reference.

In the final stages, the workflow merges data collections and applies a specialized [TB Variant Filter](https://toolshed.g2.bx.psu.edu/repos/iuc/tb_variant_filter/tb_variant_filter/0.3.5+galaxy2) to refine the results. The primary outputs include filtered VCF files, SNP tables, and BAM files, providing a ready-to-use dataset for evolutionary analysis and genomic surveillance. This pipeline is often associated with [GTN](https://training.galaxyproject.org/) training materials for microbial genomics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Single-End FASTQs | data_collection_input |  |
| 1 | Paired-End FASTQs | data_collection_input |  |
| 2 | Mycobacterium_tuberculosis_ancestral_reference.gbk | data_input |  |


Ensure your input FASTQ files are organized into list collections (paired or single-end) and that the reference genome is provided in GenBank (.gbk) format. Using collections is essential for this workflow to correctly batch process multiple samples through Trimmomatic and Snippy before merging results. Refer to the README.md for specific parameter configurations and detailed metadata requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.1 |  |
| 4 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.1 |  |
| 5 | snippy | toolshed.g2.bx.psu.edu/repos/iuc/snippy/snippy/3.2 |  |
| 6 | snippy | toolshed.g2.bx.psu.edu/repos/iuc/snippy/snippy/4.6.0+galaxy0 |  |
| 7 | Merge collections | __MERGE_COLLECTION__ |  |
| 8 | Merge collections | __MERGE_COLLECTION__ |  |
| 9 | TB Variant Filter | toolshed.g2.bx.psu.edu/repos/iuc/tb_variant_filter/tb_variant_filter/0.3.5+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | fastq_out | fastq_out |
| 4 | fastq_out_paired | fastq_out_paired |
| 4 | fastq_out_unpaired | fastq_out_unpaired |
| 5 | snpsbam | snpsbam |
| 5 | snpvcf | snpvcf |
| 5 | snptab | snptab |
| 6 | snptab | snptab |
| 6 | snpsbam | snpsbam |
| 6 | snpvcf | snpvcf |
| 7 | output | output |
| 9 | output1 | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-from-fastqs-to-vcfs-and-bams.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-from-fastqs-to-vcfs-and-bams.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-from-fastqs-to-vcfs-and-bams.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-from-fastqs-to-vcfs-and-bams.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-from-fastqs-to-vcfs-and-bams.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-from-fastqs-to-vcfs-and-bams.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
