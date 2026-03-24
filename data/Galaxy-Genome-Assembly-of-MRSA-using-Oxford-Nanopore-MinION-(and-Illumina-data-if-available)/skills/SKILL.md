---
name: genome-assembly-of-mrsa-using-oxford-nanopore-minion-and-ill
description: "This Galaxy workflow performs de novo genome assembly of Methicillin-resistant Staphylococcus aureus (MRSA) using Oxford Nanopore long reads and optional Illumina short reads processed through Flye, filtlong, and Polypolish. Use this skill when you need to reconstruct complete bacterial genomes and resolve complex genomic regions to study antimicrobial resistance or pathogen transmission."
homepage: https://workflowhub.eu/workflows/1613
---

# Genome Assembly of MRSA using Oxford Nanopore MinION (and Illumina data if available)

## Overview

This workflow performs *de novo* genome assembly of Methicillin-resistant *Staphylococcus aureus* (MRSA) using long-read Oxford Nanopore MinION data, with the option to incorporate short-read Illumina data for hybrid polishing. The process begins with rigorous quality control and preprocessing, utilizing [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and [fastp](https://github.com/OpenGene/fastp) for short reads, and [NanoPlot](https://github.com/wdecoster/NanoPlot) to assess the long-read data quality both before and after filtering.

The core assembly is generated from long reads that have been optimized via [filtlong](https://github.com/rrwick/Filtlong) to prioritize the highest quality sequences. These reads are then assembled into contigs using [Flye](https://github.com/fenderglass/Flye), a de novo assembler designed for long, noisy reads. The resulting assembly graph can be visualized using [Bandage](https://rrwick.github.io/Bandage/) to inspect the connectivity and structure of the bacterial genome.

To achieve high consensus accuracy, the workflow includes a polishing stage where Illumina paired-end reads are mapped to the Flye assembly using [BWA-MEM2](https://github.com/bwa-mem2/bwa-mem2). These mappings are processed by [Polypolish](https://github.com/rrwick/Polypolish) to correct errors in the long-read assembly. The final quality and completeness of the genome are evaluated using [Quast](https://github.com/ablab/quast) at multiple stages, allowing for a direct comparison of the assembly before and after polishing.

This technical skill is licensed under the MIT license and is tagged for use in Assembly and [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) contexts.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Nanopore raw reads | data_input | Nanopore raw reads |
| 1 | Input Paired End Collection | data_collection_input |  |


Ensure your Nanopore raw reads are in fastq.gz format and provide Illumina short reads as a paired-end dataset collection to maintain sample associations throughout the hybrid assembly process. If you are working with multiple samples, organizing inputs into collections is essential for the workflow to scale correctly. Refer to the `README.md` for comprehensive details on parameter tuning and data preparation. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 3 | Convert compressed file to uncompressed. | CONVERTER_bz2_to_uncompressed |  |
| 4 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy3 |  |
| 5 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.41.0+galaxy0 |  |
| 6 | Flatten collection | __FLATTEN__ |  |
| 7 | Extract dataset | __EXTRACT_DATASET__ |  |
| 8 | Extract dataset | __EXTRACT_DATASET__ |  |
| 9 | filtlong | toolshed.g2.bx.psu.edu/repos/iuc/filtlong/filtlong/0.2.1+galaxy0 |  |
| 10 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.41.0+galaxy0 |  |
| 11 | Flye | toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.9.1+galaxy0 |  |
| 12 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 13 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.2.0+galaxy1 |  |
| 14 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 15 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 16 | Polypolish | toolshed.g2.bx.psu.edu/repos/iuc/polypolish/polypolish/0.5.0+galaxy2 |  |
| 17 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.2.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | report_json | report_json |
| 5 | nanoplot_before_filtering | nanostats |
| 10 | nanoplot_after_filtering | nanostats |
| 11 | flye_assembly_info | assembly_info |
| 13 | quast_report_before_polishing | report_html |
| 17 | quast_report_after_polishing | report_html |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
