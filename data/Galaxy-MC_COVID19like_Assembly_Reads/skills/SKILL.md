---
name: mc_covid19like_assembly_reads
description: "This Galaxy workflow processes paired-end sequencing reads for COVID-19-like viral genomics using fastp for quality control, Bowtie2 for read filtering, and Unicycler and SPAdes for de novo assembly. Use this skill when you need to reconstruct high-quality viral consensus sequences or scaffolds from raw Illumina reads during an outbreak investigation or genomic surveillance."
homepage: https://workflowhub.eu/workflows/68
---

# MC_COVID19like_Assembly_Reads

## Overview

This Galaxy workflow is designed for the assembly of COVID-19-like viral genomes from paired-end sequencing reads. It streamlines the process of transforming raw forward and reverse data into high-quality genomic scaffolds, specifically optimized for viral research and the `covid-19` tag.

The pipeline begins with quality control and preprocessing using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1), which handles read trimming and filtering. It incorporates multiple [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0) alignment steps to filter out host reads or isolate specific viral sequences, ensuring that the downstream assembly is performed on a refined subset of genetic material.

For the assembly phase, the workflow utilizes two robust de novo assemblers: [Unicycler](https://toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.6.0) and [SPAdes](https://toolshed.g2.bx.psu.edu/repos/nml/spades/spades/3.12.0+galaxy1). These tools generate final assemblies and scaffolds, while additional mapping steps provide detailed statistics and aligned read files to validate the coverage and accuracy of the reconstructed viral genome.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Forward reads | data_input |  |
| 1 | Reverse read | data_input |  |


For this workflow, ensure your input forward and reverse reads are in fastqsanger or fastqsanger.gz format to maintain compatibility with fastp and Bowtie2. While individual datasets can be used, organizing paired-end reads into a dataset collection simplifies the execution of the multi-step assembly process. Refer to the README.md for comprehensive details on parameter settings and reference genome requirements. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0 |  |
| 3 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 4 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0 |  |
| 5 | Create assemblies with Unicycler | toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.6.0 |  |
| 6 | SPAdes | toolshed.g2.bx.psu.edu/repos/nml/spades/spades/3.12.0+galaxy1 |  |
| 7 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0 |  |
| 8 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | output_unaligned_reads_l | output_unaligned_reads_l |
| 2 | output_unaligned_reads_r | output_unaligned_reads_r |
| 3 | out1 | out1 |
| 3 | out2 | out2 |
| 3 | report_html | report_html |
| 4 | output | output |
| 4 | output_aligned_reads_l | output_aligned_reads_l |
| 4 | output_aligned_reads_r | output_aligned_reads_r |
| 4 | mapping_stats | mapping_stats |
| 5 | assembly | assembly |
| 6 | out_scaffolds | out_scaffolds |
| 6 | out_scaffold_stats | out_scaffold_stats |
| 7 | output_aligned_reads_l | output_aligned_reads_l |
| 7 | output_aligned_reads_r | output_aligned_reads_r |
| 7 | mapping_stats | mapping_stats |
| 8 | output_aligned_reads_l | output_aligned_reads_l |
| 8 | output_aligned_reads_r | output_aligned_reads_r |
| 8 | mapping_stats | mapping_stats |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-MC_COVID19like_Assembly_Reads.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-MC_COVID19like_Assembly_Reads.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-MC_COVID19like_Assembly_Reads.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-MC_COVID19like_Assembly_Reads.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-MC_COVID19like_Assembly_Reads.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-MC_COVID19like_Assembly_Reads.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
