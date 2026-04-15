---
name: combined-workflows-for-large-genome-assembly
description: This Galaxy workflow processes long and paired-end short reads to perform large genome assembly using meryl for kmer counting, fastp for trimming, Flye for assembly, and Quast for quality assessment. Use this skill when you need to generate a high-quality de novo assembly for a complex organism and require integrated polishing and validation to ensure genomic accuracy.
homepage: https://usegalaxy.org.au/
metadata:
  docker_image: "N/A"
---

# combined-workflows-for-large-genome-assembly

## Overview

This workflow provides a comprehensive pipeline for the de novo assembly of large genomes using a hybrid approach. It integrates long-read sequencing data with paired-end short reads (R1 and R2) to produce high-quality genomic sequences. The process is designed to handle the computational demands of large-scale assemblies by modularizing key stages into specialized subworkflows.

The pipeline begins with rigorous data preparation, including k-mer counting via [meryl](https://github.com/marbl/meryl) and comprehensive quality control. Short reads are processed through [fastp](https://github.com/OpenGene/fastp) for trimming and filtering, ensuring that only high-quality data informs the downstream assembly. The core assembly is performed using [Flye](https://github.com/fenderglass/Flye), which is optimized for long-read datasets.

Following the initial assembly, the workflow executes a polishing subworkflow to improve consensus accuracy and resolve errors. The final stage involves a thorough quality assessment, utilizing tools like Quast to compare the assembly against a reference genome. This ensures the resulting contigs meet the structural and biological standards required for large-scale genomic studies.

Tagged as **LG-WF**, this combined workflow automates the transition from raw reads to a polished, evaluated assembly. For detailed configuration instructions and tool-specific parameters, please refer to the [README.md](./README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | long reads | data_input |  |
| 1 | R1 | data_input |  |
| 2 | R2 | data_input |  |
| 3 | minimap settings (for long reads) | parameter_input |  |
| 4 | Reference genome for Quast | data_input |  |


Ensure your long reads and paired-end short reads (R1 and R2) are in FASTQ format, ideally organized into a paired dataset collection to streamline the trimming and polishing subworkflows. The reference genome for quality assessment must be a standard FASTA file. For comprehensive guidance on parameter tuning and specific tool versions, refer to the `README.md` file. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | kmer counting - meryl | (subworkflow) |  |
| 6 | Data QC | (subworkflow) |  |
| 7 | Trim and filter reads - fastp | (subworkflow) |  |
| 8 | Assembly with Flye | (subworkflow) |  |
| 9 | Assembly polishing | (subworkflow) |  |
| 10 | Assess genome quality | (subworkflow) |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Combined_workflows_for_large_genome_assembly.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Combined_workflows_for_large_genome_assembly.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Combined_workflows_for_large_genome_assembly.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Combined_workflows_for_large_genome_assembly.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Combined_workflows_for_large_genome_assembly.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Combined_workflows_for_large_genome_assembly.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)