---
name: genome-assembly-workflow-for-nanopore-reads-for-tsi
description: "This Galaxy workflow processes raw Nanopore sequencing reads through a pipeline of quality control, adapter trimming with Porechop, and filtering before performing de novo assembly using the Flye assembler. Use this skill when you need to reconstruct complete genomes from long-read data and evaluate the resulting assembly quality through statistical metrics and Bandage visualization graphs."
homepage: https://workflowhub.eu/workflows/1114
---

# Genome assembly workflow for nanopore reads, for TSI

## Overview

This Galaxy workflow provides an end-to-end pipeline for de novo genome assembly using Oxford Nanopore sequencing reads. It is designed to handle raw data in various FASTQ formats, performing initial quality assessment via [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0) before proceeding to rigorous read cleaning and assembly.

The preprocessing stage optimizes performance by splitting input files to parallelize adapter removal with [Porechop](https://toolshed.g2.bx.psu.edu/repos/iuc/porechop/porechop/0.2.4+galaxy0). Reads are further refined using [NanoFilt](https://toolshed.g2.bx.psu.edu/repos/leomrtns/nanofilt/nanofilt/0.1.0) to filter by minimum quality and length, and to trim leading nucleotides. Users can customize these parameters based on their specific library characteristics to ensure high-quality input for the downstream assembler.

Cleaned reads are assembled into contigs using [Flye](https://toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9.3+galaxy0), a versatile de novo assembler for long, noisy reads. The workflow concludes by generating comprehensive assembly metrics through [Fasta Statistics](https://toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.3) and visualizing the assembly graph with [Bandage](https://toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy3), providing both the primary consensus sequence and structural insights into the genome.

This workflow is licensed under GPL-3.0-or-later and is tagged for genome assembly and nanopore sequencing applications. It is recommended to assess raw read characteristics using tools like NanoPlot prior to execution to determine the most effective filtering and trimming thresholds.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Sequencing reads (in any of these formats: fastq, fastq.gz, fastqsanger, fastqsanger.gz) | data_input |  |
| 1 | How many new files to split into during read filtering stage? | parameter_input | Split input to speed up next step with Porechop. e.g. if input fastq is 60 GB, split into 2000 files of approx 30 MB. |
| 2 | Minimum average read quality score to filter on | parameter_input |  |
| 3 | Minimum read length to filter on | parameter_input |  |
| 4 | Trim this many nucleotides from start of read | parameter_input |  |


Ensure your nanopore reads are in fastq, fastq.gz, or fastqsanger format to ensure compatibility with the initial quality control and processing steps. While the workflow begins with a single dataset, it utilizes internal collections to parallelize the Porechop and NanoFilt stages; you should adjust the split parameter to balance processing speed with your specific file size. Be careful not to set filtering and trimming thresholds too high, as this can lead to an empty dataset and cause the Flye assembly step to fail. For a complete breakdown of parameter recommendations and tool configurations, please consult the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 6 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.2 |  |
| 7 | Porechop | toolshed.g2.bx.psu.edu/repos/iuc/porechop/porechop/0.2.4+galaxy0 |  |
| 8 | NanoFilt | toolshed.g2.bx.psu.edu/repos/leomrtns/nanofilt/nanofilt/0.1.0 |  |
| 9 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 10 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 11 | Flye | toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9.3+galaxy0 | default setting changed: remove non-primary contigs from assembly = yes |
| 12 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/1.0.3 |  |
| 13 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy1 |  |
| 14 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | text_file | text_file |
| 5 | html_file | html_file |
| 9 | output | output |
| 11 | assembly_graph | assembly_graph |
| 11 | assembly_gfa | assembly_gfa |
| 11 | assembly_info | assembly_info |
| 11 | flye_log | flye_log |
| 11 | consensus | consensus |
| 12 | metrics | stats |
| 13 | primary bandage info | outfile |
| 14 | primary bandage image | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Genome_assembly_workflow_for_nanopore_reads_for_TSI.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Genome_assembly_workflow_for_nanopore_reads_for_TSI.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Genome_assembly_workflow_for_nanopore_reads_for_TSI.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Genome_assembly_workflow_for_nanopore_reads_for_TSI.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Genome_assembly_workflow_for_nanopore_reads_for_TSI.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Genome_assembly_workflow_for_nanopore_reads_for_TSI.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
